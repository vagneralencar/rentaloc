class EquipmentMaintenanceNotification < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :equipment_maintenance_alert, presence: true
  validates :user, presence: true
  validates :notification_type, presence: true
  validates :message, presence: true
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :equipment_maintenance_alert
  belongs_to :user
  
  # Enums
  enum notification_type: {
    email: 0,
    sms: 1,
    push: 2,
    in_app: 3
  }
  
  enum status: {
    pending: 0,
    sent: 1,
    failed: 2,
    read: 3
  }
  
  # Callbacks
  before_validation :set_default_status, on: :create
  
  # Scopes
  scope :pending, -> { where(status: :pending) }
  scope :sent, -> { where(status: :sent) }
  scope :failed, -> { where(status: :failed) }
  scope :read, -> { where(status: :read) }
  scope :unread, -> { where.not(status: :read) }
  scope :today, -> { where('created_at >= ?', Time.current.beginning_of_day) }
  scope :this_week, -> { where('created_at >= ?', Time.current.beginning_of_week) }
  
  private
  
  def set_default_status
    self.status ||= :pending
  end
end 