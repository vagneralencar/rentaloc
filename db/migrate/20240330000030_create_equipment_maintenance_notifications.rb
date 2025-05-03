class CreateEquipmentMaintenanceNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment_maintenance_notifications do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :equipment_maintenance_alert, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :notification_type, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.string :message, null: false
      t.datetime :sent_at
      t.datetime :read_at
      t.text :error_message
      t.json :additional_data, default: {}
      
      t.timestamps
    end
    
    add_index :equipment_maintenance_notifications, :notification_type
    add_index :equipment_maintenance_notifications, :status
    add_index :equipment_maintenance_notifications, :sent_at
    add_index :equipment_maintenance_notifications, :read_at
  end
end 