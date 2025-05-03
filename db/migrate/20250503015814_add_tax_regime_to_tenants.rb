class AddTaxRegimeToTenants < ActiveRecord::Migration[7.1]
  def change
    add_column :tenants, :tax_regime, :integer
  end
end
