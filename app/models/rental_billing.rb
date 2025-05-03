class RentalBilling < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :rental, presence: true
  validates :number, presence: true, uniqueness: { scope: :tenant_id }
  validates :billing_date, presence: true
  validates :due_date, presence: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :due_date_after_billing_date
  validate :payment_date_after_billing_date
  validate :rental_active
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :rental
  belongs_to :created_by, class_name: 'User'
  has_many :rental_billing_items, dependent: :destroy
  has_many :equipments, through: :rental_billing_items
  has_many :observations, as: :observable, dependent: :destroy
  
  # Enums
  enum status: {
    draft: 0,
    pending: 1,
    paid: 2,
    canceled: 3
  }
  
  enum payment_method: {
    bank_slip: 0,
    credit_card: 1,
    debit_card: 2,
    bank_transfer: 3,
    pix: 4,
    cash: 5
  }
  
  # Callbacks
  before_validation :generate_number, on: :create
  before_validation :set_default_status, on: :create
  before_validation :calculate_total_amount
  
  # Nested attributes
  accepts_nested_attributes_for :rental_billing_items, allow_destroy: true
  accepts_nested_attributes_for :observations, allow_destroy: true
  
  # Scopes
  scope :pending, -> { where(status: :pending) }
  scope :paid, -> { where(status: :paid) }
  scope :canceled, -> { where(status: :canceled) }
  scope :by_date_range, ->(start_date, end_date) { where(billing_date: start_date..end_date) }
  scope :overdue, -> { where('due_date < ? AND status = ?', Date.current, statuses[:pending]) }
  
  # Métodos
  def pay!(payment_method, payment_date = Date.current)
    return false unless pending?
    
    update(
      status: :paid,
      payment_method: payment_method,
      payment_date: payment_date
    )
  end
  
  def cancel!
    return false unless pending?
    update(status: :canceled)
  end
  
  def overdue?
    pending? && due_date < Date.current
  end
  
  def days_overdue
    return 0 unless overdue?
    (Date.current - due_date).to_i
  end
  
  private
  
  def generate_number
    return if number.present?
    
    last_number = tenant.rental_billings.maximum(:number)
    self.number = last_number ? last_number + 1 : 1
  end
  
  def set_default_status
    self.status ||= :draft
  end
  
  def calculate_total_amount
    self.total_amount = rental_billing_items.sum(&:total_amount)
  end
  
  def due_date_after_billing_date
    return if billing_date.blank? || due_date.blank?
    
    if due_date < billing_date
      errors.add(:due_date, "deve ser posterior à data de faturamento")
    end
  end

  def payment_date_after_billing_date
    return if billing_date.blank? || payment_date.blank?
    
    if payment_date < billing_date
      errors.add(:payment_date, "deve ser posterior à data de faturamento")
    end
  end

  def rental_active
    return if rental.blank?
    
    unless rental.active?
      errors.add(:rental, "deve estar ativa")
    end
  end
end 