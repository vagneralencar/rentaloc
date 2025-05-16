class EquipmentDocument < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :equipment, presence: true
  validates :document, presence: true
  validates :description, presence: true
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :equipment
  belongs_to :user, optional: true
  
  # Upload de arquivo
  has_one_attached :file
  
  # Enums
  enum document_type: {
    manual: 'manual',
    nota_fiscal: 'nota_fiscal',
    garantia: 'garantia',
    certificado: 'certificado',
    outro: 'outro'
  }
  
  # Callbacks
  before_validation :set_user, on: :create
  
  private
  
  def set_user
    self.user = Current.user if Current.user
  end
end 