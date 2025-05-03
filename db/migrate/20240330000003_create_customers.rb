class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.references :tenant, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :document_type, default: 0
      t.string :document, null: false
      t.string :email, null: false
      t.string :phone
      t.string :trade_name
      t.string :state_registration
      t.string :municipal_registration
      t.integer :status, default: 0
      t.decimal :credit_limit, precision: 10, scale: 2, default: 0
      t.text :notes
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :customers, [:tenant_id, :document], unique: true
    add_index :customers, [:tenant_id, :email], unique: true
  end
end 