Warden::Manager.after_authentication do |user, auth, opts|
  if user.tenant
    ActsAsTenant.current_tenant = user.tenant
  else
    tenant = Tenant.first
    if tenant
      ActsAsTenant.current_tenant = tenant
      user.update(tenant: tenant)
    else
      auth.logout
      throw(:warden, message: "Nenhum tenant encontrado. Configure o sistema primeiro.")
    end
  end
end

Warden::Manager.before_logout do |user, auth, opts|
  ActsAsTenant.current_tenant = nil
end 