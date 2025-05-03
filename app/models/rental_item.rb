class RentalItem < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :rental
  belongs_to :equipment
  has_many :rental_movement_items
  has_many :rental_billing_items
  has_many :observations, as: :observable, dependent: :destroy
  
  # Nested attributes
  accepts_nested_attributes_for :observations, allow_destroy: true
  
  # Validações
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :equipment_id, uniqueness: { scope: :rental_id }
  validate :quantity_available
  
  # Callbacks
  before_validation :calculate_total_price
  
  # Métodos
  def active_quantity
    rental_movements.joins(:rental_movement_items)
      .where(rental_movement_items: { equipment_id: equipment_id })
      .sum('rental_movement_items.quantity')
  end
  
  def available_quantity
    quantity - active_quantity
  end
  
  private
  
  def calculate_total_price
    return if quantity.blank? || unit_price.blank?
    self.total_price = quantity * unit_price
  end
  
  def quantity_available
    return if equipment.blank? || quantity.blank?
    
    available = equipment.available_quantity
    if quantity > available
      errors.add(:quantity, "excede a quantidade disponível (#{available})")
    end
  end
end 