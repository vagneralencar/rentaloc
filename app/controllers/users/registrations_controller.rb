class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :tenant_id])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation, :current_password])
  end

  def after_sign_up_path_for(resource)
    if resource.tenant
      ActsAsTenant.current_tenant = resource.tenant
      dashboard_path
    else
      sign_out resource
      new_user_session_path
    end
  end

  def after_update_path_for(resource)
    dashboard_path
  end
end 