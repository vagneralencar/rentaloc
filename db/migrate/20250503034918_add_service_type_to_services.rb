class AddServiceTypeToServices < ActiveRecord::Migration[7.1]
  def change
    add_column :services, :service_type, :integer
  end
end
