class AddStatusToEquipmentMaintenanceReports < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment_maintenance_reports do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :equipment_maintenance, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.text :description, null: false
      t.text :findings
      t.text :recommendations
      t.text :notes
      t.integer :status, default: 0, null: false

      t.timestamps
    end

    add_index :equipment_maintenance_reports, :status
  end
end 