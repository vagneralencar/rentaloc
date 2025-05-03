class CreateFinancialReports < ActiveRecord::Migration[7.1]
  def change
    create_table :financial_reports do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.string :name, null: false
      t.string :code, null: false
      t.string :category, null: false
      t.text :description
      t.json :parameters, default: {}
      t.json :filters, default: {}
      t.json :output_format, default: {}
      t.boolean :is_system, default: false
      t.boolean :is_active, default: true
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :financial_reports, [:tenant_id, :code], unique: true
    add_index :financial_reports, :category
    add_index :financial_reports, :is_system
    add_index :financial_reports, :is_active
  end
end 