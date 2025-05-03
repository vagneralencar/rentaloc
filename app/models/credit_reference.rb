class CreditReference < ApplicationRecord
  acts_as_tenant(:tenant)

  # Relacionamentos
  belongs_to :tenant
  belongs_to :person

  # Validações
  validates :reference_type, presence: true
  validates :name, presence: true
  validates :contact_name, presence: true
  validates :phone, presence: true

  # Enums
  enum reference_type: {
    commercial: 0,   # Referência Comercial
    bank: 1,        # Referência Bancária
    personal: 2     # Referência Pessoal
  }

  # Scopes
  scope :commercial_references, -> { where(reference_type: :commercial) }
  scope :bank_references, -> { where(reference_type: :bank) }
  scope :personal_references, -> { where(reference_type: :personal) }
end 