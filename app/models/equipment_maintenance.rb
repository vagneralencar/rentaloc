class EquipmentMaintenance < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :equipment, presence: true
  validates :maintenance_type, presence: true
  validates :start_date, presence: true
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :equipment
  belongs_to :created_by, class_name: 'User'
  has_many :equipment_maintenance_photos, dependent: :destroy
  has_many :equipment_maintenance_documents, dependent: :destroy
  
  # Enums
  enum maintenance_type: {
    preventive: 0,
    corrective: 1,
    predictive: 2,
    other: 3
  }
  
  enum status: {
    scheduled: 0,
    in_progress: 1,
    completed: 2,
    cancelled: 3
  }
  
  enum priority: {
    low: 0,
    medium: 1,
    high: 2,
    urgent: 3
  }
  
  # Callbacks
  before_validation :set_default_status, on: :create
  before_validation :set_default_priority, on: :create
  before_validation :calculate_total_cost, on: :create
  
  # Nested attributes
  accepts_nested_attributes_for :equipment_maintenance_photos, allow_destroy: true
  accepts_nested_attributes_for :equipment_maintenance_documents, allow_destroy: true
  
  # Scopes
  scope :scheduled, -> { where(status: :scheduled) }
  scope :in_progress, -> { where(status: :in_progress) }
  scope :completed, -> { where(status: :completed) }
  scope :urgent, -> { where(priority: :urgent) }
  scope :due_this_week, -> { where('due_date BETWEEN ? AND ?', Time.current.beginning_of_week, Time.current.end_of_week) }
  
  private
  
  def set_default_status
    self.status ||= :scheduled
  end
  
  def set_default_priority
    self.priority ||= :medium
  end
  
  def calculate_total_cost
    return if labor_cost.blank? && parts_cost.blank? && other_costs.blank?
    
    self.total_cost = (labor_cost || 0) + (parts_cost || 0) + (other_costs || 0)
  end
end 