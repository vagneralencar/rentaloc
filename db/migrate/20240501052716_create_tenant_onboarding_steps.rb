class CreateTenantOnboardingSteps < ActiveRecord::Migration[7.1]
  def change
    create_table :tenant_onboarding_steps do |t|
      t.references :tenant, null: false, foreign_key: true
      t.string :code, null: false
      t.string :name, null: false
      t.text :description
      t.integer :order, null: false
      t.boolean :required, default: true
      t.boolean :completed, default: false
      t.datetime :completed_at
      t.json :data, default: {}
      t.json :validation_rules, default: {}
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :tenant_onboarding_steps, [:tenant_id, :code], unique: true
    add_index :tenant_onboarding_steps, :order
    add_index :tenant_onboarding_steps, :completed
  end
end 