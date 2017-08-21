require "spec_helper"

describe FaradayResilient do
  it 'has a version number' do
    expect(FaradayResilient::VERSION).not_to be nil
  end
end

describe FaradayResilient::Middleware do
  let(:app) do
    Faraday.new do |builder|
      builder.use FaradayResilient::Middleware
      builder.adapter :test do |stub|
        stub.get('/ok') { |env| [ 200, {}, 'OK' ] }
      end
    end
  end

  it 'does the thing' do
    app.get('/ok')
  end
end
