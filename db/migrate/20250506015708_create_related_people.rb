class CreateRelatedPeople < ActiveRecord::Migration[7.1]
  def change
    create_table :related_people do |t|
      t.references :person, null: false, foreign_key: true
      t.string :cpf_cnpj
      t.string :name
      t.string :relation_type
      t.boolean :active

      t.timestamps
    end
  end
end
