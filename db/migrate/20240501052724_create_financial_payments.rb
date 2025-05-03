class CreateFinancialPayments < ActiveRecord::Migration[7.1]
  def change
    create_table :financial_payments do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :financial_entry, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.date :payment_date, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.integer :payment_method, null: false
      t.string :document_number
      t.text :notes
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :financial_payments, [:financial_entry_id, :payment_date]
    add_index :financial_payments, :payment_method
  end
end 