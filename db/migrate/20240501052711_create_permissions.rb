class CreatePermissions < ActiveRecord::Migration[7.1]
  def change
    create_table :permissions do |t|
      t.references :tenant, null: false, foreign_key: true
      t.string :name, null: false
      t.string :action, null: false
      t.string :subject_class, null: false
      t.text :description
      t.boolean :is_system, default: false
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :permissions, [:tenant_id, :name], unique: true
    add_index :permissions, [:action, :subject_class]
    add_index :permissions, :is_system
  end
end 