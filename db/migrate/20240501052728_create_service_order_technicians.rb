class CreateServiceOrderTechnicians < ActiveRecord::Migration[7.1]
  def change
    create_table :service_order_technicians do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :service_order, null: false, foreign_key: true
      t.references :technician, null: false, foreign_key: { to_table: :users }
      t.datetime :scheduled_start_at
      t.datetime :scheduled_end_at
      t.datetime :actual_start_at
      t.datetime :actual_end_at
      t.integer :status, default: 0
      t.text :notes
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :service_order_technicians, [:service_order_id, :technician_id], 
              unique: true, 
              name: 'idx_service_order_technicians_unique'
    add_index :service_order_technicians, :status
  end
end 