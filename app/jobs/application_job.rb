class ApplicationJob < ActiveJob::Base
  include MultiTenant
  
  # Configurações padrão para todos os jobs
  queue_as :default
  
  # Retry em caso de falha
  retry_on StandardError, wait: :exponentially_longer, attempts: 3
  
  # Callback antes da execução
  before_perform do |job|
    # Garante que o tenant está definido no job
    Current.tenant = job.arguments.first[:tenant_id] if job.arguments.first&.dig(:tenant_id)
  end
  
  # Callback após a execução
  after_perform do |job|
    # Limpa o tenant após a execução
    Current.tenant = nil
  end

  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
end
