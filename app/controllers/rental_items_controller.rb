class RentalItemsController < ApplicationController
  before_action :set_rental

  def index
    # Listagem dos itens do contrato
  end

  private
  def set_rental
    @rental = Rental.find(params[:rental_id])
  end
end
