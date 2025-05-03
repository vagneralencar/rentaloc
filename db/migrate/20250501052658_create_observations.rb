class CreateObservations < ActiveRecord::Migration[7.1]
  def change
    create_table :observations do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :observable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true
      t.text :content, null: false

      t.timestamps
    end

    add_index :observations, [:tenant_id, :observable_type, :observable_id], name: 'idx_observations_tenant_observable'
    add_index :observations, :created_at
  end
end
