class EquipmentMaintenance < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :equipment, presence: true
  validates :maintenance_type, presence: true
  validates :start_date, presence: true
  validates :date, presence: true
  validates :description, presence: true
  validates :cost, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :equipment
  belongs_to :created_by, class_name: 'User'
  belongs_to :user, optional: true
  has_many :equipment_maintenance_photos, dependent: :destroy
  has_many :equipment_maintenance_documents, dependent: :destroy
  
  # Enums
  enum maintenance_type: {
    preventive: 0,
    corrective: 1,
    predictive: 2,
    other: 3,
    preventiva: 'preventiva',
    corretiva: 'corretiva',
    preditiva: 'preditiva',
    calibracao: 'calibracao',
    outro: 'outro'
  }
  
  enum status: {
    scheduled: 0,
    in_progress: 1,
    completed: 2,
    cancelled: 3,
    agendada: 'agendada',
    em_andamento: 'em_andamento',
    concluida: 'concluida',
    cancelada: 'cancelada'
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
  before_validation :set_user, on: :create
  
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
  
  def set_user
    self.user = Current.user if Current.user
  end
end 