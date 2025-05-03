class CustomRole < ApplicationRecord
  include MultiTenant
  
  validates :name, presence: true, uniqueness: { scope: :tenant_id }
  
  has_many :role_permissions, dependent: :destroy
  has_many :permissions, through: :role_permissions
  
  scope :system, -> { where(is_system: true) }
  scope :custom, -> { where(is_system: false) }
  
  def self.default_roles
    [
      { name: 'admin', description: 'Administrador do sistema', is_system: true },
      { name: 'manager', description: 'Gerente', is_system: true },
      { name: 'operator', description: 'Operador', is_system: true },
      { name: 'technician', description: 'Técnico', is_system: true },
      { name: 'viewer', description: 'Visualizador', is_system: true }
    ]
  end
end 