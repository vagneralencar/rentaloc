class CreateRentalMovementItems < ActiveRecord::Migration[7.1]
  def change
    create_table :rental_movement_items do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :rental_movement, null: false, foreign_key: true
      t.references :rental_item, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true
      t.decimal :quantity, precision: 10, scale: 2, null: false
      t.decimal :total_quantity, precision: 10, scale: 2, null: false
      t.text :notes

      t.timestamps
    end

    add_index :rental_movement_items, [:rental_movement_id, :rental_item_id], unique: true
    add_index :rental_movement_items, [:rental_movement_id, :equipment_id], unique: true
  end
end 