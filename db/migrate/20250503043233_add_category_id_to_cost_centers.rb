class AddCategoryIdToCostCenters < ActiveRecord::Migration[7.1]
  def change
    add_column :cost_centers, :category_id, :integer
  end
end
