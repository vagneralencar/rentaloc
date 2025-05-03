class CreateEquipmentMaintenanceParts < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment_maintenance_parts do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :equipment_maintenance, null: false, foreign_key: true
      t.string :name, null: false
      t.string :part_number
      t.string :manufacturer
      t.string :supplier
      t.decimal :quantity, precision: 10, scale: 2, null: false
      t.decimal :unit_price, precision: 10, scale: 2, null: false
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.text :description
      t.text :notes

      t.timestamps
    end

    add_index :equipment_maintenance_parts, :part_number
    add_index :equipment_maintenance_parts, :manufacturer
    add_index :equipment_maintenance_parts, :supplier
  end
end 