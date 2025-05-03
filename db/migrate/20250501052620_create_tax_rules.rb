class CreateTaxRules < ActiveRecord::Migration[7.1]
  def change
    create_table :tax_rules do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :taxable, polymorphic: true, null: false
      t.integer :tax_type, null: false
      t.decimal :rate, precision: 5, scale: 2, null: false
      t.decimal :calculation_base, precision: 5, scale: 2, null: false
      t.boolean :withholding, null: false, default: false
      t.string :fiscal_code, null: false
      t.text :fiscal_code_description, null: false

      t.timestamps
    end

    add_index :tax_rules, [:tenant_id, :taxable_type, :taxable_id, :tax_type], unique: true, name: 'idx_tax_rules_unique'
    add_index :tax_rules, :tax_type
    add_index :tax_rules, :withholding
  end
end
