class CreateFinancialEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :financial_entries do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.references :financial_nature, null: false, foreign_key: true
      t.references :cost_center, null: false, foreign_key: true
      t.references :tax_rule, foreign_key: true
      t.date :entry_date, null: false
      t.date :due_date, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :description, null: false
      t.integer :entry_type, null: false
      t.integer :status, default: 0
      t.text :notes
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :financial_entries, :entry_date
    add_index :financial_entries, :due_date
    add_index :financial_entries, :entry_type
    add_index :financial_entries, :status
  end
end 