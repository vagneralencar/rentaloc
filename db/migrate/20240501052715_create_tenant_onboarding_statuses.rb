class CreateTenantOnboardingStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :tenant_onboarding_statuses do |t|
      t.references :tenant, null: false, foreign_key: true
      t.integer :status, default: 0
      t.datetime :started_at
      t.datetime :completed_at
      t.json :completed_steps, default: {}
      t.json :pending_steps, default: {}
      t.text :notes
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :tenant_onboarding_statuses, :status
    add_index :tenant_onboarding_statuses, :started_at
    add_index :tenant_onboarding_statuses, :completed_at
  end
end 