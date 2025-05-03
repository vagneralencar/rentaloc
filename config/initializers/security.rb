# Configurações de Segurança

# Proteção contra XSS
Rails.application.config.action_view.sanitized_allowed_tags = %w(
  strong em b i p code pre tt samp kbd var sub sup dfn cite big small address
  hr br div span h1 h2 h3 h4 h5 h6 ul ol li dl dt dd abbr acronym a img blockquote del ins
)

# Headers de Segurança
Rails.application.config.action_dispatch.default_headers = {
  'X-Frame-Options' => 'SAMEORIGIN',
  'X-XSS-Protection' => '1; mode=block',
  'X-Content-Type-Options' => 'nosniff',
  'X-Download-Options' => 'noopen',
  'X-Permitted-Cross-Domain-Policies' => 'none',
  'Referrer-Policy' => 'strict-origin-when-cross-origin',
  'Content-Security-Policy' => "default-src 'self' https: 'unsafe-inline' 'unsafe-eval'"
}

# Configuração de Cookies Seguros
Rails.application.config.session_store :cookie_store, 
  key: '_gestaoloc_session',
  secure: Rails.env.production?,
  httponly: true,
  same_site: :strict

# Rate Limiting
Rails.application.config.middleware.use Rack::Attack
Rack::Attack.cache.store = ActiveSupport::Cache::RedisCacheStore.new(url: ENV['REDIS_URL'])

# Configuração do Rack::Attack
Rack::Attack.throttle('req/ip', limit: 300, period: 5.minutes) do |req|
  req.ip
end

# Limitar tentativas de login
Rack::Attack.throttle('logins/ip', limit: 5, period: 20.seconds) do |req|
  if req.path == '/users/sign_in' && req.post?
    req.ip
  end
end

# Bloquear IPs suspeitos
Rack::Attack.blocklist('block suspicious IPs') do |req|
  Rack::Attack::Allow2Ban.filter(req.ip, maxretry: 10, findtime: 1.minutes, bantime: 1.hour) do
    req.path =~ /\A\/users/ && req.post?
  end
end 