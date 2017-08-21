require 'spec_helper'

describe FaradayResilient do
  it 'has a version number' do
    expect(FaradayResilient::VERSION).not_to be nil
  end
end

describe FaradayResilient::Middleware do
  it 'does the thing' do
    app.get('/ok')
  end
end
