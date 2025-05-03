class EquipmentPhoto < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :equipment, presence: true
  validates :photo, presence: true
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :equipment
  
  # Upload de arquivo
  has_one_attached :photo
  
  # Enums
  enum photo_type: {
    main: 0,
    detail: 1,
    documentation: 2,
    other: 3
  }
  
  # Callbacks
  before_validation :set_default_photo_type, on: :create
  
  private
  
  def set_default_photo_type
    self.photo_type ||= :other
  end
end 