class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :validate_tenant, only: [:create]

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :tenant_id])
  end

  def validate_tenant
    tenant_id = params[:user][:tenant_id]
    return if tenant_id.blank?

    tenant = Tenant.find_by(id: tenant_id)
    unless tenant&.active?
      flash[:alert] = "Empresa inativa ou não encontrada."
      redirect_to new_user_session_path and return
    end
  end

  def after_sign_in_path_for(resource)
    if resource.tenant&.active?
      ActsAsTenant.current_tenant = resource.tenant
      Current.set(tenant: resource.tenant, user: resource)
      dashboard_path
    else
      sign_out resource
      flash[:alert] = "Empresa inativa ou não encontrada."
      new_user_session_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end 