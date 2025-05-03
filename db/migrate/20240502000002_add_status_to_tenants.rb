class AddStatusToTenants < ActiveRecord::Migration[7.1]
  def change
    add_column :tenants, :status, :integer, default: 0, null: false
    add_index :tenants, :status
  end
end 