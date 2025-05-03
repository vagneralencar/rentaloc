class CreateServiceOrderPhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :service_order_photos do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :service_order, null: false, foreign_key: true
      t.integer :photo_type, default: 3
      t.text :description
      t.text :notes

      t.timestamps
    end

    add_index :service_order_photos, :photo_type
  end
end 