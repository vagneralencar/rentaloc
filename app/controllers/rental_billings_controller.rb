class RentalBillingsController < ApplicationController
  before_action :set_rental_billing, only: [:show, :edit, :update, :destroy]

  def index
    @rental_billings = RentalBilling.all
  end

  def show
  end

  def new
    @rental_billing = RentalBilling.new
  end

  def edit
  end

  def create
    @rental_billing = RentalBilling.new(rental_billing_params)

    if @rental_billing.save
      redirect_to @rental_billing, notice: 'Faturamento criado com sucesso.'
    else
      render :new
    end
  end

  def update
    if @rental_billing.update(rental_billing_params)
      redirect_to @rental_billing, notice: 'Faturamento atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @rental_billing.destroy
    redirect_to rental_billings_url, notice: 'Faturamento excluído com sucesso.'
  end

  private

  def set_rental_billing
    @rental_billing = RentalBilling.find(params[:id])
  end

  def rental_billing_params
    params.require(:rental_billing).permit(:rental_id, :due_date, :status, :total_amount)
  end
end 