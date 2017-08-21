$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'faraday'
require 'pry'
require 'faraday_resilient'

def app
  Faraday.new do |builder|
    builder.use FaradayResilient::Middleware
    builder.adapter :test do |stub|
      stub.get('/ok') { |env| [ 200, {}, 'OK' ] }
    end
  end
end
