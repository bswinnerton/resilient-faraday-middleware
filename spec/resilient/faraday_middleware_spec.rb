require 'spec_helper'

describe Resilient::FaradayMiddleware do
  it 'has a version number' do
    expect(Resilient::FaradayMiddleware::VERSION).not_to be nil
  end

  it 'allows requests for a healthy host which returns a 200' do
    response = app.get('http://webhook-recipient.com/200')
    expect(response.status).to eq 200
  end

  it 'allows request for an unhealthy host which returns a 500' do
    response = app.get('http://webhook-recipient.com/500')
    expect(response.status).to eq 500
  end

  it 'continues to return TimeoutError when a request times out' do
    request = -> { app.get('http://webhook-recipient.com/timeout') }
    expect(request).to raise_error Faraday::TimeoutError
  end

  it 'raises a FaradayResilient::OpenCircuitError when a circuit is open' do
    url = 'http://webhook-recipient.com/timeout'
    open_circuit = Resilient::CircuitBreaker.get(url, force_open: true)

    expect(Resilient::CircuitBreaker).to receive(:get).and_return open_circuit

    request = -> { app.get('http://webhook-recipient.com/timeout') }
    expect(request).to raise_error NotImplementedError
  end
end
