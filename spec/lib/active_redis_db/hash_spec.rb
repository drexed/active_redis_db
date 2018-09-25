# frozen_string_literal: true

require 'spec_helper'

describe ActiveRedisDB::Hash do

  before(:each) do
    ActiveRedisDB::Connection.flush_all
  end

  describe '.find' do
    it 'to be nil' do
      expect(ActiveRedisDB::Hash.find(:example, :name)).to eq(nil)
      expect(ActiveRedisDB::Hash.evaluate.find(:example, :name)).to eq(nil)
      expect(ActiveRedisDB::Hash.evaluate(true).find(:example, :name)).to eq(nil)
      expect(ActiveRedisDB::Hash.evaluate(false).find(:example, :name)).to eq(nil)
    end

    it 'to be "redis"' do
      ActiveRedisDB::Hash.create(:example, :name, 'redis')

      expect(ActiveRedisDB::Hash.find(:example, :name)).to eq('redis')
      expect(ActiveRedisDB::Hash.evaluate.find(:example, :name)).to eq('redis')
      expect(ActiveRedisDB::Hash.evaluate(true).find(:example, :name)).to eq('redis')
      expect(ActiveRedisDB::Hash.evaluate(false).find(:example, :name)).to eq('redis')
    end

    it 'to be "1"' do
      ActiveRedisDB::Hash.create(:example, :name, 1)

      expect(ActiveRedisDB::Hash.find(:example, :name)).to eq('1')
      expect(ActiveRedisDB::Hash.evaluate(false).find(:example, :name)).to eq('1')
    end

    it 'to be 1' do
      ActiveRedisDB::Hash.create(:example, :name, 1)

      expect(ActiveRedisDB::Hash.evaluate.find(:example, :name)).to eq(1)
      expect(ActiveRedisDB::Hash.evaluate(true).find(:example, :name)).to eq(1)
    end
  end

  describe '.find_each' do
    it 'to be ["hello", "world"]' do
      ActiveRedisDB::Hash.create(:example, :name, 'hello')
      ActiveRedisDB::Hash.create(:example, :bday, 'world')

      expect(ActiveRedisDB::Hash.find_each(:example, :name, :bday)).to eq(['hello', 'world'])
    end

    it 'to be ["1", "2"]' do
      ActiveRedisDB::Hash.create(:example, :name, 1)
      ActiveRedisDB::Hash.create(:example, :bday, 2)

      expect(ActiveRedisDB::Hash.find_each(:example, :name, :bday)).to eq(['1', '2'])
      expect(ActiveRedisDB::Hash.evaluate(false).find_each(:example, :name, :bday)).to eq(['1', '2'])
    end

    it 'to be [1, 2]' do
      ActiveRedisDB::Hash.create(:example, :name, 1)
      ActiveRedisDB::Hash.create(:example, :bday, 2)

      expect(ActiveRedisDB::Hash.evaluate.find_each(:example, :name, :bday)).to eq([1, 2])
      expect(ActiveRedisDB::Hash.evaluate(true).find_each(:example, :name, :bday)).to eq([1, 2])
    end
  end

  describe '.all' do
    it 'to be { "name" => "hello", "bday" => "world" }' do
      ActiveRedisDB::Hash.create(:example, :name, 'hello')
      ActiveRedisDB::Hash.create(:example, :bday, 'world')

      expect(ActiveRedisDB::Hash.all(:example)).to eq({ 'name' => 'hello', 'bday' => 'world' })
    end

    it 'to be { "name" => "1", "bday" => "2" }' do
      ActiveRedisDB::Hash.create(:example, :name, 1)
      ActiveRedisDB::Hash.create(:example, :bday, 2)

      expect(ActiveRedisDB::Hash.all(:example)).to eq({ 'name' => '1', 'bday' => '2' })
      expect(ActiveRedisDB::Hash.evaluate(false).all(:example)).to eq({ 'name' => '1', 'bday' => '2' })
    end

    it 'to be { "name" => 1, "bday" => 2 }' do
      ActiveRedisDB::Hash.create(:example, :name, 1)
      ActiveRedisDB::Hash.create(:example, :bday, 2)

      expect(ActiveRedisDB::Hash.evaluate.all(:example)).to eq({ 'name' => 1, 'bday' => 2 })
      expect(ActiveRedisDB::Hash.evaluate(true).all(:example)).to eq({ 'name' => 1, 'bday' => 2 })
    end
  end

  describe '.keys' do
    it 'to be ["name", "bday"]' do
      ActiveRedisDB::Hash.create(:example, :name, 'hello')
      ActiveRedisDB::Hash.create(:example, :bday, 'world')

      expect(ActiveRedisDB::Hash.keys(:example)).to eq(['name', 'bday'])
    end

    it 'to be ["1", "2"]' do
      ActiveRedisDB::Hash.create(:example, 1, 'hello')
      ActiveRedisDB::Hash.create(:example, 2, 'world')

      expect(ActiveRedisDB::Hash.keys(:example)).to eq(['1', '2'])
      expect(ActiveRedisDB::Hash.evaluate(false).keys(:example)).to eq(['1', '2'])
    end

    it 'to be [1, 2]' do
      ActiveRedisDB::Hash.create(:example, 1, 'hello')
      ActiveRedisDB::Hash.create(:example, 2, 'world')

      expect(ActiveRedisDB::Hash.evaluate.keys(:example)).to eq([1, 2])
      expect(ActiveRedisDB::Hash.evaluate(true).keys(:example)).to eq([1, 2])
    end
  end

  describe '.values' do
    it 'to be ["hello", "world"]' do
      ActiveRedisDB::Hash.create(:example, :name, 'hello')
      ActiveRedisDB::Hash.create(:example, :bday, 'world')

      expect(ActiveRedisDB::Hash.values(:example)).to eq(['hello', 'world'])
    end

    it 'to be ["1", "2"]' do
      ActiveRedisDB::Hash.create(:example, :name, 1)
      ActiveRedisDB::Hash.create(:example, :bday, 2)

      expect(ActiveRedisDB::Hash.values(:example)).to eq(['1', '2'])
      expect(ActiveRedisDB::Hash.evaluate(false).values(:example)).to eq(['1', '2'])
    end

    it 'to be [1, 2]' do
      ActiveRedisDB::Hash.create(:example, :name, 1)
      ActiveRedisDB::Hash.create(:example, :bday, 2)

      expect(ActiveRedisDB::Hash.evaluate.values(:example)).to eq([1, 2])
      expect(ActiveRedisDB::Hash.evaluate(true).values(:example)).to eq([1, 2])
    end
  end

  describe '.value_length' do
    # TODO
  end

  describe '.count' do
    it 'to be 2' do
      ActiveRedisDB::Hash.create(:example, :name, 'hello')
      ActiveRedisDB::Hash.create(:example, :bday, 'world')

      expect(ActiveRedisDB::Hash.count(:example)).to eq(2)
    end
  end

  describe '.exists?' do
    it 'to be false' do
      ActiveRedisDB::Hash.create(:example, :name, 'redis')

      expect(ActiveRedisDB::Hash.exists?(:example, :bday)).to eq(false)
    end

    it 'to be false' do
      ActiveRedisDB::Hash.create(:example, :name, 'redis')

      expect(ActiveRedisDB::Hash.exists?(:example2, :bday)).to eq(false)
    end
  end

  describe '.create' do
    it 'to be "hello"' do
      ActiveRedisDB::Hash.create(:example, :name, 'hello')

      expect(ActiveRedisDB::Hash.find(:example, :name)).to eq('hello')
    end
  end

  describe '.create!' do
    it 'to be "hello"' do
      ActiveRedisDB::Hash.create!(:example, :name, 'hello')

      expect(ActiveRedisDB::Hash.find(:example, :name)).to eq('hello')
    end

    it 'to be "hello"' do
      ActiveRedisDB::Hash.create!(:example, :name, 'hello')
      ActiveRedisDB::Hash.create!(:example, :name, 'world')

      expect(ActiveRedisDB::Hash.find(:example, :name)).to eq('hello')
    end
  end

  describe '.create_each' do
    it 'to be "world"' do
      ActiveRedisDB::Hash.create_each(:example, :name, 'hello', :bday, 'world')

      expect(ActiveRedisDB::Hash.find(:example, :bday)).to eq('world')
    end
  end

  describe '.increment' do
    it 'to be "21"' do
      ActiveRedisDB::Hash.create(:example, :age, 19)
      ActiveRedisDB::Hash.increment(:example, :age, 2)

      expect(ActiveRedisDB::Hash.find(:example, :age)).to eq('21')
    end
  end

  describe '.destroy' do
    it 'to be nil' do
      ActiveRedisDB::Hash.create(:example, :name, 'hello')
      ActiveRedisDB::Hash.destroy(:example, :name)

      expect(ActiveRedisDB::Hash.find(:example, :name)).to eq(nil)
    end
  end

  describe '.scan' do
    # TODO
  end

end
