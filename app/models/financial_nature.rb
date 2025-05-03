class FinancialNature < ApplicationRecord
  acts_as_tenant(:tenant)

  # Relacionamentos
  belongs_to :tenant
  belongs_to :parent, class_name: 'FinancialNature', optional: true
  has_many :children, class_name: 'FinancialNature', foreign_key: :parent_id, dependent: :destroy
  has_many :financial_entries
  has_many :observations, as: :observable, dependent: :destroy

  # Nested attributes
  accepts_nested_attributes_for :observations, allow_destroy: true

  # Enums
  enum status: {
    active: 0,
    inactive: 1
  }

  enum nature_type: {
    revenue: 0,      # Receita
    expense: 1       # Despesa
  }

  # Validações
  validates :code, presence: true, uniqueness: { scope: :tenant_id }
  validates :name, presence: true
  validates :nature_type, presence: true
  validate :parent_from_same_tenant
  validate :prevent_self_parent
  validate :parent_same_nature_type

  # Callbacks
  before_validation :set_default_status, on: :create
  before_validation :generate_code, on: :create

  # Scopes
  scope :active, -> { where(status: :active) }
  scope :inactive, -> { where(status: :inactive) }
  scope :revenues, -> { where(nature_type: :revenue) }
  scope :expenses, -> { where(nature_type: :expense) }
  scope :roots, -> { where(parent_id: nil) }

  private

  def set_default_status
    self.status ||= :active
  end

  def generate_code
    return if code.present?
    prefix = nature_type == 'revenue' ? 'R' : 'D'
    last_code = tenant.financial_natures.where(nature_type: nature_type).maximum(:code)
    self.code = last_code ? last_code.next : "#{prefix}0001"
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
      errors.add(:parent_id, 'não pode ser a própria natureza financeira')
    end
  end

  def parent_same_nature_type
    return unless parent.present?
    
    if parent.nature_type != nature_type
      errors.add(:parent_id, 'deve ter o mesmo tipo de natureza (receita/despesa)')
    end
  end
end 