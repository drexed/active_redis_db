# frozen_string_literal: true

require 'spec_helper'

describe ActiveOrm::Redis::Transaction do

  before(:each) do
    ActiveOrm::Redis::Connection.flush_all
  end

  after(:each) do
    ActiveOrm::Redis::Transaction.discard rescue nil
  end

  describe '.multi' do
    it 'to be "OK"' do
      expect(ActiveOrm::Redis::Transaction.multi).to eq('OK')
    end

    response = ['OK', 'OK', true, ['1', '2']]

    it 'to be #{response}' do
      transaction = ActiveOrm::Redis::Transaction.multi do |multi|
        multi.set('key1', '1')
        multi.set('key2', '2')
        multi.expire('key1', 123)
        multi.mget('key1', 'key2')
      end

      expect(transaction).to eq(response)
    end
  end

  describe '.discard' do
    it 'to raise error' do
      expect { ActiveOrm::Redis::Transaction.discard }.to raise_error(Redis::CommandError)
    end

    it 'to be "OK"' do
      ActiveOrm::Redis::Transaction.multi

      expect(ActiveOrm::Redis::Transaction.discard).to eq('OK')
    end
  end

  describe '.watch' do
    # TODO
  end

  describe '.unwatch' do
    # TODO
  end

end
