# Be sure to restart your server when you modify this file.

# Configuração padrão do Active Job
Rails.application.config.active_job.queue_adapter = :sidekiq

# Configurações específicas para ambiente de teste
if Rails.env.test?
  Rails.application.config.active_job.queue_adapter = :test
  Rails.application.config.active_job.logger = nil
  Rails.application.config.active_job.queue_name_prefix = nil
  Rails.application.config.active_job.queue_name_delimiter = nil
end

# Configuração das filas
Rails.application.config.active_job.custom_queues = {
  default: 'default',
  mailers: 'mailers',
  pdf: 'pdf',
  cleanup: 'cleanup'
}

# Configuração do logger
unless Rails.env.test?
  Rails.application.config.active_job.logger = ActiveSupport::Logger.new(Rails.root.join('log', "#{Rails.env}_active_job.log"))
  Rails.application.config.active_job.logger.formatter = Logger::Formatter.new
end

# Configure Active Job queue name
Rails.application.config.active_job.queue_name_prefix = "gestaoloc_#{Rails.env}"

# Configure Active Job queue name delimiter
Rails.application.config.active_job.queue_name_delimiter = '_'

# Configure Active Job default queue
Rails.application.config.active_job.default_queue_name = 'default'

# Configure Active Job queue adapter options
Rails.application.config.active_job.queue_adapter_options = {
  queue: 'pdf_generation',
  retry: 3,
  backoff: [60, 300, 900],
  timeout: 30.minutes
}

# Configure Active Job logger
Rails.application.config.active_job.logger = ActiveSupport::Logger.new(STDOUT)

# Configure Active Job logging
Rails.application.config.active_job.logger.level = :info

# Configure Active Job logging format
Rails.application.config.active_job.logger.formatter = proc do |severity, datetime, progname, msg|
  "[#{datetime.strftime('%Y-%m-%d %H:%M:%S')}] #{severity}: #{msg}\n"
end

# Configure Active Job logging options
Rails.application.config.active_job.logger_options = {
  level: :info,
  formatter: proc do |severity, datetime, progname, msg|
    "[#{datetime.strftime('%Y-%m-%d %H:%M:%S')}] #{severity}: #{msg}\n"
  end
}

# Configure Active Job logging to file
Rails.application.config.active_job.logger = ActiveSupport::Logger.new(
  Rails.root.join('log', 'active_job.log')
)

# Configure Active Job logging to file options
Rails.application.config.active_job.logger_options = {
  level: :info,
  formatter: proc do |severity, datetime, progname, msg|
    "[#{datetime.strftime('%Y-%m-%d %H:%M:%S')}] #{severity}: #{msg}\n"
  end,
  shift_age: 'daily',
  shift_size: 10.megabytes
}

# Configure Active Job logging to file with rotation
Rails.application.config.active_job.logger = ActiveSupport::Logger.new(
  Rails.root.join('log', 'active_job.log'),
  10,
  10.megabytes
)

# Configure Active Job logging to file with rotation options
Rails.application.config.active_job.logger_options = {
  level: :info,
  formatter: proc do |severity, datetime, progname, msg|
    "[#{datetime.strftime('%Y-%m-%d %H:%M:%S')}] #{severity}: #{msg}\n"
  end,
  shift_age: 'daily',
  shift_size: 10.megabytes,
  shift_period_suffix: '%Y%m%d'
} 