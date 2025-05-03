class Work < ApplicationRecord
  include MultiTenant

  # Relacionamentos
  belongs_to :tenant
  belongs_to :person
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :contacts, as: :contactable, dependent: :destroy
  has_many :observations, as: :observable, dependent: :destroy
  has_many :rentals
  has_many :rental_movements
  has_many :service_orders

  # Nested attributes
  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :contacts, allow_destroy: true
  accepts_nested_attributes_for :observations, allow_destroy: true

  # Enums
  enum status: { pending: 0, in_progress: 1, finished: 2, cancelled: 3 }
  enum work_type: { construction: 0, renovation: 1, maintenance: 2, event: 3, other: 4 }

  # Validações
  validates :name, presence: true
  validates :code, presence: true, uniqueness: { scope: :tenant_id }
  validates :start_date, presence: true
  validates :expected_end_date, presence: true
  validate :end_date_after_start_date

  # Callbacks
  before_validation :set_default_status, on: :create
  before_validation :generate_code, on: :create

  # Scopes
  scope :active, -> { where(status: [:pending, :in_progress]) }
  scope :inactive, -> { where(status: :finished) }
  scope :finished, -> { where(status: :finished) }
  scope :by_customer, ->(customer_id) { where(person_id: customer_id) }
  scope :by_period, ->(start_date, end_date) { 
    where('start_date <= ? AND (end_date >= ? OR end_date IS NULL)', end_date, start_date)
  }

  private

  def set_default_status
    self.status ||= :pending
  end

  def generate_code
    return if code.present?
    last_code = tenant.works.where("code LIKE ?", "OBRA#{Date.current.year}%")
                      .order(code: :desc)
                      .first&.code
    
    sequence = if last_code
                 last_code.match(/\d+$/)[0].to_i + 1
               else
                 1
               end
    
    self.code = "OBRA#{Date.current.year}#{sequence.to_s.rjust(4, '0')}"
  end

  def end_date_after_start_date
    return if start_date.blank? || expected_end_date.blank?
    if expected_end_date < start_date
      errors.add(:expected_end_date, 'deve ser posterior à data de início')
    end
  end
end 