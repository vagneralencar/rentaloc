class RentalMovementItem < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :rental_movement
  belongs_to :equipment
  has_many :observations, as: :observable, dependent: :destroy
  
  # Nested attributes
  accepts_nested_attributes_for :observations, allow_destroy: true
  
  # Validações
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :equipment_id, uniqueness: { scope: :rental_movement_id }
  
  # Callbacks
  before_validation :calculate_total_quantity
  
  private
  
  def calculate_total_quantity
    return if quantity.blank?
    
    previous_total = rental_movement.rental_movement_items
      .where(equipment_id: equipment_id)
      .where.not(id: id)
      .sum(:quantity)
    
    self.total_quantity = previous_total + quantity
  end
end 