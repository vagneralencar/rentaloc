class AddPersonIdToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :person_id, :integer
  end
end
