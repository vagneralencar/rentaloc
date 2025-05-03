class TaxRule < ApplicationRecord
  acts_as_tenant(:tenant)

  # Relacionamentos
  belongs_to :tenant
  belongs_to :taxable, polymorphic: true

  # Validações
  validates :tax_type, presence: true
  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :calculation_base, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :withholding, inclusion: { in: [true, false] }
  validates :fiscal_code, presence: true
  validates :fiscal_code_description, presence: true

  # Enums
  enum tax_type: {
    iss: 0,
    pis: 1,
    cofins: 2,
    ir: 3,
    csll: 4,
    icms: 5,
    ipi: 6
  }

  # Scopes
  scope :withholding, -> { where(withholding: true) }
  scope :non_withholding, -> { where(withholding: false) }
  scope :by_tax_type, ->(type) { where(tax_type: type) }

  # Métodos
  def calculate_tax(base_value)
    return 0 if base_value.blank? || rate.blank? || calculation_base.blank?
    
    tax_base = base_value * (calculation_base / 100.0)
    tax_base * (rate / 100.0)
  end

  def calculate_withholding(base_value)
    return 0 unless withholding?
    calculate_tax(base_value)
  end
end 