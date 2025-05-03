class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :set_tenant_and_user
  before_action :authorize_action!
  
  layout :set_layout
  
  private
  
  def set_tenant_and_user
    Current.reset
    return if devise_controller?
    
    if user_signed_in? && current_user.tenant
      ActsAsTenant.current_tenant = current_user.tenant
      Current.set(tenant: current_user.tenant, user: current_user)
    end
  end
  
  def authorize_action!
    return if devise_controller?
    resource_class = controller_name.classify.safe_constantize
    authorize! action_name.to_sym, resource_class if resource_class
  end
  
  def set_layout
    if devise_controller?
      'devise'
    else
      'application'
    end
  end
  
  # Método auxiliar para jobs
  def enqueue_job(job_class, **args)
    job_class.perform_later(args.merge(tenant_id: Current.tenant&.id))
  end
  
  # Método auxiliar para geração de PDF
  def generate_pdf(template:, locals: {}, filename:)
    PdfGeneratorService.generate(
      template: template,
      locals: locals,
      filename: filename
    )
  end
end
