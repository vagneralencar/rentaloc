class CreateCreditReferences < ActiveRecord::Migration[7.1]
  def change
    create_table :credit_references do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true
      t.integer :reference_type, null: false
      t.string :name, null: false
      t.string :contact_name, null: false
      t.string :phone, null: false
      t.text :additional_info

      t.timestamps
    end

    add_index :credit_references, :reference_type
  end
end
