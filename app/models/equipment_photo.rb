class EquipmentPhoto < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :equipment, presence: true
  validates :photo, presence: true
  validates :description, presence: true
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :equipment
  belongs_to :user, optional: true
  
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
  before_validation :set_user, on: :create
  
  private
  
  def set_default_photo_type
    self.photo_type ||= :other
  end
  
  def set_user
    self.user = Current.user if Current.user
  end
end 