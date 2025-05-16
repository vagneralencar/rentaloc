class ConsolidateWorkCustomerColumns < ActiveRecord::Migration[7.1]
  def up
    # First, copy any data from person_id to customer_id where customer_id is null
    execute <<-SQL
      UPDATE works 
      SET customer_id = person_id 
      WHERE customer_id IS NULL AND person_id IS NOT NULL
    SQL

    # Then, copy any data from customer_id to person_id where person_id is null
    execute <<-SQL
      UPDATE works 
      SET person_id = customer_id 
      WHERE person_id IS NULL AND customer_id IS NOT NULL
    SQL

    # Remove the customer_id column since we'll use person_id
    remove_column :works, :customer_id
  end

  def down
    # Add back the customer_id column
    add_column :works, :customer_id, :integer

    # Copy data back from person_id to customer_id
    execute <<-SQL
      UPDATE works 
      SET customer_id = person_id 
      WHERE person_id IS NOT NULL
    SQL

    # Add back the foreign key constraint
    add_foreign_key :works, :people, column: :customer_id
  end
end 