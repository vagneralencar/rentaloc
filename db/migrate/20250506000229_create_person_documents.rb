class CreatePersonDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :person_documents do |t|
      t.references :person, null: false, foreign_key: true
      t.references :tenant, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
