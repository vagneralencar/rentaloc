class Users::ConfirmationsController < Devise::ConfirmationsController
  protected

  def after_confirmation_path_for(resource_name, resource)
    if resource.tenant
      ActsAsTenant.current_tenant = resource.tenant
      sign_in(resource)
      dashboard_path
    else
      new_user_session_path
    end
  end

  def after_resending_confirmation_instructions_path_for(resource_name)
    new_user_session_path
  end
end 