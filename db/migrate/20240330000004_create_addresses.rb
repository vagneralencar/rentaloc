class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :addressable, polymorphic: true, null: false
      t.integer :address_type, default: 0
      t.string :street, null: false
      t.string :number, null: false
      t.string :complement
      t.string :neighborhood, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip_code, null: false
      t.text :notes
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :addresses, [:addressable_type, :addressable_id]
    add_index :addresses, :zip_code
  end
end 