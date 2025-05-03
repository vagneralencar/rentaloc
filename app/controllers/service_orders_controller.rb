class ServiceOrdersController < ApplicationController
  before_action :set_service_order, only: [:show, :edit, :update, :destroy]

  def index
    @service_orders = ServiceOrder.all
  end

  def show
  end

  def new
    @service_order = ServiceOrder.new
  end

  def edit
  end

  def create
    @service_order = ServiceOrder.new(service_order_params)

    if @service_order.save
      redirect_to @service_order, notice: 'Ordem de serviço criada com sucesso.'
    else
      render :new
    end
  end

  def update
    if @service_order.update(service_order_params)
      redirect_to @service_order, notice: 'Ordem de serviço atualizada com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @service_order.destroy
    redirect_to service_orders_url, notice: 'Ordem de serviço excluída com sucesso.'
  end

  private

  def set_service_order
    @service_order = ServiceOrder.find(params[:id])
  end

  def service_order_params
    params.require(:service_order).permit(:customer_id, :equipment_id, :description, :status, :start_date, :end_date)
  end
end 