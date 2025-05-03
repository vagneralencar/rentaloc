class EquipmentMaintenanceOtherCost < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :equipment_maintenance, presence: true
  validates :description, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :equipment_maintenance
  
  # Enums
  enum cost_type: {
    transport: 0,
    accommodation: 1,
    meal: 2,
    other: 3
  }
  
  # Callbacks
  before_validation :set_default_cost_type, on: :create
  
  private
  
  def set_default_cost_type
    self.cost_type ||= :other
  end
end 