class CreateEquipmentAccessories < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment_accessories do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true
      t.references :accessory, null: false, foreign_key: { to_table: :equipments }
      t.integer :quantity, null: false
      t.integer :status, default: 0
      t.text :notes

      t.timestamps
    end

    add_index :equipment_accessories, [:equipment_id, :accessory_id], unique: true
    add_index :equipment_accessories, :status
  end
end 