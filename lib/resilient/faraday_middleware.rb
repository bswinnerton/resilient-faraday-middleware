require 'faraday'
require 'resilient/circuit_breaker'

module Resilient
  class FaradayMiddleware < Faraday::Middleware
    VERSION = "0.1.0"

    def call(request_env)
      request_host    = request_env.url.host
      circuit_breaker = Resilient::CircuitBreaker.get(request_host)

      raise NotImplementedError unless circuit_breaker.allow_request?

      @app.call(request_env).on_complete do |response_env|
        circuit_breaker.success
      end
    rescue Faraday::TimeoutError => exception
      circuit_breaker.failure
      raise exception
    end
  end
end
