$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require 'faraday'
require 'resilient'
require 'faraday_resilient'
require 'pry'

def app
  Faraday.new do |builder|
    builder.use FaradayResilient::Middleware
    builder.adapter :test do |stub|
      stub.get('http://webhook-recipient.com/200') do |env|
        [ 200, {}, 'OK' ]
      end

      stub.get('http://webhook-recipient.com/500') do |env|
        [ 500, {}, 'Internal Server Error' ]
      end

      stub.get('http://webhook-recipient.com/timeout') do |env|
        raise Faraday::TimeoutError
      end
    end
  end
end

RSpec.configure do |config|
  config.before(:each) do
    Resilient::CircuitBreaker::Registry.reset
  end
end
