class AddFiscalEmailToPeople < ActiveRecord::Migration[7.1]
  def change
    add_column :people, :fiscal_email, :string
  end
end
