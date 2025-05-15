source "https://rubygems.org"

ruby "3.2.2"

# Rails e dependências principais
gem "rails", "~> 7.2.2"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4", group: :development
gem "pg", group: :production
gem "puma", ">= 5.0"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

# Frontend
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "sassc-rails"

# Autenticação e Autorização
gem "devise"
gem "cancancan"
gem "rolify"

# Multi-tenancy
gem "acts_as_tenant"

# Background Jobs
gem "sidekiq"
gem "sidekiq-scheduler"
gem "redis"

# UI e Templates
#gem "jsbundling-rails"
gem "cssbundling-rails"
gem "slim-rails"
gem "simple_form"
gem "kaminari"
gem "ransack"

# PDF e Relatórios
gem "wicked_pdf"
gem "wkhtmltopdf-binary"

# Utilitários
gem "faker", group: :development
gem "annotate", group: :development
gem "bullet", group: :development
gem "rack-cors"

# Monitoramento e Logging
gem "lograge"
gem "sentry-ruby"
gem "sentry-rails"
gem "health_check"
gem "prometheus_exporter"

# Segurança
gem "rack-attack"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "shoulda-matchers"
  gem "database_cleaner"
  gem 'rails_db'
end

group :development do
  gem "web-console"
  gem "rack-mini-profiler"
  gem "spring"
  gem "spring-watcher-listen"
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
