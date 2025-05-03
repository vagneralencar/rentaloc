class Customer < Person
  default_scope { where(role: :customer) }

  # Relacionamentos específicos de Customer
  has_many :works, dependent: :destroy
  has_many :rentals, dependent: :restrict_with_error
  has_many :service_orders, dependent: :restrict_with_error

  # Validações específicas de Customer
  validates :nfe_email, presence: true, if: :company?

  # Callbacks específicos de Customer
  before_validation :set_role

  # Validações
  validates :name, presence: true
  validates :document, presence: true, uniqueness: { scope: :tenant_id }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  
  # Relacionamentos
  belongs_to :tenant
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :contacts, as: :contactable, dependent: :destroy
  
  # Enums
  enum status: {
    active: 0,
    inactive: 1,
    blocked: 2
  }
  
  # Nested attributes
  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :contacts, allow_destroy: true
  
  private
  
  def format_document
    return if document.blank?
    self.document = document.gsub(/[^\d]/, '')
  end
  
  def set_default_status
    self.status ||= :active
  end
  
  def set_role
    self.role = :customer
  end
end 