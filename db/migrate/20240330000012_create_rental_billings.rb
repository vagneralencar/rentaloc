class CreateRentalBillings < ActiveRecord::Migration[7.1]
  def change
    create_table :rental_billings do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :rental, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.string :number, null: false
      t.date :billing_date, null: false
      t.date :due_date, null: false
      t.decimal :total_amount, precision: 10, scale: 2, null: false
      t.integer :status, default: 0
      t.integer :payment_method
      t.date :payment_date
      t.string :pdf_file
      t.text :notes
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :rental_billings, [:tenant_id, :number], unique: true
    add_index :rental_billings, :status
    add_index :rental_billings, :billing_date
    add_index :rental_billings, :due_date
  end
end 