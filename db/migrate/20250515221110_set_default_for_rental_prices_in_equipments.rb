class SetDefaultForRentalPricesInEquipments < ActiveRecord::Migration[6.1]
  def change
    change_column_default :equipments, :rental_prices, from: nil, to: {}
  end
end
