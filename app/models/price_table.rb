class PriceTable < ApplicationRecord
  acts_as_tenant(:tenant)

  # Relacionamentos
  belongs_to :tenant
  has_many :price_table_items, dependent: :destroy
  has_many :equipments, through: :price_table_items
  has_many :rentals
  has_many :observations, as: :observable, dependent: :destroy

  # Nested attributes
  accepts_nested_attributes_for :price_table_items, allow_destroy: true
  accepts_nested_attributes_for :observations, allow_destroy: true

  # Enums
  enum status: {
    active: 0,
    inactive: 1
  }

  # Validações
  validates :code, presence: true, uniqueness: { scope: :tenant_id }
  validates :name, presence: true
  validates :start_date, presence: true
  validate :end_date_after_start_date

  # Callbacks
  before_validation :set_default_status, on: :create

  # Scopes
  scope :active, -> { where(status: :active) }
  scope :inactive, -> { where(status: :inactive) }
  scope :current, -> { where('start_date <= ? AND (end_date IS NULL OR end_date >= ?)', Date.current, Date.current) }

  private

  def set_default_status
    self.status ||= :active
  end

  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?
    
    if end_date < start_date
      errors.add(:end_date, 'deve ser posterior à data de início')
    end
  end
end 