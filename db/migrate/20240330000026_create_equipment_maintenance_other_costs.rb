class CreateEquipmentMaintenanceOtherCosts < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment_maintenance_other_costs do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :equipment_maintenance, null: false, foreign_key: true
      t.integer :cost_type, default: 3
      t.text :description, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.text :notes

      t.timestamps
    end

    add_index :equipment_maintenance_other_costs, :cost_type
  end
end 