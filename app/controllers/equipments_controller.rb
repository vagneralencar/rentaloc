class EquipmentsController < ApplicationController
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]

  def index
    @equipments = Equipment.all
  end

  def show
  end

  def new
    @equipment = Equipment.new
  end

  def edit
  end

  def create
    @equipment = Equipment.new(equipment_params)

    if @equipment.save
      redirect_to @equipment, notice: 'Equipamento criado com sucesso.'
    else
      render :new
    end
  end

  def update
    if @equipment.update(equipment_params)
      redirect_to @equipment, notice: 'Equipamento atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @equipment.destroy
    redirect_to equipments_url, notice: 'Equipamento excluído com sucesso.'
  end

  private

  def set_equipment
    @equipment = Equipment.find(params[:id])
  end

  def equipment_params
    params.require(:equipment).permit(:name, :code, :description, :category_id, :status, :control_type)
  end
end 