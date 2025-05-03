class User < ApplicationRecord
  acts_as_tenant(:tenant)
  rolify
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # Validações
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :tenant, presence: true
  validates :email, uniqueness: { scope: :tenant_id, case_sensitive: false }
  
  # Relacionamentos
  belongs_to :tenant
  has_one :person
  has_many :rentals, foreign_key: :created_by_id
  has_many :service_orders, foreign_key: :created_by_id
  has_many :observations, as: :observable, dependent: :destroy
  
  # Callbacks
  before_validation :set_default_role, on: :create
  before_validation :set_default_tenant, on: :create
  after_create :create_employee_person
  
  # Método para autenticação com tenant
  def self.find_for_authentication(warden_conditions)
    tenant_id = warden_conditions[:tenant_id]
    email = warden_conditions[:email]
    
    return nil if tenant_id.blank? || email.blank?
    
    tenant = Tenant.find_by(id: tenant_id)
    return nil unless tenant&.active?
    
    where(tenant_id: tenant_id, email: email).first
  end
  
  def admin?
    has_role?(:admin)
  end

  private
  
  def set_default_role
    add_role(:operator) if roles.empty?
  end

  def set_default_tenant
    self.tenant ||= Tenant.first if Tenant.exists?
  end

  def create_employee_person
    return if person.present?
    
    Person.create!(
      tenant: tenant,
      user: self,
      person_type: :individual,
      role: :employee,
      name: name,
      email: email,
      document: generate_cpf,
      registration_date: Date.current,
      status: :active
    )
  end

  def generate_cpf
    # Gera um CPF aleatório válido
    numbers = 9.times.map { rand(10) }
    
    # Calcula o primeiro dígito verificador
    sum = (0..8).inject(0) do |sum, i|
      sum + numbers[i] * (10 - i)
    end
    first_digit = (sum * 10 % 11) % 10
    numbers << first_digit
    
    # Calcula o segundo dígito verificador
    sum = (0..9).inject(0) do |sum, i|
      sum + numbers[i] * (11 - i)
    end
    second_digit = (sum * 10 % 11) % 10
    numbers << second_digit
    
    # Formata o CPF
    numbers.join
  end
end