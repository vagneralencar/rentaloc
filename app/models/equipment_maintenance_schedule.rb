class EquipmentMaintenanceSchedule < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :equipment, presence: true
  validates :maintenance_type, presence: true
  validates :frequency, presence: true
  validates :last_maintenance_date, presence: true
  validates :next_maintenance_date, presence: true
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :equipment
  belongs_to :created_by, class_name: 'User'
  
  # Enums
  enum maintenance_type: {
    preventive: 0,
    predictive: 1,
    other: 2
  }
  
  enum frequency: {
    daily: 0,
    weekly: 1,
    biweekly: 2,
    monthly: 3,
    bimonthly: 4,
    quarterly: 5,
    semiannual: 6,
    annual: 7
  }
  
  enum status: {
    active: 0,
    inactive: 1,
    completed: 2
  }
  
  # Callbacks
  before_validation :set_default_status, on: :create
  before_validation :calculate_next_maintenance_date, on: :create
  
  # Scopes
  scope :active, -> { where(status: :active) }
  scope :due_this_week, -> { where('next_maintenance_date BETWEEN ? AND ?', Time.current.beginning_of_week, Time.current.end_of_week) }
  scope :due_this_month, -> { where('next_maintenance_date BETWEEN ? AND ?', Time.current.beginning_of_month, Time.current.end_of_month) }
  
  private
  
  def set_default_status
    self.status ||= :active
  end
  
  def calculate_next_maintenance_date
    return if last_maintenance_date.blank? || frequency.blank?
    
    self.next_maintenance_date = case frequency
    when :daily
      last_maintenance_date + 1.day
    when :weekly
      last_maintenance_date + 1.week
    when :biweekly
      last_maintenance_date + 2.weeks
    when :monthly
      last_maintenance_date + 1.month
    when :bimonthly
      last_maintenance_date + 2.months
    when :quarterly
      last_maintenance_date + 3.months
    when :semiannual
      last_maintenance_date + 6.months
    when :annual
      last_maintenance_date + 1.year
    end
  end
end 