module MultiTenant
  extend ActiveSupport::Concern

  included do
    belongs_to :tenant
    # Altere o default_scope para evitar erro quando Current.tenant estiver nil
    # Isso evita que o ActiveRecord tente acessar a tabela de forma incorreta durante seeds ou operações sem tenant
    default_scope { where(tenant: Current.tenant) if Current.tenant }
    
    validates :tenant_id, presence: true
    
    before_validation :set_tenant
    
    private
    
    def set_tenant
      self.tenant_id ||= Current.tenant&.id
    end
  end
end