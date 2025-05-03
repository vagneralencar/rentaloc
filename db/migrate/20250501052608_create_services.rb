class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :category, foreign_key: true
      t.string :code, null: false
      t.string :name, null: false
      t.text :description
      t.integer :status, null: false
      t.string :unit, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.text :nfs_description, null: false

      t.timestamps
    end

    add_index :services, [:tenant_id, :code], unique: true
    add_index :services, :status
    add_index :services, :unit
  end
end
