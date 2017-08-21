$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require 'faraday'
require 'resilient'
require 'faraday_resilient'
require 'pry'

def app
  Faraday.new do |builder|
    builder.use FaradayResilient::Middleware
    builder.adapter :test do |stub|
      stub.get('https://ok.com/') { |env| [ 200, {}, 'OK' ] }
    end
  end
end

RSpec.configure do |config|
  config.before(:each) do
    Resilient::CircuitBreaker::Registry.reset
  end
end
