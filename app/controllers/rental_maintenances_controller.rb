class RentalMaintenancesController < ApplicationController
  before_action :set_rental

  def index
    # Listagem das manutenções vinculadas ao contrato
  end

  private
  def set_rental
    @rental = Rental.find(params[:rental_id])
  end
end
