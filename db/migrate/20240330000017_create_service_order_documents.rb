class CreateServiceOrderDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :service_order_documents do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :service_order, null: false, foreign_key: true
      t.integer :document_type, default: 3
      t.text :description
      t.text :notes

      t.timestamps
    end

    add_index :service_order_documents, :document_type
  end
end 