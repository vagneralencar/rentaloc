class CreateSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :settings do |t|
      t.references :tenant, null: false, foreign_key: true
      t.string :key, null: false
      t.text :value
      t.string :value_type, default: 'string'
      t.text :description
      t.boolean :is_system, default: false
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :settings, [:tenant_id, :key], unique: true
    add_index :settings, :is_system
  end
end 