class AddSubdomainToTenants < ActiveRecord::Migration[7.1]
  def change
    add_column :tenants, :subdomain, :string
  end
end
