class EquipmentMaintenanceAlert < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :equipment, presence: true
  validates :alert_type, presence: true
  validates :message, presence: true
  validates :due_date, presence: true
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :equipment
  belongs_to :created_by, class_name: 'User'
  belongs_to :equipment_maintenance_schedule, optional: true
  
  # Enums
  enum alert_type: {
    preventive_maintenance: 0,
    corrective_maintenance: 1,
    predictive_maintenance: 2,
    inspection: 3,
    calibration: 4,
    other: 5
  }
  
  enum status: {
    pending: 0,
    in_progress: 1,
    completed: 2,
    cancelled: 3
  }
  
  enum priority: {
    low: 0,
    medium: 1,
    high: 2,
    critical: 3
  }
  
  # Callbacks
  before_validation :set_default_status, on: :create
  before_validation :set_default_priority, on: :create
  
  # Scopes
  scope :pending, -> { where(status: :pending) }
  scope :in_progress, -> { where(status: :in_progress) }
  scope :completed, -> { where(status: :completed) }
  scope :cancelled, -> { where(status: :cancelled) }
  scope :due_today, -> { where('due_date = ?', Date.current) }
  scope :due_this_week, -> { where('due_date BETWEEN ? AND ?', Date.current, Date.current.end_of_week) }
  scope :overdue, -> { where('due_date < ?', Date.current) }
  scope :high_priority, -> { where(priority: [:high, :critical]) }
  
  private
  
  def set_default_status
    self.status ||= :pending
  end
  
  def set_default_priority
    self.priority ||= :medium
  end
end 