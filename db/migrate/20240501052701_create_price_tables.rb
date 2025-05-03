class CreatePriceTables < ActiveRecord::Migration[7.1]
  def change
    create_table :price_tables do |t|
      t.references :tenant, null: false, foreign_key: true
      t.string :code, null: false
      t.string :name, null: false
      t.text :description
      t.date :start_date, null: false
      t.date :end_date
      t.integer :status, default: 0
      t.decimal :default_markup, precision: 10, scale: 2
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :price_tables, [:tenant_id, :code], unique: true
    add_index :price_tables, :status
    add_index :price_tables, :start_date
    add_index :price_tables, :end_date
  end
end 