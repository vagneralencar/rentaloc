class CreateEquipmentMaintenanceDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment_maintenance_documents do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :equipment_maintenance, null: false, foreign_key: true
      t.integer :document_type, default: 3
      t.text :description
      t.text :notes

      t.timestamps
    end

    add_index :equipment_maintenance_documents, :document_type
  end
end 