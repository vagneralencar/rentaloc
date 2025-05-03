class AddServiceIdToServiceTaxRules < ActiveRecord::Migration[7.1]
  def change
    add_column :service_tax_rules, :service_id, :integer
  end
end
