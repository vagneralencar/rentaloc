class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :contactable, polymorphic: true, null: false
      t.integer :contact_type, default: 0
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone
      t.string :position
      t.text :notes
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :contacts, [:contactable_type, :contactable_id]
    add_index :contacts, :email
  end
end 