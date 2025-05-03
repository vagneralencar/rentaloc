class AccessoriesController < ApplicationController
  before_action :set_accessory, only: [:show, :edit, :update, :destroy]

  def index
    @accessories = Accessory.all
  end

  def show
  end

  def new
    @accessory = Accessory.new
  end

  def edit
  end

  def create
    @accessory = Accessory.new(accessory_params)

    if @accessory.save
      redirect_to @accessory, notice: 'Acessório criado com sucesso.'
    else
      render :new
    end
  end

  def update
    if @accessory.update(accessory_params)
      redirect_to @accessory, notice: 'Acessório atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @accessory.destroy
    redirect_to accessories_url, notice: 'Acessório excluído com sucesso.'
  end

  private

  def set_accessory
    @accessory = Accessory.find(params[:id])
  end

  def accessory_params
    params.require(:accessory).permit(:name, :description, :status, :equipment_id)
  end
end 