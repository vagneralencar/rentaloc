class EquipmentMaintenanceLabor < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :equipment_maintenance, presence: true
  validates :description, presence: true
  validates :hours, presence: true, numericality: { greater_than: 0 }
  validates :hourly_rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :equipment_maintenance
  belongs_to :performed_by, class_name: 'User'
  
  # Callbacks
  before_validation :calculate_total_amount, on: :create
  
  private
  
  def calculate_total_amount
    return if hours.blank? || hourly_rate.blank?
    
    self.total_amount = hours * hourly_rate
  end
end 