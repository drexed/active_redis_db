# frozen_string_literal: true

require 'spec_helper'

describe ActiveOrm::Redis::Connection do

  before(:each) do
    ActiveOrm::Redis::Connection.flush_all
  end

  describe '.authenticate' do
    it 'to be "OK"' do
      expect(ActiveOrm::Redis::Connection.authenticate('pass')).to eq('OK')
    end
  end

  describe '.connected?' do
    it 'to be true' do
      expect(ActiveOrm::Redis::Connection.connected?).to eq(true)
    end
  end

  describe '.database' do
    it 'to be 2' do
      ActiveOrm::Redis::Connection.database(2)

      expect(ActiveOrm::Redis::Connection.database_id).to eq(2)
    end
  end

  describe '.database_id' do
    it 'to be 0' do
      ActiveOrm::Redis::Connection.database(0)

      expect(ActiveOrm::Redis::Connection.database_id).to eq(0)
    end
  end

  describe '.database_size' do
    it 'to be 0' do
      expect(ActiveOrm::Redis::Connection.database_size).to eq(0)
    end

    it 'to be 2' do
      ActiveOrm::Redis::String.create(:example1, 'one')
      ActiveOrm::Redis::String.create(:example2, 'two')

      expect(ActiveOrm::Redis::Connection.database_size).to eq(2)
    end
  end

  describe '.debug' do
    # TODO
  end

  describe '.disconnect' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::Connection.disconnect).to eq(nil)
    end
  end

  describe '.echo' do
    it 'to be "Redis"' do
      expect(ActiveOrm::Redis::Connection.echo('Redis')).to eq('Redis')
    end
  end

  describe '.flush' do
    it 'to be 0' do
      ActiveOrm::Redis::String.create(:example1, 'one')
      ActiveOrm::Redis::String.create(:example2, 'two')
      ActiveOrm::Redis::Connection.flush

      expect(ActiveOrm::Redis::Connection.database_size).to eq(0)
    end
  end

  describe '.flush' do
    it 'to be 0' do
      ActiveOrm::Redis::String.create(:example1, 'one')
      ActiveOrm::Redis::String.create(:example2, 'two')
      ActiveOrm::Redis::Connection.flush_all

      expect(ActiveOrm::Redis::Connection.database_size).to eq(0)
    end
  end

  describe '.info' do
    info_hash = {
      'redis_version'              => '2.6.16',
      'connected_clients'          => '1',
      'connected_slaves'           => '0',
      'used_memory'                => '3187',
      'changes_since_last_save'    => '0',
      'last_save_time'             => '1237655729',
      'total_connections_received' => '1',
      'total_commands_processed'   => '1',
      'uptime_in_seconds'          => '36000',
      'uptime_in_days'             => 0
    }

    it 'to be #{info_hash}' do
      expect(ActiveOrm::Redis::Connection.info).to eq(info_hash)
    end

    it 'to raise error' do
      expect { ActiveOrm::Redis::Connection.client('Redis').info }.to raise_error(NoMethodError)
    end
  end

  describe '.ping' do
    it 'to be "PONG"' do
      expect(ActiveOrm::Redis::Connection.ping).to eq('PONG')
    end
  end

  describe '.quit' do
    it 'to not raise error' do
      expect { ActiveOrm::Redis::Connection.quit }.not_to raise_error
    end
  end

  describe '.reconnect' do
    # TODO
  end

  describe '.rewrite_aof' do
    # TODO
  end

  describe '.save' do
    # TODO
  end

  describe '.saved_at' do
    it "to be #{Time.now.to_i}" do
      expect(ActiveOrm::Redis::Connection.saved_at).to eq(Time.now.to_i)
    end
  end

  describe '.shutdown' do
    it 'to not raise error' do
      expect { ActiveOrm::Redis::Connection.shutdown }.not_to raise_error
    end
  end

  describe '.slave_of' do
    # TODO
  end

  describe '.slowlog' do
    # TODO
  end

  describe '.syncronize' do
    # TODO
  end

  describe '.time' do
    it 'to not raise error' do
      expect { ActiveOrm::Redis::Connection.time }.not_to raise_error
    end
  end

  describe '.with_reconnect' do
    # TODO
  end

  describe '.without_reconnect' do
    # TODO
  end

end
