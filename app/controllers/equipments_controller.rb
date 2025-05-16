class EquipmentsController < ApplicationController
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:index, :new, :create, :edit, :update]

  def index
    @equipments = Current.tenant.equipments
                         .includes(:category)
                         .search(params[:q])
                         .by_category(params[:category_id])
                         .order(:code)
                         .page(params[:page])
                         .per(20)

    respond_to do |format|
      format.html
      format.json { render json: @equipments }
    end
  end

  def show
    @equipment_documents = @equipment.equipment_documents.order(created_at: :desc)
    @equipment_photos = @equipment.equipment_photos.order(created_at: :desc)
    @equipment_accessories = @equipment.equipment_accessories.includes(:accessory).order(:created_at)
    @equipment_maintenances = @equipment.equipment_maintenances.includes(:created_by).order(start_date: :desc)
    @equipment_maintenance_schedules = @equipment.equipment_maintenance_schedules.includes(:created_by).order(next_maintenance_date: :asc)
    @equipment_maintenance_alerts = @equipment.equipment_maintenance_alerts.includes(:created_by).order(due_date: :asc)
    @equipment_maintenance_histories = @equipment.equipment_maintenance_histories.includes(:performed_by).order(maintenance_date: :desc)
  end

  def new
    @equipment = Current.tenant.equipments.build
  end

  def create
    @equipment = Current.tenant.equipments.build(equipment_params)

    if @equipment.save
      redirect_to @equipment, notice: 'Equipamento cadastrado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @equipment.update(equipment_params)
      redirect_to @equipment, notice: 'Equipamento atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @equipment.destroy
      redirect_to equipments_path, notice: 'Equipamento excluído com sucesso.'
    else
      redirect_to @equipment, alert: 'Não foi possível excluir o equipamento. Verifique se não há registros vinculados.'
    end
  end

  private

  def set_equipment
    @equipment = Current.tenant.equipments.find(params[:id])
  end

  def set_categories
    @categories = Category.where(tenant: Current.tenant).order(:name).to_a
  end

  def equipment_params
    rental_prices = {
      daily: params[:equipment][:rental_prices_daily],
      weekly: params[:equipment][:rental_prices_weekly],
      monthly: params[:equipment][:rental_prices_monthly],
      quarterly: params[:equipment][:rental_prices_quarterly],
      semester: params[:equipment][:rental_prices_semester],
      yearly: params[:equipment][:rental_prices_yearly]
    }.compact

    params.require(:equipment).permit(
      :category_id,
      :code,
      :name,
      :description,
      :status,
      :control_type,
      :unit,
      :depreciation_rate,
      :weight,
      :last_purchase_price,
      :last_purchase_date,
      :sale_price,
      :indemnity_value,
      :brand,
      :model,
      :serial_number,
      :documentation_url,
      :ncm,
      :cest,
      :origin,
      :rental_prices_daily,
      :rental_prices_weekly,
      :rental_prices_monthly,
      :rental_prices_quarterly,
      :rental_prices_semester,
      :rental_prices_yearly,
      additional_data: {}
    ).merge(rental_prices: rental_prices)
  end
end 