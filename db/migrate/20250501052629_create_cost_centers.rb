class CreateCostCenters < ActiveRecord::Migration[7.1]
  def change
    create_table :cost_centers do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :parent, foreign_key: { to_table: :cost_centers }
      t.string :code, null: false
      t.string :name, null: false
      t.text :description
      t.integer :status, null: false

      t.timestamps
    end

    add_index :cost_centers, [:tenant_id, :code], unique: true
    add_index :cost_centers, :status
  end
end
