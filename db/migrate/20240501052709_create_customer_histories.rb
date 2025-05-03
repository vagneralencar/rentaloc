class CreateCustomerHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :customer_histories do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.references :historyable, polymorphic: true
      t.integer :history_type, null: false
      t.string :title, null: false
      t.text :description
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :customer_histories, [:tenant_id, :customer_id, :history_type]
    add_index :customer_histories, [:historyable_type, :historyable_id]
  end
end 