class CreatePeople < ActiveRecord::Migration[7.1]
  def change
    create_table :people do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :person_type, null: false
      t.integer :role, null: false
      t.integer :status, null: false
      t.string :document, null: false
      t.string :name, null: false
      t.string :trade_name
      t.string :email, null: false
      t.string :nfe_email
      t.string :activity
      t.string :region
      t.string :referral
      t.date :registration_date
      t.date :validity_date
      t.date :last_update
      t.string :phone_commercial
      t.string :phone_residential
      t.string :phone_mobile
      t.string :phone_financial

      t.timestamps
    end

    add_index :people, [:tenant_id, :document], unique: true
    add_index :people, [:tenant_id, :email], unique: true
    add_index :people, :person_type
    add_index :people, :role
    add_index :people, :status
    add_index :people, :region
  end
end
