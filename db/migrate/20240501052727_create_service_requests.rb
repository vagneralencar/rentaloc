class CreateServiceRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :service_requests do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.references :customer, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true
      t.date :request_date, null: false
      t.text :description, null: false
      t.integer :priority, null: false
      t.integer :status, default: 0
      t.date :completion_date
      t.text :notes
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :service_requests, :request_date
    add_index :service_requests, :priority
    add_index :service_requests, :status
    add_index :service_requests, :completion_date
  end
end 