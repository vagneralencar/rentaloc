class Contact < ApplicationRecord
  acts_as_tenant(:tenant)
  
  # Validações
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  
  # Relacionamentos
  belongs_to :tenant
  belongs_to :contactable, polymorphic: true
  
  # Enums
  enum contact_type: {
    main: 0,
    financial: 1,
    technical: 2,
    commercial: 3
  }
  
  # Callbacks
  before_validation :format_phone
  
  private
  
  def format_phone
    return if phone.blank?
    self.phone = phone.gsub(/[^\d]/, '')
  end
end 