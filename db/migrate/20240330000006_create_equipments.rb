class CreateEquipments < ActiveRecord::Migration[7.1]
  def change
    create_table :equipments do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :category, foreign_key: true
      t.string :code, null: false
      t.string :name, null: false
      t.text :description
      t.integer :status, default: 0
      t.integer :control_type, default: 0
      t.string :unit
      t.decimal :depreciation_rate, precision: 5, scale: 2
      t.decimal :weight, precision: 10, scale: 2
      t.decimal :last_purchase_price, precision: 10, scale: 2
      t.date :last_purchase_date
      t.decimal :sale_price, precision: 10, scale: 2
      t.decimal :indemnity_value, precision: 10, scale: 2
      t.string :brand
      t.string :model
      t.string :serial_number
      t.string :documentation_url
      t.string :ncm
      t.string :cest
      t.integer :origin
      t.json :rental_prices, default: {}
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :equipments, [:tenant_id, :code], unique: true
    add_index :equipments, :status
    add_index :equipments, :control_type
  end
end 