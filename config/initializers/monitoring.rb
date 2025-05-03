# Configurações de Monitoramento e Logging

# Configuração do Lograge para logs estruturados
Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.base_controller_class = ['ActionController::Base']
  
  config.lograge.custom_options = lambda do |event|
    {
      tenant_id: Current.tenant&.id,
      user_id: Current.user&.id,
      params: event.payload[:params].except(*%w[controller action format id utf8 authenticity_token]),
      time: Time.current,
      remote_ip: event.payload[:remote_ip],
      user_agent: event.payload[:user_agent],
      request_id: event.payload[:request_id]
    }
  end
end

# Configuração do Sentry para monitoramento de erros
if Rails.env.production?
  Sentry.init do |config|
    config.dsn = ENV['SENTRY_DSN']
    config.breadcrumbs_logger = [:active_support_logger, :http_logger]
    config.traces_sample_rate = 0.5
    config.send_default_pii = true
    
    config.before_send = lambda do |event, hint|
      # Adiciona informações do tenant
      if Current.tenant
        event.extra[:tenant_id] = Current.tenant.id
        event.extra[:tenant_name] = Current.tenant.name
      end
      event
    end
  end
end

# Configuração do Health Check
HealthCheck.setup do |config|
  config.uri = 'health_check'
  config.success = 'success'
  config.http_status_for_error_text = 500
  config.http_status_for_error_object = 500
  
  config.add_custom_check do
    begin
      ActiveRecord::Base.connection.execute('SELECT 1')
      CustomHealthCheck.new(true)
    rescue => e
      CustomHealthCheck.new(false, e.message)
    end
  end
end

# Configuração do Prometheus
if defined?(PrometheusExporter::Middleware)
  require 'prometheus_exporter/middleware'
  require 'prometheus_exporter/instrumentation'
  
  Rails.application.middleware.use(PrometheusExporter::Middleware)
  PrometheusExporter::Instrumentation::Process.start(type: 'master')
  
  # Métricas customizadas
  TENANT_REQUESTS = PrometheusExporter::Metric::Counter.new(
    'tenant_requests_total', 'número total de requisições por tenant'
  )
  
  RESPONSE_TIME = PrometheusExporter::Metric::Histogram.new(
    'response_time_seconds', 'tempo de resposta em segundos',
    buckets: [0.1, 0.25, 0.5, 1, 2.5, 5, 10]
  )
end

# Classe auxiliar para health check customizado
class CustomHealthCheck
  def initialize(success, message = '')
    @success = success
    @message = message
  end

  def check
    @success ? '' : @message
  end
end 