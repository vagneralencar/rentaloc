class CreatePriceTableItems < ActiveRecord::Migration[7.1]
  def change
    create_table :price_table_items do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :price_table, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true
      t.decimal :daily_price, precision: 10, scale: 2, null: false
      t.decimal :weekly_price, precision: 10, scale: 2
      t.decimal :biweekly_price, precision: 10, scale: 2
      t.decimal :monthly_price, precision: 10, scale: 2
      t.decimal :quarterly_price, precision: 10, scale: 2
      t.decimal :semester_price, precision: 10, scale: 2
      t.decimal :yearly_price, precision: 10, scale: 2
      t.decimal :minimum_daily_price, precision: 10, scale: 2
      t.integer :minimum_rental_days
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :price_table_items, [:price_table_id, :equipment_id], unique: true
  end
end 