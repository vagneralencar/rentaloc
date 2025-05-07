class CreateCommercialReferences < ActiveRecord::Migration[7.1]
  def change
    create_table :commercial_references do |t|
      t.references :person, null: false, foreign_key: true
      t.string :company_name
      t.string :phone
      t.string :attendant
      t.date :first_purchase
      t.decimal :largest_purchase
      t.date :last_purchase
      t.string :payment_method
      t.string :observation

      t.timestamps
    end
  end
end
