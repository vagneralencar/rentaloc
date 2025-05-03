class CreateRentalBillingItems < ActiveRecord::Migration[7.1]
  def change
    create_table :rental_billing_items do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :rental_billing, null: false, foreign_key: true
      t.references :rental_item, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :days, null: false
      t.decimal :quantity, precision: 10, scale: 2, null: false
      t.decimal :unit_price, precision: 10, scale: 2, null: false
      t.decimal :total_amount, precision: 10, scale: 2, null: false
      t.text :notes

      t.timestamps
    end

    add_index :rental_billing_items, [:rental_billing_id, :rental_item_id], unique: true
    add_index :rental_billing_items, [:rental_billing_id, :equipment_id], unique: true
  end
end 