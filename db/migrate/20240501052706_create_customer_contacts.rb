class CreateCustomerContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :customer_contacts do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.string :name, null: false
      t.string :position
      t.string :department
      t.string :email
      t.string :phone
      t.string :mobile_phone
      t.boolean :is_main_contact, default: false
      t.boolean :receives_notifications, default: false
      t.text :notes
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :customer_contacts, [:tenant_id, :customer_id, :email], unique: true
    add_index :customer_contacts, :is_main_contact
  end
end 