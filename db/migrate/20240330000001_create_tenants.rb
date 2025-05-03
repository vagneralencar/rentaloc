class CreateTenants < ActiveRecord::Migration[7.1]
  def change
    create_table :tenants do |t|
      t.string :name, null: false
      t.string :cnpj, null: false
      t.string :email, null: false
      t.string :phone
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :logo
      t.json :settings, default: {}
      t.boolean :active, default: true
      t.datetime :trial_ends_at
      t.datetime :subscription_ends_at

      t.timestamps
    end

    add_index :tenants, :cnpj, unique: true
    add_index :tenants, :email, unique: true
  end
end 