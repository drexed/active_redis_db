# frozen_string_literal: true

require 'spec_helper'

describe ActiveOrm::Redis::Key do

  before(:each) do
    ActiveOrm::Redis::Connection.flush_all
  end

  describe '.exists?' do
    it 'to be false' do
      expect(ActiveOrm::Redis::Key.exists?(:example)).to eq(false)
    end

    it 'to be true' do
      ActiveOrm::Redis::String.create(:example, 'hello')

      expect(ActiveOrm::Redis::Key.exists?(:example)).to eq(true)
    end
  end

  describe '.type?' do
    it 'to be "none"' do
      expect(ActiveOrm::Redis::Key.type?(:example)).to eq('none')
    end

    it 'to be "string"' do
      ActiveOrm::Redis::String.create(:example, 'hello')

      expect(ActiveOrm::Redis::Key.type?(:example)).to eq('string')
    end
  end

  describe '.ttl?' do
    it 'to be 2' do
      ActiveOrm::Redis::String.create(:example, 'hello')
      ActiveOrm::Redis::Key.expire(:example, 2)

      expect(ActiveOrm::Redis::Key.ttl?(:example)).to eq(2)
    end
  end

  describe '.rename' do
    it 'to be nil' do
      ActiveOrm::Redis::String.create(:example, 'hello')
      ActiveOrm::Redis::Key.rename(:example, :example2)

      expect(ActiveOrm::Redis::String.find(:example)).to eq(nil)
    end

    it 'to be "hello"' do
      ActiveOrm::Redis::String.create(:example, 'hello')
      ActiveOrm::Redis::Key.rename(:example, :example2)

      expect(ActiveOrm::Redis::String.find(:example2)).to eq('hello')
    end
  end

  describe '.rename!' do
    it 'to be nil' do
      ActiveOrm::Redis::String.create(:example, 'hello')
      ActiveOrm::Redis::Key.rename!(:example, :example2)

      expect(ActiveOrm::Redis::String.find(:example)).to eq(nil)
    end

    it 'to be "world"' do
      ActiveOrm::Redis::String.create_each(:example, 'hello', :example2, 'world')
      ActiveOrm::Redis::Key.rename!(:example, :example2)

      expect(ActiveOrm::Redis::String.find(:example2)).to eq('world')
    end
  end

  describe '.destroy' do
    it 'to be nil' do
      ActiveOrm::Redis::String.create(:example, 'hello')
      ActiveOrm::Redis::Key.destroy(:example)

      expect(ActiveOrm::Redis::String.find(:example)).to eq(nil)
    end
  end

  describe '.persist' do
    it 'to be "hello"' do
      ActiveOrm::Redis::String.create(:example, 'hello')
      ActiveOrm::Redis::Key.expire(:example, 2)
      ActiveOrm::Redis::Key.persist(:example)
      sleep(3)

      expect(ActiveOrm::Redis::String.find(:example)).to eq('hello')
    end
  end

  describe '.expire' do
    it 'to be nil' do
      ActiveOrm::Redis::String.create(:example, 'hello')
      ActiveOrm::Redis::Key.expire(:example, 2)
      sleep(3)

      expect(ActiveOrm::Redis::String.find(:example)).to eq(nil)
    end
  end

  describe '.dump' do
    # TODO
  end

  describe '.match' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::Key.match(:example)).to eq(nil)
    end

    it 'to be ["key:a", "key:b", "key:c"]' do
      ActiveOrm::Redis::String.create_each('key:a', '1', 'key:b', '2', 'key:c', '3', 'akeyd', '4', 'key1', '5')

      expect(ActiveOrm::Redis::Key.match('key:*')).to eq(['key:a', 'key:b', 'key:c'])
    end
  end

  describe '.migrate' do
    # TODO
  end

  describe '.move' do
    # TODO
  end

  describe '.object' do
    # TODO
  end

  describe '.restore' do
    # TODO
  end

  describe '.sort' do
    # TODO
  end

  describe '.scan' do
    # TODO
  end

end
