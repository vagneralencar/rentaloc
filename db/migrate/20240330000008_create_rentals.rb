class CreateRentals < ActiveRecord::Migration[7.1]
  def change
    create_table :rentals do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: { to_table: :people }
      t.references :work, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.references :seller, foreign_key: { to_table: :users }
      t.references :cost_center, foreign_key: true
      t.references :financial_nature, foreign_key: true
      t.references :price_table, foreign_key: true
      t.string :number, null: false
      t.date :issue_date, null: false
      t.date :start_date, null: false
      t.date :first_billing_date, null: false
      t.integer :due_day, null: false
      t.date :expected_end_date
      t.date :end_date
      t.integer :status, default: 0
      t.string :payment_condition
      t.string :payment_method
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_email
      t.text :notes
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :rentals, [:tenant_id, :number], unique: true
    add_index :rentals, :status
    add_index :rentals, :issue_date
    add_index :rentals, :start_date
    add_index :rentals, :end_date
  end
end 