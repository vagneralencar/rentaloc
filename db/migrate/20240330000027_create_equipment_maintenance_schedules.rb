class CreateEquipmentMaintenanceSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment_maintenance_schedules do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.integer :maintenance_type, null: false
      t.integer :frequency, null: false
      t.date :last_maintenance_date, null: false
      t.date :next_maintenance_date, null: false
      t.integer :status, default: 0
      t.text :description
      t.text :notes
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :equipment_maintenance_schedules, :maintenance_type
    add_index :equipment_maintenance_schedules, :frequency
    add_index :equipment_maintenance_schedules, :status
    add_index :equipment_maintenance_schedules, :last_maintenance_date
    add_index :equipment_maintenance_schedules, :next_maintenance_date
  end
end 