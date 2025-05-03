class CreateServiceTaxRules < ActiveRecord::Migration[7.1]
  def change
    create_table :service_tax_rules do |t|

      t.timestamps
    end
  end
end
