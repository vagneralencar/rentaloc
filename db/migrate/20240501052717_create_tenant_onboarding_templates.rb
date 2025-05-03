class CreateTenantOnboardingTemplates < ActiveRecord::Migration[7.1]
  def change
    create_table :tenant_onboarding_templates do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.text :description
      t.json :default_settings, default: {}
      t.json :default_steps, default: {}
      t.json :default_roles, default: {}
      t.json :default_permissions, default: {}
      t.boolean :is_active, default: true
      t.json :additional_data, default: {}

      t.timestamps
    end

    add_index :tenant_onboarding_templates, :code, unique: true
    add_index :tenant_onboarding_templates, :is_active
  end
end 