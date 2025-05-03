class Current < ActiveSupport::CurrentAttributes
  attribute :tenant, :user
  
  # Reseta todos os atributos
  def self.reset
    self.tenant = nil
    self.user = nil
  end
  
  # Configura o tenant e usuário
  def self.set(tenant:, user:)
    self.tenant = tenant
    self.user = user
  end
end 