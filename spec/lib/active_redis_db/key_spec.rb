# frozen_string_literal: true

require 'spec_helper'

describe ActiveRedisDB::Key do

  before(:each) do
    ActiveRedisDB::Connection.flush_all
  end

  describe '.exists?' do
    it 'to be false' do
      expect(ActiveRedisDB::Key.exists?(:example)).to eq(false)
    end

    it 'to be true' do
      ActiveRedisDB::String.create(:example, 'hello')

      expect(ActiveRedisDB::Key.exists?(:example)).to eq(true)
    end
  end

  describe '.type?' do
    it 'to be "none"' do
      expect(ActiveRedisDB::Key.type?(:example)).to eq('none')
    end

    it 'to be "string"' do
      ActiveRedisDB::String.create(:example, 'hello')

      expect(ActiveRedisDB::Key.type?(:example)).to eq('string')
    end
  end

  describe '.ttl?' do
    it 'to be 2' do
      ActiveRedisDB::String.create(:example, 'hello')
      ActiveRedisDB::Key.expire(:example, 2)

      expect(ActiveRedisDB::Key.ttl?(:example)).to eq(2)
    end
  end

  describe '.rename' do
    it 'to be nil' do
      ActiveRedisDB::String.create(:example, 'hello')
      ActiveRedisDB::Key.rename(:example, :example2)

      expect(ActiveRedisDB::String.find(:example)).to eq(nil)
    end

    it 'to be "hello"' do
      ActiveRedisDB::String.create(:example, 'hello')
      ActiveRedisDB::Key.rename(:example, :example2)

      expect(ActiveRedisDB::String.find(:example2)).to eq('hello')
    end
  end

  describe '.rename!' do
    it 'to be nil' do
      ActiveRedisDB::String.create(:example, 'hello')
      ActiveRedisDB::Key.rename!(:example, :example2)

      expect(ActiveRedisDB::String.find(:example)).to eq(nil)
    end

    it 'to be "world"' do
      ActiveRedisDB::String.create_each(:example, 'hello', :example2, 'world')
      ActiveRedisDB::Key.rename!(:example, :example2)

      expect(ActiveRedisDB::String.find(:example2)).to eq('world')
    end
  end

  describe '.destroy' do
    it 'to be nil' do
      ActiveRedisDB::String.create(:example, 'hello')
      ActiveRedisDB::Key.destroy(:example)

      expect(ActiveRedisDB::String.find(:example)).to eq(nil)
    end
  end

  describe '.persist' do
    it 'to be "hello"' do
      ActiveRedisDB::String.create(:example, 'hello')
      ActiveRedisDB::Key.expire(:example, 2)
      ActiveRedisDB::Key.persist(:example)
      sleep(3)

      expect(ActiveRedisDB::String.find(:example)).to eq('hello')
    end
  end

  describe '.expire' do
    it 'to be nil' do
      ActiveRedisDB::String.create(:example, 'hello')
      ActiveRedisDB::Key.expire(:example, 2)
      sleep(3)

      expect(ActiveRedisDB::String.find(:example)).to eq(nil)
    end
  end

  describe '.expire_in' do
    it 'to be nil' do
      ActiveRedisDB::String.create(:example, 'hello')
      ActiveRedisDB::Key.expire_in(:example, 2)
      sleep(3)

      expect(ActiveRedisDB::String.find(:example)).to eq(nil)
    end
  end

  describe '.dump' do
    # TODO
  end

  describe '.match' do
    it 'to be nil' do
      expect(ActiveRedisDB::Key.match(:example)).to eq(nil)
    end

    it 'to be ["key:a", "key:b", "key:c"]' do
      ActiveRedisDB::String.create_each('key:a', '1', 'key:b', '2', 'key:c', '3', 'akeyd', '4', 'key1', '5')

      expect(ActiveRedisDB::Key.match('key:*')).to eq(['key:a', 'key:b', 'key:c'])
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
