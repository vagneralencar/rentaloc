class AddBudgetToCostCenters < ActiveRecord::Migration[7.1]
  def change
    add_column :cost_centers, :budget, :decimal
  end
end
