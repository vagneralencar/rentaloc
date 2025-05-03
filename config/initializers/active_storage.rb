# Be sure to restart your server when you modify this file.

# Configure Active Storage service
Rails.application.config.active_storage.service = Rails.env.production? ? :amazon : :local

# Configure Active Storage service URLs
Rails.application.config.active_storage.service_urls_expire_in = 1.hour
Rails.application.config.active_storage.resolve_model_to_route = :rails_storage_proxy

# Configure Active Storage service configurations
Rails.application.config.active_storage.service_configurations = {
  local: {
    service: "Disk",
    root: Rails.root.join("storage")
  },
  test: {
    service: "Disk",
    root: Rails.root.join("tmp/storage")
  },
  amazon: {
    service: "S3",
    access_key_id: ENV["AWS_ACCESS_KEY_ID"],
    secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
    region: ENV["AWS_REGION"],
    bucket: ENV["AWS_BUCKET"]
  }
}

# Configure Active Storage service URL options
Rails.application.config.active_storage.service_urls_options = {
  disposition: :attachment,
  filename: :original,
  content_type: :content_type,
  content_length: :content_length
}

# Configure Active Storage for test environment
if Rails.env.test?
  Rails.application.config.active_storage.service = :test
  Rails.application.config.active_storage.queue = false
  Rails.application.config.active_storage.replace_on_assign_to_many = true
  Rails.application.config.active_storage.track_variants = false
end

# Configure Active Storage service URL host
Rails.application.config.active_storage.service_urls_host = 'localhost:3000'

# Configure Active Storage service URL path
Rails.application.config.active_storage.service_urls_path = '/rails/active_storage'

# Configure Active Storage service URL prefix
Rails.application.config.active_storage.service_urls_prefix = '/rails/active_storage'

# Configure Active Storage service URL suffix
Rails.application.config.active_storage.service_urls_suffix = ''

# Configure Active Storage service URL content type
Rails.application.config.active_storage.service_urls_content_type = "application/pdf"

# Configure Active Storage service URL content disposition
Rails.application.config.active_storage.service_urls_content_disposition = "attachment"

# Configure Active Storage service URL content length
Rails.application.config.active_storage.service_urls_content_length = nil

# Configure Active Storage service URL content encoding
Rails.application.config.active_storage.service_urls_content_encoding = nil

# Configure Active Storage service URL content language
Rails.application.config.active_storage.service_urls_content_language = nil

# Configure Active Storage service URL content location
Rails.application.config.active_storage.service_urls_content_location = nil

# Configure Active Storage service URL content md5
Rails.application.config.active_storage.service_urls_content_md5 = nil

# Configure Active Storage service URL content range
Rails.application.config.active_storage.service_urls_content_range = nil

# Configurações específicas para ambiente de teste
if Rails.env.test?
  Rails.application.config.active_storage.service = :test
  Rails.application.config.active_storage.service_urls_expire_in = 1.hour
  Rails.application.config.active_storage.service_urls_host = 'localhost:3000'
  Rails.application.config.active_storage.service_urls_path = '/rails/active_storage'
  Rails.application.config.active_storage.service_urls_prefix = '/rails/active_storage'
  Rails.application.config.active_storage.service_urls_suffix = ''
  Rails.application.config.active_storage.service_urls_options = {
    disposition: 'inline',
    filename: nil,
    content_type: nil,
    content_disposition: nil,
    content_length: nil,
    content_encoding: nil,
    content_language: nil,
    content_location: nil,
    content_md5: nil,
    content_range: nil
  }
end 