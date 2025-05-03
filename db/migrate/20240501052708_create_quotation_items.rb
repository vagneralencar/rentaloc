class CreateQuotationItems < ActiveRecord::Migration[7.1]
  def change
    create_table :quotation_items do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :quotation, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true
      t.decimal :quantity, precision: 10, scale: 2, null: false
      t.decimal :unit_price, precision: 10, scale: 2, null: false
      t.decimal :total_amount, precision: 10, scale: 2, null: false
      t.integer :period_type, null: false
      t.integer :period_quantity, null: false
      t.text :description
      t.text :notes

      t.timestamps
    end

    add_index :quotation_items, [:quotation_id, :equipment_id], unique: true
  end
end 