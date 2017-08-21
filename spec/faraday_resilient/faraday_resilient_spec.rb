require 'spec_helper'

describe FaradayResilient do
  it 'has a version number' do
    expect(FaradayResilient::VERSION).not_to be nil
  end
end

describe FaradayResilient::Middleware do
  it 'allows requests for a healthy host' do
    response = app.get('https://ok.com/')
    expect(response.status).to eq 200
  end
end
