class Supplier < Person
  default_scope { where(role: :supplier) }

  # Relacionamentos específicos de Supplier
  has_many :equipment_maintenance_parts, dependent: :restrict_with_error
  has_many :equipment_maintenance_labors, dependent: :restrict_with_error
  has_many :equipment_maintenance_other_costs, dependent: :restrict_with_error

  # Validações específicas de Supplier
  validates :nfe_email, presence: true, if: :company?

  # Callbacks específicos de Supplier
  before_validation :set_role

  private

  def set_role
    self.role = :supplier
  end
end 