class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :edit, :update, :destroy]

  def index
    @rentals = Rental.all
  end

  def show
  end

  def new
    @rental = Rental.new
  end

  def edit
  end

  def create
    @rental = Rental.new(rental_params)

    if @rental.save
      redirect_to @rental, notice: 'Locação criada com sucesso.'
    else
      render :new
    end
  end

  def update
    if @rental.update(rental_params)
      redirect_to @rental, notice: 'Locação atualizada com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @rental.destroy
    redirect_to rentals_url, notice: 'Locação excluída com sucesso.'
  end

  private

  def set_rental
    @rental = Rental.find(params[:id])
  end

  def rental_params
    params.require(:rental).permit(:customer_id, :start_date, :end_date, :status, rental_items_attributes: [:id, :equipment_id, :quantity, :_destroy])
  end
end 