class DropCustomersAndSuppliersTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :customers, if_exists: true
    drop_table :suppliers, if_exists: true
  end
end
