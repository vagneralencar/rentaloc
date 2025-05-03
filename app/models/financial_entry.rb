class FinancialEntry < ApplicationRecord
  include MultiTenant
  
  belongs_to :created_by, class_name: 'User'
  belongs_to :financial_nature
  belongs_to :cost_center
  belongs_to :tax_rule, optional: true
  
  has_many :financial_entry_allocations, dependent: :destroy
  has_many :financial_entry_payments, dependent: :destroy
  
  validates :entry_date, presence: true
  validates :due_date, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :entry_type, presence: true
  validates :status, presence: true
  
  enum entry_type: {
    income: 0,
    expense: 1
  }
  
  enum status: {
    pending: 0,
    paid: 1,
    cancelled: 2
  }
  
  before_validation :set_tenant
  
  private
  
  def set_tenant
    self.tenant_id ||= Current.tenant&.id
  end
end 