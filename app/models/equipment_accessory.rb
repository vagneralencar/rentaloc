class EquipmentAccessory < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :equipment, presence: true
  validates :accessory, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :equipment
  belongs_to :accessory, class_name: 'Equipment'
  belongs_to :user, optional: true
  
  # Enums
  enum status: {
    active: 0,
    inactive: 1,
    maintenance: 2,
    lost: 3
  }
  
  # Callbacks
  before_validation :set_default_status, on: :create
  before_validation :set_user, on: :create
  
  private
  
  def set_default_status
    self.status ||= :active
  end

  def set_user
    self.user = Current.user if Current.user
  end
end 