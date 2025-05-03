class Rental < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :number, presence: true, uniqueness: { scope: :tenant_id }
  validates :customer, presence: true
  validates :start_date, presence: true
  validates :first_billing_date, presence: true
  validates :due_day, presence: true
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :customer, class_name: 'Person'
  belongs_to :work
  belongs_to :created_by, class_name: 'User'
  belongs_to :seller, class_name: 'User', optional: true
  belongs_to :cost_center, optional: true
  belongs_to :financial_nature, optional: true
  belongs_to :price_table
  has_many :rental_items, dependent: :destroy
  has_many :equipments, through: :rental_items
  has_many :rental_movements, dependent: :restrict_with_error
  has_many :rental_billings, dependent: :restrict_with_error
  has_many :observations, as: :observable, dependent: :destroy
  
  # Enums
  enum status: {
    draft: 0,
    active: 1,
    suspended: 2,
    finished: 3,
    cancelled: 4
  }
  
  # Callbacks
  before_validation :generate_number, on: :create
  before_validation :set_default_status, on: :create
  
  # Nested attributes
  accepts_nested_attributes_for :rental_items, allow_destroy: true
  accepts_nested_attributes_for :observations, allow_destroy: true
  
  # Scopes
  scope :active, -> { where(status: :active) }
  scope :suspended, -> { where(status: :suspended) }
  scope :finished, -> { where(status: :finished) }
  scope :by_customer, ->(customer_id) { where(customer_id: customer_id) }
  scope :by_work, ->(work_id) { where(work_id: work_id) }
  scope :by_date_range, ->(start_date, end_date) { where('start_date >= ? AND (end_date IS NULL OR end_date <= ?)', start_date, end_date) }
  
  # Métodos
  def total_amount
    rental_items.sum(&:total_price)
  end
  
  def active_equipments
    rental_movements.where(movement_type: :delivery).joins(:rental_movement_items)
      .group('rental_movement_items.equipment_id')
      .sum('rental_movement_items.quantity')
  end
  
  def can_finish?
    active? && active_equipments.values.sum.zero?
  end
  
  def can_suspend?
    active?
  end
  
  def can_reactivate?
    suspended?
  end
  
  def suspend!
    return false unless can_suspend?
    update(status: :suspended)
  end
  
  def reactivate!
    return false unless can_reactivate?
    update(status: :active)
  end
  
  def finish!
    return false unless can_finish?
    update(status: :finished, end_date: Date.current)
  end
  
  private
  
  def generate_number
    return if number.present?
    last_number = self.class.where(tenant_id: tenant_id).maximum(:number) || 0
    self.number = (last_number + 1).to_s.rjust(6, '0')
  end
  
  def set_default_status
    self.status ||= :draft
  end
end 