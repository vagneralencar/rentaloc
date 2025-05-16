class Equipment < ApplicationRecord
  self.table_name = "equipments"
  include MultiTenant
  
  # Associações
  belongs_to :tenant
  belongs_to :equipment_category, optional: true
  belongs_to :supplier, class_name: 'Person', optional: true
  has_many :equipment_accessories, dependent: :destroy
  has_many :accessories, through: :equipment_accessories, source: :accessory_equipment
  has_many :equipment_movements
  has_many_attached :photos
  has_many :equipment_documents, dependent: :destroy
  has_many :equipment_photos, dependent: :destroy
  has_many :equipment_maintenances, dependent: :destroy
  has_many :equipment_maintenance_schedules, dependent: :destroy
  has_many :equipment_maintenance_alerts, dependent: :destroy
  has_many :equipment_maintenance_histories, dependent: :destroy
  has_many :rental_items, dependent: :restrict_with_error
  has_many :rentals, through: :rental_items
  has_many :price_table_items, dependent: :destroy
  has_many :price_tables, through: :price_table_items
  has_many :quotation_items, dependent: :destroy
  has_many :quotations, through: :quotation_items
  has_many :service_order_items, dependent: :destroy
  has_many :service_orders, through: :service_order_items
  has_many :service_requests, dependent: :destroy
  
  # Aceita nested attributes
  accepts_nested_attributes_for :equipment_accessories, allow_destroy: true
  
  # Validações
  validates :code, presence: true, uniqueness: { scope: :tenant_id }
  validates :name, presence: true
  validates :status, presence: true
  validates :control_type, presence: true
  validates :depreciation_rate, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true
  validates :weight, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :last_purchase_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :sale_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :indemnity_value, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  
  # Enums
  enum status: {
    active: 0,
    inactive: 1,
    maintenance: 2,
    rented: 3,
    sold: 4,
    scrapped: 5
  }
  
  enum control_type: {
    unit: 0,
    quantity: 1,
    hours: 2,
    kilometers: 3
  }
  
  enum origin: {
    national: 0,
    imported: 1
  }
  
  # Callbacks
  before_validation :generate_code, on: :create
  before_validation :set_tenant, on: :create
  before_save :update_total_quantity

  # Inicializa rental_prices como um hash vazio, se estiver nulo
  after_initialize do
    self.rental_prices ||= {}
  end
  
  # Scopes
  scope :active, -> { where(status: :active) }
  scope :available, -> { where(status: [:active, :inactive]) }
  scope :rented, -> { where(status: :rented) }
  scope :in_maintenance, -> { where(status: :maintenance) }
  scope :by_category, ->(category_id) { where(category_id: category_id) }
  scope :search, ->(query) {
    where('code LIKE :query OR name LIKE :query OR brand LIKE :query OR model LIKE :query OR serial_number LIKE :query',
          query: "%#{query}%")
  }
  
  # Métodos
  def available_quantity
    total_quantity - equipment_movements.active.sum(:quantity)
  end
  
  def current_locations
    equipment_movements.active.includes(:rental, :work)
      .group_by { |m| [m.rental, m.work] }
      .transform_values { |movements| movements.sum(&:quantity) }
  end
  
  def full_name
    "#{code} - #{name}"
  end
  
  def available?
    active? || inactive?
  end
  
  def can_be_rented?
    available? && !in_maintenance?
  end
  
  def current_rental
    rentals.active.first
  end
  
  def last_maintenance
    equipment_maintenances.completed.order(completion_date: :desc).first
  end
  
  def next_maintenance
    equipment_maintenance_schedules.active.order(next_maintenance_date: :asc).first
  end
  
  def total_cost
    (labor_cost || 0) + (parts_cost || 0) + (other_costs || 0)
  end
  
  private

  def initialize_rental_prices
    self.rental_prices ||= {}
  end
  
  def generate_code
    return if code.present?
    
    category_prefix = equipment_category&.code || 'EQ'
    last_code = tenant.equipments
                     .where("code LIKE ?", "#{category_prefix}%")
                     .order(code: :desc)
                     .first&.code
    
    sequence = if last_code
                 last_code.match(/\d+$/)[0].to_i + 1
               else
                 1
               end
    
    self.code = "#{category_prefix}#{sequence.to_s.rjust(6, '0')}"
  end
  
  def set_tenant
    self.tenant = Current.tenant
  end
  
  def update_total_quantity
    return unless quantity_changed?
    
    self.total_quantity = if individual_control?
                           1
                         else
                           quantity
                         end
  end
  
  def individual_control?
    individual_without_serial? || individual_with_serial?
  end
end