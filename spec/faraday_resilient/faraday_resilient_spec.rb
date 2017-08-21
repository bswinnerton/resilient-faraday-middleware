require 'spec_helper'

describe FaradayResilient do
  it 'has a version number' do
    expect(FaradayResilient::VERSION).not_to be nil
  end
end

describe FaradayResilient::Middleware do
  it 'allows requests for a healthy host which returns a 200' do
    response = app.get('http://webhook-recipient.com/200')
    expect(response.status).to eq 200
  end

  it 'allows request for an unhealthy host which returns a 500' do
    response = app.get('http://webhook-recipient.com/500')
    expect(response.status).to eq 500
  end
end
