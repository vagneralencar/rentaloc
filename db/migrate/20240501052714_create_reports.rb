class CreateReports < ActiveRecord::Migration[7.1]
  def change
    create_table :reports do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.string :name, null: false
      t.string :code, null: false
      t.string :category, null: false
      t.text :description
      t.text :query
      t.json :parameters, default: {}
      t.json :output_format, default: {}
      t.boolean :is_system, default: false
      t.boolean :is_active, default: true
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :reports, [:tenant_id, :code], unique: true
    add_index :reports, :category
    add_index :reports, :is_system
    add_index :reports, :is_active
  end
end 