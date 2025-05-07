class AddFiscalFieldsToPeople < ActiveRecord::Migration[7.1]
  def change
    add_column :people, :fiscal_type, :string
    add_column :people, :state_registration, :string
    add_column :people, :municipal_registration, :string
    # add_column :people, :fiscal_email, :string  # Removido pois já existe
    add_column :people, :cnae, :string
    add_column :people, :tax_regime, :string
    add_column :people, :withhold_iss, :boolean
    add_column :people, :withhold_inss, :boolean
    add_column :people, :withhold_ir, :boolean
    add_column :people, :withhold_pis_cofins_csll, :boolean
  end
end
