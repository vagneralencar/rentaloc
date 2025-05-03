module Settings
  class BaseController < ApplicationController
    before_action :ensure_admin
    layout 'application'

    private

    def ensure_admin
      unless current_user&.admin?
        flash[:alert] = 'Você não tem permissão para acessar esta área.'
        redirect_to root_path
      end
    end
  end
end 