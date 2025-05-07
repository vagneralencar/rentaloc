class CreateBankReferences < ActiveRecord::Migration[7.1]
  def change
    create_table :bank_references do |t|
      t.references :person, null: false, foreign_key: true
      t.string :bank_name
      t.string :agency
      t.string :account
      t.string :phone

      t.timestamps
    end
  end
end
