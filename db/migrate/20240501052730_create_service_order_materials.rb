class CreateServiceOrderMaterials < ActiveRecord::Migration[7.1]
  def change
    create_table :service_order_materials do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :service_order, null: false, foreign_key: true
      t.references :material, null: false, foreign_key: true
      t.decimal :quantity, precision: 10, scale: 2, null: false
      t.decimal :unit_price, precision: 10, scale: 2, null: false
      t.decimal :total_amount, precision: 10, scale: 2, null: false
      t.boolean :is_billable, default: true
      t.string :serial_number
      t.text :description
      t.text :notes
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :service_order_materials, [:service_order_id, :material_id], unique: true
    add_index :service_order_materials, :is_billable
  end
end 