class ServiceOrder < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :number, presence: true, uniqueness: { scope: :tenant_id }
  validates :customer, presence: true
  validates :start_date, presence: true
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :customer
  belongs_to :created_by, class_name: 'User'
  has_many :service_order_items, dependent: :destroy
  has_many :equipments, through: :service_order_items
  has_many :service_order_photos, dependent: :destroy
  has_many :service_order_documents, dependent: :destroy
  
  # Enums
  enum status: {
    draft: 0,
    pending: 1,
    in_progress: 2,
    completed: 3,
    cancelled: 4
  }
  
  enum priority: {
    low: 0,
    medium: 1,
    high: 2,
    urgent: 3
  }
  
  # Callbacks
  before_validation :generate_number, on: :create
  before_validation :set_default_status, on: :create
  before_validation :set_default_priority, on: :create
  before_validation :calculate_total_amount, on: :create
  
  # Nested attributes
  accepts_nested_attributes_for :service_order_items, allow_destroy: true
  accepts_nested_attributes_for :service_order_photos, allow_destroy: true
  accepts_nested_attributes_for :service_order_documents, allow_destroy: true
  
  # Scopes
  scope :pending, -> { where(status: :pending) }
  scope :in_progress, -> { where(status: :in_progress) }
  scope :completed, -> { where(status: :completed) }
  scope :urgent, -> { where(priority: :urgent) }
  scope :due_this_week, -> { where('due_date BETWEEN ? AND ?', Time.current.beginning_of_week, Time.current.end_of_week) }
  
  private
  
  def generate_number
    return if number.present?
    
    last_number = self.class.where(tenant: tenant).maximum(:number) || 0
    self.number = (last_number + 1).to_s.rjust(6, '0')
  end
  
  def set_default_status
    self.status ||= :draft
  end
  
  def set_default_priority
    self.priority ||= :medium
  end
  
  def calculate_total_amount
    return if service_order_items.empty?
    
    self.total_amount = service_order_items.sum(&:total_amount)
  end
end 