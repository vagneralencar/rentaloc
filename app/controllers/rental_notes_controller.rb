class RentalNotesController < ApplicationController
  before_action :set_rental

  def index
    # Listagem de anotações/acompanhamento do contrato
  end

  private
  def set_rental
    @rental = Rental.find(params[:rental_id])
  end
end
