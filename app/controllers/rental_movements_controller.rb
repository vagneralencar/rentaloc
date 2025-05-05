class RentalMovementsController < ApplicationController
  before_action :set_rental

  def index
    # Listagem das movimentações (remessa/devolução)
  end

  private
  def set_rental
    @rental = Rental.find(params[:rental_id])
  end
end
