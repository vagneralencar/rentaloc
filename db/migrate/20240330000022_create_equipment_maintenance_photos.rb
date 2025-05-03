class CreateEquipmentMaintenancePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment_maintenance_photos do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :equipment_maintenance, null: false, foreign_key: true
      t.integer :photo_type, default: 3
      t.text :description
      t.text :notes

      t.timestamps
    end

    add_index :equipment_maintenance_photos, :photo_type
  end
end 