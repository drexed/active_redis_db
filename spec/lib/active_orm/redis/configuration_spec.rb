# frozen_string_literal: true

require 'spec_helper'

describe ActiveOrm::Redis::Configuration do
  after(:all) do
    ActiveOrm::Redis.configure do |config|
      config.client = Redis.new
    end
  end

  describe '.configure' do
    it 'to raise error' do
      ActiveOrm::Redis.configure do |config|
        config.client = Redis.new
      end

      expect(ActiveOrm::Redis::Connection.info).not_to eq(nil)
    end

    it 'to raise error' do
      ActiveOrm::Redis.configure do |config|
        config.client = 'Redis'
      end

      expect { ActiveOrm::Redis::Connection.connected? }.to raise_error(NoMethodError)
    end
  end

end
