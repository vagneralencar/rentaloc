class CreateFinancialNatures < ActiveRecord::Migration[7.1]
  def change
    create_table :financial_natures do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :parent, foreign_key: { to_table: :financial_natures }
      t.string :code, null: false
      t.string :name, null: false
      t.text :description
      t.integer :status, null: false
      t.integer :nature_type, null: false

      t.timestamps
    end

    add_index :financial_natures, [:tenant_id, :code], unique: true
    add_index :financial_natures, :status
    add_index :financial_natures, :nature_type
  end
end
