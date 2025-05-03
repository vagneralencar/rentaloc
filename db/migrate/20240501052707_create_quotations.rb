class CreateQuotations < ActiveRecord::Migration[7.1]
  def change
    create_table :quotations do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.string :number, null: false
      t.date :valid_until, null: false
      t.integer :status, default: 0
      t.decimal :total_amount, precision: 10, scale: 2, default: 0
      t.text :description
      t.text :terms_and_conditions
      t.text :notes
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :quotations, [:tenant_id, :number], unique: true
    add_index :quotations, :status
    add_index :quotations, :valid_until
  end
end 