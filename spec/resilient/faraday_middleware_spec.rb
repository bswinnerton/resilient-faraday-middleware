require 'spec_helper'

describe Resilient::FaradayMiddleware do
  it 'has a version number' do
    expect(Resilient::FaradayMiddleware::VERSION).not_to be nil
  end
end
