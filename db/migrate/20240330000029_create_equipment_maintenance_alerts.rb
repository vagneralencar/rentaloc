class CreateEquipmentMaintenanceAlerts < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment_maintenance_alerts do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.references :equipment_maintenance_schedule, null: true, foreign_key: true
      t.integer :alert_type, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.integer :priority, null: false, default: 1
      t.string :message, null: false
      t.date :due_date, null: false
      t.text :notes
      t.json :additional_data, default: {}
      
      t.timestamps
    end
    
    add_index :equipment_maintenance_alerts, :alert_type
    add_index :equipment_maintenance_alerts, :status
    add_index :equipment_maintenance_alerts, :priority
    add_index :equipment_maintenance_alerts, :due_date
  end
end 