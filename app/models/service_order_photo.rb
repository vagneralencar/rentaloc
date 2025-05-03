class ServiceOrderPhoto < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :service_order, presence: true
  validates :photo, presence: true
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :service_order
  
  # Upload de arquivo
  has_one_attached :photo
  
  # Enums
  enum photo_type: {
    before: 0,
    after: 1,
    during: 2,
    other: 3
  }
  
  # Callbacks
  before_validation :set_default_photo_type, on: :create
  
  private
  
  def set_default_photo_type
    self.photo_type ||= :other
  end
end 