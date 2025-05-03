class CreateSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :sessions do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :token, null: false
      t.datetime :expires_at
      t.string :ip_address
      t.string :user_agent
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :sessions, :token, unique: true
    add_index :sessions, :expires_at
  end
end 