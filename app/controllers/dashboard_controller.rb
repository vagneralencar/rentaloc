class DashboardController < ApplicationController
  def index
    @total_customers = Customer.count
    @total_equipments = Equipment.count
    @active_rentals = Rental.active.count
    @pending_service_orders = ServiceOrder.pending.count
    @overdue_invoices = RentalBilling.overdue.count
    
    @recent_rentals = Rental.order(created_at: :desc).limit(5)
    @recent_service_orders = ServiceOrder.order(created_at: :desc).limit(5)
  end
end
