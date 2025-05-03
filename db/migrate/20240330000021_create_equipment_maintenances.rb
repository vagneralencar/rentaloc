class CreateEquipmentMaintenances < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment_maintenances do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.integer :maintenance_type, null: false
      t.date :start_date, null: false
      t.date :due_date
      t.date :completion_date
      t.integer :status, default: 0
      t.integer :priority, default: 1
      t.decimal :labor_cost, precision: 10, scale: 2
      t.decimal :parts_cost, precision: 10, scale: 2
      t.decimal :other_costs, precision: 10, scale: 2
      t.decimal :total_cost, precision: 10, scale: 2
      t.text :description
      t.text :solution
      t.text :notes
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :equipment_maintenances, :maintenance_type
    add_index :equipment_maintenances, :status
    add_index :equipment_maintenances, :priority
    add_index :equipment_maintenances, :start_date
    add_index :equipment_maintenances, :due_date
  end
end 