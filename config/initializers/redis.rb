# Be sure to restart your server when you modify this file.

# Não conectar ao Redis em ambiente de teste
return if Rails.env.test?

# Configure Redis connection
$redis = Redis.new(url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0')) unless Rails.env.test?

# Configure Redis
REDIS_CONFIG = {
  url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0')
}.freeze

# Configure Sidekiq
Sidekiq.configure_server do |config|
  config.redis = REDIS_CONFIG
  
  # Configuração do Scheduler
  config.on(:startup) do
    unless Rails.env.test?
      Sidekiq.schedule = {
        'cleanup_pdf' => {
          'cron' => '0 0 * * *', # Executar diariamente à meia-noite
          'class' => 'CleanupPdfJob'
        }
      }
      SidekiqScheduler::Scheduler.instance.reload_schedule!
    end
  end
end

Sidekiq.configure_client do |config|
  config.redis = REDIS_CONFIG
end

# Middleware para garantir o tenant correto nos jobs
class TenantMiddleware
  def call(worker, job, queue)
    tenant_id = job['tenant_id']
    if tenant_id
      tenant = Tenant.find(tenant_id)
      Current.set(tenant: tenant, user: nil)
      yield
    else
      yield
    end
  ensure
    Current.reset
  end
end

# Adiciona o middleware ao Sidekiq
Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add TenantMiddleware
  end
end

# Configurações específicas para ambiente de teste
if Rails.env.test?
  REDIS_CONFIG = {
    url: 'redis://localhost:6379/0'
  }
end 