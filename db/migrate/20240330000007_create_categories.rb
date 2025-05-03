class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.references :tenant, null: false, foreign_key: true
      t.string :name, null: false
      t.string :code, null: false
      t.text :description
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :categories, [:tenant_id, :code], unique: true
  end
end 