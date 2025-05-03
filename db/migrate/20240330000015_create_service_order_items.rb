class CreateServiceOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :service_order_items do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :service_order, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true
      t.decimal :quantity, precision: 10, scale: 2, null: false
      t.decimal :unit_price, precision: 10, scale: 2, null: false
      t.decimal :total_amount, precision: 10, scale: 2, null: false
      t.text :description
      t.text :notes

      t.timestamps
    end

    add_index :service_order_items, [:service_order_id, :equipment_id], unique: true
  end
end 