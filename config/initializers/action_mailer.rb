# Be sure to restart your server when you modify this file.

Rails.application.configure do
  # Configure the e-mail address which will be shown in Devise::Mailer,
  # note that it will be overwritten if you use your own mailer class
  # with default "from" parameter.
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # Configure the class responsible to send e-mails.
  config.action_mailer.delivery_method = :smtp

  # Configure the SMTP settings.
  config.action_mailer.smtp_settings = {
    address: ENV.fetch('SMTP_ADDRESS', 'smtp.gmail.com'),
    port: ENV.fetch('SMTP_PORT', 587),
    domain: ENV.fetch('SMTP_DOMAIN', 'localhost'),
    user_name: ENV['SMTP_USERNAME'],
    password: ENV['SMTP_PASSWORD'],
    authentication: 'plain',
    enable_starttls_auto: true
  }

  # Configure default options
  config.action_mailer.default_options = {
    from: 'noreply@example.com',
    reply_to: 'noreply@example.com',
    charset: 'utf-8',
    content_type: 'text/html'
  }

  # Configure delivery settings
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  # Configure asset settings
  config.action_mailer.asset_host = 'http://localhost:3000'

  # Configurações específicas para ambiente de teste
  if Rails.env.test?
    config.action_mailer.delivery_method = :test
    config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.asset_host = nil
  end
end 