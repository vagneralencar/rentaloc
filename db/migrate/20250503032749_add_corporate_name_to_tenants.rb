class AddCorporateNameToTenants < ActiveRecord::Migration[7.1]
  def change
    add_column :tenants, :corporate_name, :string
  end
end
