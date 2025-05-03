class Address < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :street, presence: true
  validates :number, presence: true
  validates :neighborhood, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :addressable, polymorphic: true
  
  # Enums
  enum address_type: {
    main: 0,
    billing: 1,
    delivery: 2,
    construction: 3
  }
  
  # Callbacks
  before_validation :format_zip_code
  
  private
  
  def format_zip_code
    return if zip_code.blank?
    self.zip_code = zip_code.gsub(/[^\d]/, '')
  end
end 