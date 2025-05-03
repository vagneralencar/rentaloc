class EquipmentMaintenanceReport < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :equipment, presence: true
  validates :report_type, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true
  validate :end_date_after_start_date
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :equipment
  belongs_to :generated_by, class_name: 'User'
  
  # Enums
  enum report_type: {
    preventive: 0,
    corrective: 1,
    predictive: 2,
    other: 3
  }
  
  enum status: {
    draft: 0,
    generated: 1,
    failed: 2,
    archived: 3
  }
  
  # Callbacks
  before_validation :set_default_status, on: :create
  
  # Scopes
  scope :draft, -> { where(status: :draft) }
  scope :generated, -> { where(status: :generated) }
  scope :archived, -> { where(status: :archived) }
  scope :this_month, -> { where('created_at BETWEEN ? AND ?', Time.current.beginning_of_month, Time.current.end_of_month) }
  scope :this_year, -> { where('created_at BETWEEN ? AND ?', Time.current.beginning_of_year, Time.current.end_of_year) }
  scope :recent, -> { order(created_at: :desc) }
  scope :by_equipment, ->(equipment_id) { where(equipment_id: equipment_id) }
  scope :by_type, ->(report_type) { where(report_type: report_type) }
  scope :by_status, ->(status) { where(status: status) }
  scope :by_date_range, ->(start_date, end_date) { where('start_date >= ? AND end_date <= ?', start_date, end_date) }
  
  # Anexo do PDF
  has_one_attached :pdf
  
  private
  
  def set_default_status
    self.status ||= :draft
  end
  
  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?
    
    if end_date < start_date
      errors.add(:end_date, 'deve ser posterior à data de início')
    end
  end
end 