class ServiceRequest < ApplicationRecord
  include MultiTenant
  
  belongs_to :created_by, class_name: 'User'
  belongs_to :customer
  belongs_to :equipment
  
  has_many :service_orders, dependent: :restrict_with_error
  
  validates :request_date, presence: true
  validates :description, presence: true
  validates :priority, presence: true
  validates :status, presence: true
  
  enum priority: {
    low: 0,
    medium: 1,
    high: 2,
    urgent: 3
  }
  
  enum status: {
    pending: 0,
    in_progress: 1,
    completed: 2,
    cancelled: 3
  }
  
  before_validation :set_tenant
  
  private
  
  def set_tenant
    self.tenant_id ||= Current.tenant&.id
  end
end 