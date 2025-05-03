class EquipmentMaintenanceDocument < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :equipment_maintenance, presence: true
  validates :document, presence: true
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :equipment_maintenance
  
  # Upload de arquivo
  has_one_attached :document
  
  # Enums
  enum document_type: {
    report: 0,
    invoice: 1,
    warranty: 2,
    other: 3
  }
  
  # Callbacks
  before_validation :set_default_document_type, on: :create
  
  private
  
  def set_default_document_type
    self.document_type ||= :other
  end
end 