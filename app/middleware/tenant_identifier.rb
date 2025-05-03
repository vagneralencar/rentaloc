module Gestaoloc
  module Middleware
    class TenantIdentifier
      def initialize(app)
        @app = app
      end

      def call(env)
        request = Rack::Request.new(env)
        
        # Identifica o tenant pelo subdomínio
        if request.subdomain.present? && request.subdomain != 'www'
          tenant = Tenant.find_by(subdomain: request.subdomain)
          Current.tenant = tenant if tenant
        end
        
        @app.call(env)
      ensure
        # Limpa o tenant após a requisição
        Current.tenant = nil
      end
    end
  end
end 