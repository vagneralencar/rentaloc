class EquipmentMaintenanceHistory < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :equipment, presence: true
  validates :maintenance_type, presence: true
  validates :maintenance_date, presence: true
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :equipment
  belongs_to :performed_by, class_name: 'User'
  belongs_to :equipment_maintenance, optional: true
  
  # Enums
  enum maintenance_type: {
    preventive: 0,
    corrective: 1,
    predictive: 2,
    other: 3
  }
  
  enum status: {
    completed: 0,
    cancelled: 1
  }
  
  # Callbacks
  before_validation :set_default_status, on: :create
  
  # Scopes
  scope :completed, -> { where(status: :completed) }
  scope :cancelled, -> { where(status: :cancelled) }
  scope :this_month, -> { where('maintenance_date BETWEEN ? AND ?', Time.current.beginning_of_month, Time.current.end_of_month) }
  scope :this_year, -> { where('maintenance_date BETWEEN ? AND ?', Time.current.beginning_of_year, Time.current.end_of_year) }
  
  private
  
  def set_default_status
    self.status ||= :completed
  end
end 