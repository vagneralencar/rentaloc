require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rails'
require 'shoulda/matchers'
require 'database_cleaner'

# Configuração do Shoulda Matchers
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

# Configuração do Factory Bot
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  
  # Database Cleaner
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end
  
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
  
  # Devise Test Helpers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Devise::Test::IntegrationHelpers, type: :system
  
  # Sistema de Testes
  config.before(:each, type: :system) do
    driven_by :selenium_chrome_headless
  end
  
  # Tenant para Testes
  config.before(:each) do
    tenant = create(:tenant)
    Current.tenant = tenant
  end
  
  config.after(:each) do
    Current.reset
  end
end 