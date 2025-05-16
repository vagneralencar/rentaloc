class Tenant < ApplicationRecord
  # Associações
  has_many :users, dependent: :destroy
  has_many :people, dependent: :destroy
  has_many :works, through: :people
  has_many :equipments, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :financial_natures, dependent: :destroy
  has_many :cost_centers, dependent: :destroy
  has_many :categories, dependent: :destroy
  
  # Anexos
  has_one_attached :logo
  
  # Validações
  validates :name, presence: true
  validates :corporate_name, presence: true
  validates :subdomain, presence: true, uniqueness: true,
            format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/ },
            exclusion: { in: %w[www admin api blog dev stage test] }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :cnpj, presence: true, uniqueness: true
  
  # Callbacks
  before_validation :normalize_subdomain
  before_save :format_document
  
  # Enums
  enum status: { inactive: 0, active: 1, suspended: 2 }, _default: :active
  enum tax_regime: { simples: 0, presumed_profit: 1, real_profit: 2 }
  
  # Scopes
  scope :active, -> { where(status: :active) }
  
  # Relacionamentos
  has_many :customers, -> { where(role: :customer) }, class_name: 'Person'
  has_many :suppliers, -> { where(role: :supplier) }, class_name: 'Person'
  has_many :carriers, -> { where(role: :carrier) }, class_name: 'Person'
  has_many :employees, -> { where(role: :employee) }, class_name: 'Person'
  has_many :rentals
  has_many :service_orders
  has_many :tax_rules
  has_many :credit_references
  has_many :observations, as: :observable, dependent: :destroy
  has_many :addresses, as: :addressable
  has_many :contacts, as: :contactable
  
  # Nested attributes
  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :contacts, allow_destroy: true
  
  private
  
  def normalize_subdomain
    self.subdomain = subdomain.to_s.downcase.gsub(/[^a-z0-9-]/, '')
  end
  
  def format_document
    return unless cnpj_changed?
    self.cnpj = cnpj.to_s.gsub(/[^0-9]/, '')
  end
end