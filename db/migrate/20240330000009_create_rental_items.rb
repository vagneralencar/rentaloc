class CreateRentalItems < ActiveRecord::Migration[7.1]
  def change
    create_table :rental_items do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :rental, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true
      t.decimal :quantity, precision: 10, scale: 2, null: false
      t.decimal :unit_price, precision: 10, scale: 2, null: false
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.text :notes

      t.timestamps
    end

    add_index :rental_items, [:rental_id, :equipment_id], unique: true
  end
end 