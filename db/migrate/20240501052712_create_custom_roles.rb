class CreateCustomRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :custom_roles do |t|
      t.references :tenant, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.boolean :is_system, default: false
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :custom_roles, [:tenant_id, :name], unique: true
    add_index :custom_roles, :is_system
  end
end 