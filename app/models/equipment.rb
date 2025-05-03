class Equipment < ApplicationRecord
  self.table_name = "equipments"
  include MultiTenant
  
  # Associações
  belongs_to :tenant
  belongs_to :equipment_category, optional: true
  belongs_to :supplier, class_name: 'Person', optional: true
  has_many :equipment_accessories, dependent: :destroy
  has_many :accessories, through: :equipment_accessories, source: :accessory_equipment
  has_many :rental_prices, dependent: :destroy
  has_many :equipment_movements
  has_many_attached :photos
  
  # Aceita nested attributes
  accepts_nested_attributes_for :equipment_accessories, allow_destroy: true
  accepts_nested_attributes_for :rental_prices, allow_destroy: true
  
  # Validações
  validates :code, presence: true, uniqueness: { scope: :tenant_id }
  validates :name, presence: true
  validates :unit, presence: true
  validates :depreciation_rate, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true
  validates :weight, numericality: { greater_than: 0 }, allow_nil: true
  validates :last_purchase_value, :sale_value, :indemnification_value,
            numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  
  # Enums
  enum status: { inactive: 0, active: 1, maintenance: 2, sold: 3 }
  enum control_type: { 
    quantity_without_serial: 0,    # Controle por quantidade sem número de série
    quantity_with_serial: 1,       # Controle por quantidade com número de série
    individual_without_serial: 2,  # Controle individual sem patrimônio
    individual_with_serial: 3      # Controle individual com patrimônio
  }
  
  # Callbacks
  before_validation :generate_code, on: :create
  before_save :update_total_quantity
  
  # Scopes
  scope :active, -> { where(status: :active) }
  scope :available_for_rental, -> { active.where(rental_control: true) }
  scope :by_category, ->(category_id) { where(equipment_category_id: category_id) }
  
  # Métodos
  def available_quantity
    total_quantity - equipment_movements.active.sum(:quantity)
  end
  
  def current_locations
    equipment_movements.active.includes(:rental, :work)
      .group_by { |m| [m.rental, m.work] }
      .transform_values { |movements| movements.sum(&:quantity) }
  end
  
  private
  
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