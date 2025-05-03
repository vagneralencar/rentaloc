class CreateEquipmentMaintenanceLabors < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment_maintenance_labors do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :equipment_maintenance, null: false, foreign_key: true
      t.references :performed_by, null: false, foreign_key: { to_table: :users }
      t.text :description, null: false
      t.decimal :hours, precision: 10, scale: 2, null: false
      t.decimal :hourly_rate, precision: 10, scale: 2, null: false
      t.decimal :total_amount, precision: 10, scale: 2, null: false
      t.text :notes

      t.timestamps
    end
  end
end 