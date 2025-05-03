class AddWorkTypeToWorks < ActiveRecord::Migration[7.1]
  def change
    add_column :works, :work_type, :integer
  end
end
