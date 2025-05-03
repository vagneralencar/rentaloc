class ServiceOrderItem < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :service_order, presence: true
  validates :equipment, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :service_order
  belongs_to :equipment
  
  # Callbacks
  before_validation :calculate_total_amount, on: :create
  
  private
  
  def calculate_total_amount
    return if quantity.blank? || unit_price.blank?
    
    self.total_amount = quantity * unit_price
  end
end 