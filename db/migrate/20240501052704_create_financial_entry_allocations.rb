class CreateFinancialEntryAllocations < ActiveRecord::Migration[7.1]
  def change
    create_table :financial_entry_allocations do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :financial_entry, null: false, foreign_key: true
      t.references :financial_nature, null: false, foreign_key: true
      t.references :cost_center, null: false, foreign_key: true
      t.decimal :percentage, precision: 5, scale: 2, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.text :notes
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :financial_entry_allocations, [:financial_entry_id, :financial_nature_id, :cost_center_id], 
              unique: true, 
              name: 'idx_financial_entry_allocations_unique'
  end
end 