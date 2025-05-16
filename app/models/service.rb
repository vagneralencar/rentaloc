class Service < ApplicationRecord
  include MultiTenant

  # Relacionamentos
  belongs_to :tenant
  belongs_to :category, optional: true
  has_many :service_tax_rules, dependent: :destroy
  has_many :service_order_services, dependent: :restrict_with_error
  has_many :service_orders, through: :service_order_services
  has_many :tax_rules, as: :taxable, dependent: :destroy
  has_many :observations, as: :observable, dependent: :destroy

  # Nested attributes
  accepts_nested_attributes_for :service_tax_rules, allow_destroy: true
  accepts_nested_attributes_for :tax_rules, allow_destroy: true
  accepts_nested_attributes_for :observations, allow_destroy: true

  # Enums
  enum status: {
    active: 0,
    inactive: 1
  }

  enum service_type: {
    labor: 0,
    material: 1,
    equipment: 2,
    other: 3
  }

  # Validações
  validates :code, presence: true, uniqueness: { scope: :tenant_id }
  validates :name, presence: true
  validates :status, presence: true
  validates :unit, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :nfs_description, presence: true

  # Callbacks
  before_validation :generate_code, on: :create
  before_validation :set_defaults

  # Scopes
  scope :active, -> { where(status: :active) }
  scope :inactive, -> { where(status: :inactive) }
  scope :by_category, ->(category_id) { where(category_id: category_id) }

  # Métodos
  def tax_rule_for(city_code)
    service_tax_rules.find_by(city_code: city_code)
  end

  def total_tax_percentage(city_code = nil)
    return 0 unless city_code
    
    rule = tax_rule_for(city_code)
    return 0 unless rule
    
    rule.iss_rate.to_f +
    rule.pis_rate.to_f +
    rule.cofins_rate.to_f +
    rule.ir_rate.to_f +
    rule.csll_rate.to_f
  end

  private

  def generate_code
    return if code.present?
    
    category_prefix = category&.code || 'SV'
    last_code = tenant.services
                     .where("code LIKE ?", "#{category_prefix}%")
                     .order(code: :desc)
                     .first&.code
    
    sequence = if last_code
                 last_code.match(/\d+$/)[0].to_i + 1
               else
                 1
               end
    
    self.code = "#{category_prefix}#{sequence.to_s.rjust(6, '0')}"
  end

  def set_defaults
    self.status ||= :active
    self.service_type ||= :other
  end
end