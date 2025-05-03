class Users::PasswordsController < Devise::PasswordsController
  before_action :configure_reset_password_params, only: [:update]

  protected

  def configure_reset_password_params
    devise_parameter_sanitizer.permit(:reset_password, keys: [:password, :password_confirmation, :reset_password_token])
  end

  def after_resetting_password_path_for(resource)
    sign_in(resource)
    dashboard_path
  end

  def after_sending_reset_password_instructions_path_for(resource_name)
    new_user_session_path
  end
end 