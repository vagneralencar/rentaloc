class CreateWorks < ActiveRecord::Migration[7.1]
  def change
    create_table :works do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: { to_table: :people }
      t.string :code, null: false
      t.string :name, null: false
      t.text :description
      t.integer :status, null: false
      t.date :start_date, null: false
      t.date :expected_end_date, null: false
      t.date :end_date

      t.timestamps
    end

    add_index :works, [:tenant_id, :code], unique: true
    add_index :works, :status
    add_index :works, :start_date
    add_index :works, :expected_end_date
    add_index :works, :end_date
  end
end
