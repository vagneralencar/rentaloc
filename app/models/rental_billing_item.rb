class RentalBillingItem < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :rental_billing
  belongs_to :equipment
  has_many :observations, as: :observable, dependent: :destroy
  
  # Nested attributes
  accepts_nested_attributes_for :observations, allow_destroy: true
  
  # Validações
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :equipment_id, uniqueness: { scope: :rental_billing_id }
  
  # Callbacks
  before_validation :calculate_total_amount
  
  private
  
  def calculate_total_amount
    return if quantity.blank? || unit_price.blank?
    
    self.total_amount = quantity * unit_price
  end
end 