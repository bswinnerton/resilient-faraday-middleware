require "faraday_resilient/version"
require "resilient/circuit_breaker"

module FaradayResilient
  class OpenCircuitError < StandardError; end

  class Middleware < Faraday::Middleware
    def call(request_env)
      request_host    = request_env.url.host
      circuit_breaker = Resilient::CircuitBreaker.get(request_host)

      if !circuit_breaker.allow_request?
        raise OpenCircuitError
      end

      @app.call(request_env).on_complete do |response_env|
        circuit_breaker.success
      end
    rescue Faraday::TimeoutError => exception
      circuit_breaker.failure
      raise exception
    end
  end
end
