class CreateServiceOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :service_orders do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.string :number, null: false
      t.date :start_date, null: false
      t.date :due_date
      t.date :completion_date
      t.integer :status, default: 0
      t.integer :priority, default: 1
      t.decimal :total_amount, precision: 10, scale: 2, default: 0
      t.text :description
      t.text :solution
      t.text :notes
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :service_orders, [:tenant_id, :number], unique: true
    add_index :service_orders, :status
    add_index :service_orders, :priority
    add_index :service_orders, :start_date
    add_index :service_orders, :due_date
  end
end 