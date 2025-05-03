class CostCenter < ApplicationRecord
  include MultiTenant

  # Relacionamentos
  belongs_to :tenant
  belongs_to :parent, class_name: 'CostCenter', optional: true
  has_many :children, class_name: 'CostCenter', foreign_key: :parent_id, dependent: :destroy
  has_many :financial_entry_allocations
  has_many :financial_entries, through: :financial_entry_allocations
  has_many :observations, as: :observable, dependent: :destroy
  belongs_to :category, -> { where(category_type: :cost_center) }

  # Nested attributes
  accepts_nested_attributes_for :observations, allow_destroy: true

  # Enums
  enum status: {
    active: 0,
    inactive: 1
  }

  # Validações
  validates :code, presence: true, uniqueness: { scope: :tenant_id }
  validates :name, presence: true
  validates :budget, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validate :parent_from_same_tenant
  validate :prevent_self_parent

  # Callbacks
  before_validation :set_default_status, on: :create
  before_validation :generate_code, on: :create

  # Scopes
  scope :active, -> { where(status: :active) }
  scope :inactive, -> { where(status: :inactive) }
  scope :roots, -> { where(parent_id: nil) }
  scope :by_category, ->(category_id) { where(category_id: category_id) }

  # Métodos
  def total_allocated
    financial_entry_allocations.sum(:amount)
  end

  def budget_available
    return nil if budget.nil?
    budget - total_allocated
  end

  def budget_percentage_used
    return 0 if budget.nil? || budget.zero?
    (total_allocated / budget * 100).round(2)
  end

  private

  def set_default_status
    self.status ||= :active
  end

  def generate_code
    return if code.present?
    
    category_prefix = category&.code || 'CC'
    last_code = tenant.cost_centers
                     .where("code LIKE ?", "#{category_prefix}%")
                     .order(code: :desc)
                     .first&.code
    
    sequence = if last_code
                 last_code.match(/\d+$/)[0].to_i + 1
               else
                 1
               end
    
    self.code = "#{category_prefix}#{sequence.to_s.rjust(4, '0')}"
  end

  def parent_from_same_tenant
    return unless parent.present?
    
    if parent.tenant_id != tenant_id
      errors.add(:parent_id, 'deve pertencer ao mesmo tenant')
    end
  end

  def prevent_self_parent
    return unless parent_id.present?
    
    if parent_id == id
      errors.add(:parent_id, 'não pode ser o próprio centro de custo')
    end
  end
end 