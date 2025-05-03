class CreateRentalStatusHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :rental_status_histories do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :rental, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.integer :status, null: false
      t.text :notes
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :rental_status_histories, [:rental_id, :created_at]
    add_index :rental_status_histories, :status
  end
end 