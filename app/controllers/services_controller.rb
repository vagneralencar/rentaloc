class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :authorize_service

  def index
    @services = current_tenant.services
                            .includes(:category)
                            .order(:name)
                            .page(params[:page])
                            .per(25)

    if params[:search].present?
      @services = @services.where("name ILIKE :search OR code ILIKE :search", search: "%#{params[:search]}%")
    end

    if params[:status].present?
      @services = @services.where(status: params[:status])
    end

    if params[:category_id].present?
      @services = @services.where(category_id: params[:category_id])
    end

    if params[:service_type].present?
      @services = @services.where(service_type: params[:service_type])
    end
  end

  def show
  end

  def new
    @service = current_tenant.services.build
  end

  def edit
  end

  def create
    @service = current_tenant.services.build(service_params)

    if @service.save
      redirect_to @service, notice: 'Serviço foi criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @service.update(service_params)
      redirect_to @service, notice: 'Serviço foi atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @service.destroy
      redirect_to services_path, notice: 'Serviço foi excluído com sucesso.'
    else
      redirect_to services_path, alert: 'Não foi possível excluir o serviço.'
    end
  end

  private

  def set_service
    @service = current_tenant.services.find(params[:id])
  end

  def service_params
    params.require(:service).permit(
      :code,
      :name,
      :description,
      :status,
      :unit,
      :price,
      :nfs_description,
      :category_id,
      :service_type
    )
  end

  def authorize_service
    authorize! :manage, Service
  end
end 