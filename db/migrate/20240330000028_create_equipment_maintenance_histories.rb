class CreateEquipmentMaintenanceHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment_maintenance_histories do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true
      t.references :performed_by, null: false, foreign_key: { to_table: :users }
      t.references :equipment_maintenance, null: true, foreign_key: true
      t.integer :maintenance_type, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.date :maintenance_date, null: false
      t.text :description
      t.text :notes
      t.json :additional_data, default: {}
      
      t.timestamps
    end
    
    add_index :equipment_maintenance_histories, :maintenance_type
    add_index :equipment_maintenance_histories, :status
    add_index :equipment_maintenance_histories, :maintenance_date
  end
end 