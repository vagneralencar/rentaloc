class AddPersonIdToWorks < ActiveRecord::Migration[7.1]
  def change
    add_column :works, :person_id, :integer
  end
end
