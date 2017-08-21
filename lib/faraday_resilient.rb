require "faraday_resilient/version"
require "resilient/circuit_breaker"

module FaradayResilient
  class Middleware < Faraday::Middleware
    def call(request_env)
      request_host    = request_env.url.host
      circuit_breaker = Resilient::CircuitBreaker.get(request_host)

      if !circuit_breaker.allow_request?
        return NotImplementedError
      end

      @app.call(request_env).on_complete do |response_env|
        circuit_breaker.success
      end
    end
  end
end
