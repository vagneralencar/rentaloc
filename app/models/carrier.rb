class Carrier < Person
  default_scope { where(role: :carrier) }

  # Relacionamentos específicos de Carrier
  has_many :rental_movements, dependent: :restrict_with_error

  # Validações específicas de Carrier
  validates :nfe_email, presence: true, if: :company?

  # Callbacks específicos de Carrier
  before_validation :set_role

  private

  def set_role
    self.role = :carrier
  end
end 