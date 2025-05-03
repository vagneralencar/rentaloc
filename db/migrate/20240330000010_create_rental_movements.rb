class CreateRentalMovements < ActiveRecord::Migration[7.1]
  def change
    create_table :rental_movements do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :rental, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.integer :movement_type, null: false
      t.datetime :movement_date, null: false
      t.integer :status, default: 0
      t.string :document_number
      t.text :notes
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :rental_movements, :movement_type
    add_index :rental_movements, :movement_date
    add_index :rental_movements, :status
    add_index :rental_movements, [:rental_id, :movement_type]
  end
end 