$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require 'faraday'
require 'resilient'
require 'resilient/faraday_middleware'
require 'pry'

def app
  Faraday.new do |builder|
    builder.use Resilient::FaradayMiddleware
    builder.adapter :test do |stub|
      stub.get('/ok') { |env| [ 200, {}, 'OK' ] }
    end
  end
end
