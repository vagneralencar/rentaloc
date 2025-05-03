class CreateRolePermissions < ActiveRecord::Migration[7.1]
  def change
    create_table :role_permissions do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true
      t.references :permission, null: false, foreign_key: true

      t.timestamps
    end

    add_index :role_permissions, [:role_id, :permission_id], unique: true
  end
end 