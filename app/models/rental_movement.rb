class RentalMovement < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :rental, presence: true
  validates :movement_type, presence: true
  validates :movement_date, presence: true
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :rental
  belongs_to :created_by, class_name: 'User'
  belongs_to :carrier, class_name: 'Person', optional: true
  has_many :rental_movement_items, dependent: :destroy
  has_many :equipments, through: :rental_movement_items
  has_many :observations, as: :observable, dependent: :destroy
  
  # Enums
  enum movement_type: {
    delivery: 0,    # Remessa
    return: 1       # Devolução
  }
  
  enum status: {
    draft: 0,      # Rascunho
    pending: 1,    # Pendente
    completed: 2,  # Concluído
    canceled: 3    # Cancelado
  }
  
  # Callbacks
  before_validation :set_default_status, on: :create
  
  # Nested attributes
  accepts_nested_attributes_for :rental_movement_items, allow_destroy: true
  accepts_nested_attributes_for :observations, allow_destroy: true
  
  # Scopes
  scope :deliveries, -> { where(movement_type: :delivery) }
  scope :returns, -> { where(movement_type: :return) }
  scope :completed, -> { where(status: :completed) }
  scope :pending, -> { where(status: :pending) }
  scope :by_date_range, ->(start_date, end_date) { where(movement_date: start_date..end_date) }
  
  # Métodos
  def complete!
    return false unless pending?
    
    transaction do
      rental_movement_items.each do |item|
        if delivery?
          item.equipment.decrement!(:available_quantity, item.quantity)
        else
          item.equipment.increment!(:available_quantity, item.quantity)
        end
      end
      
      update!(status: :completed)
    end
  end
  
  def cancel!
    return false unless pending?
    update(status: :canceled)
  end
  
  private
  
  def set_default_status
    self.status ||= :draft
  end
  
  def rental_active
    return if rental.blank?
    
    unless rental.active?
      errors.add(:rental, 'deve estar ativa')
    end
  end
  
  def items_quantity
    return if rental_movement_items.blank?
    
    rental_movement_items.each do |item|
      if delivery?
        available = item.equipment.available_quantity
        if item.quantity > available
          errors.add(:base, "Quantidade do equipamento #{item.equipment.name} excede a disponível (#{available})")
        end
      else
        active = rental.active_equipments[item.equipment_id].to_i
        if item.quantity > active
          errors.add(:base, "Quantidade do equipamento #{item.equipment.name} excede a quantidade na obra (#{active})")
        end
      end
    end
  end
end 