class EquipmentMaintenancePart < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :equipment_maintenance, presence: true
  validates :name, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :equipment_maintenance
  
  # Callbacks
  before_validation :calculate_total_price, on: :create
  
  private
  
  def calculate_total_price
    return if quantity.blank? || unit_price.blank?
    
    self.total_price = quantity * unit_price
  end
end 