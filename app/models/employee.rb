class Employee < Person
  default_scope { where(role: :employee) }

  # Relacionamentos específicos de Employee
  belongs_to :user, optional: true
  has_many :service_orders, foreign_key: :technician_id, dependent: :restrict_with_error

  # Validações específicas de Employee
  validates :registration_date, presence: true

  # Callbacks específicos de Employee
  before_validation :set_role

  private

  def set_role
    self.role = :employee
  end
end 