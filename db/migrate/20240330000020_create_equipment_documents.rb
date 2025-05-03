class CreateEquipmentDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment_documents do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true
      t.integer :document_type, default: 4
      t.text :description
      t.text :notes

      t.timestamps
    end

    add_index :equipment_documents, :document_type
  end
end 