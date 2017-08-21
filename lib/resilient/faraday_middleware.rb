require 'faraday'
require 'resilient/circuit_breaker'

module Resilient
  class FaradayMiddleware < Faraday::Middleware
    def call(request_env)
      # do something with the request
      # request_env[:request_headers].merge!(...)

      @app.call(request_env).on_complete do |response_env|
        # do something with the response
        # response_env[:response_headers].merge!(...)
      end
    end
  end
end
