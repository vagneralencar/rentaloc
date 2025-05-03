# Configuração do ActsAsTenant
ActsAsTenant.configure do |config|
  # Desabilita a necessidade de tenant para algumas operações
  config.require_tenant = false
end

# Configura o método para obter o tenant atual
ActsAsTenant.singleton_class.class_eval do
  def current_tenant
    Current.tenant
  end

  def current_tenant=(tenant)
    Current.tenant = tenant
  end
end 