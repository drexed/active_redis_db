# frozen_string_literal: true

require 'spec_helper'

describe ActiveRedisDB::Configuration do
  after(:all) do
    ActiveRedisDB.configure do |config|
      config.client = Redis.new
    end
  end

  describe '.configure' do
    it 'to raise error' do
      ActiveRedisDB.configure do |config|
        config.client = Redis.new
      end

      expect(ActiveRedisDB::Connection.info).not_to eq(nil)
    end

    it 'to raise error' do
      ActiveRedisDB.configure do |config|
        config.client = 'Redis'
      end

      expect { ActiveRedisDB::Connection.connected? }.to raise_error(NoMethodError)
    end
  end

end
