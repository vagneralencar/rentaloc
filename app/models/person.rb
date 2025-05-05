class Person < ApplicationRecord
  include MultiTenant
  
  # Associações
  belongs_to :tenant
  belongs_to :user, optional: true
  has_many :addresses, dependent: :destroy
  has_many :contacts, as: :contactable, dependent: :destroy
  has_many :works, dependent: :destroy
  has_many :credit_references, dependent: :destroy
  has_many :observations, as: :observable, dependent: :destroy
  
  # Aceita nested attributes
  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :contacts, allow_destroy: true
  accepts_nested_attributes_for :credit_references, allow_destroy: true
  accepts_nested_attributes_for :observations, allow_destroy: true
  
  # Validações
  validates :name, presence: true
  validates :document, presence: true, uniqueness: { scope: :tenant_id }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :fiscal_email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  
  # Enums
  enum person_type: { individual: 0, company: 1 }
  enum status: { inactive: 0, active: 1, blocked: 2 }
  enum role: { customer: 0, supplier: 1, carrier: 2, employee: 3 }
  
  # Callbacks
  before_save :format_document
  before_save :format_phones
  
  # Scopes
  scope :active, -> { where(status: :active) }
  scope :customers, -> { where('roles @> ?', '{customer}') }
  scope :suppliers, -> { where('roles @> ?', '{supplier}') }
  scope :carriers, -> { where('roles @> ?', '{carrier}') }
  scope :employees, -> { where('roles @> ?', '{employee}') }
  
  # Escopos para facilitar consultas por tipo de pessoa
  scope :clientes, -> { where(role: :customer) }
  scope :fornecedores, -> { where(role: :supplier) }
  scope :funcionarios, -> { where(role: :employee) }
  
  # Métodos
  def full_name
    company? ? "#{corporate_name} (#{trading_name})" : name
  end
  
  def formatted_document
    if company?
      document.gsub(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '\\1.\\2.\\3/\\4-\\5')
    else
      document.gsub(/(\d{3})(\d{3})(\d{3})(\d{2})/, '\\1.\\2.\\3-\\4')
    end
  end
  
  private
  
  def format_document
    return unless document_changed?
    self.document = document.to_s.gsub(/[^0-9]/, '')
  end
  
  def format_phones
    %i[phone_commercial phone_residential phone_mobile phone_financial].each do |phone|
      next unless send("#{phone}_changed?")
      send("#{phone}=", send(phone).to_s.gsub(/[^0-9]/, ''))
    end
  end
end