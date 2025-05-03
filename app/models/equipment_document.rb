class EquipmentDocument < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :equipment, presence: true
  validates :document, presence: true
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :equipment
  
  # Upload de arquivo
  has_one_attached :document
  
  # Enums
  enum document_type: {
    manual: 0,
    warranty: 1,
    invoice: 2,
    certification: 3,
    other: 4
  }
  
  # Callbacks
  before_validation :set_default_document_type, on: :create
  
  private
  
  def set_default_document_type
    self.document_type ||= :other
  end
end 