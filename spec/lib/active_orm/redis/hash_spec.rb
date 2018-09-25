# frozen_string_literal: true

require 'spec_helper'

describe ActiveOrm::Redis::Hash do

  before(:each) do
    ActiveOrm::Redis::Connection.flush_all
  end

  describe '.find' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::Hash.find(:example, :name)).to eq(nil)
      expect(ActiveOrm::Redis::Hash.evaluate.find(:example, :name)).to eq(nil)
      expect(ActiveOrm::Redis::Hash.evaluate(true).find(:example, :name)).to eq(nil)
      expect(ActiveOrm::Redis::Hash.evaluate(false).find(:example, :name)).to eq(nil)
    end

    it 'to be "redis"' do
      ActiveOrm::Redis::Hash.create(:example, :name, 'redis')

      expect(ActiveOrm::Redis::Hash.find(:example, :name)).to eq('redis')
      expect(ActiveOrm::Redis::Hash.evaluate.find(:example, :name)).to eq('redis')
      expect(ActiveOrm::Redis::Hash.evaluate(true).find(:example, :name)).to eq('redis')
      expect(ActiveOrm::Redis::Hash.evaluate(false).find(:example, :name)).to eq('redis')
    end

    it 'to be "1"' do
      ActiveOrm::Redis::Hash.create(:example, :name, 1)

      expect(ActiveOrm::Redis::Hash.find(:example, :name)).to eq('1')
      expect(ActiveOrm::Redis::Hash.evaluate(false).find(:example, :name)).to eq('1')
    end

    it 'to be 1' do
      ActiveOrm::Redis::Hash.create(:example, :name, 1)

      expect(ActiveOrm::Redis::Hash.evaluate.find(:example, :name)).to eq(1)
      expect(ActiveOrm::Redis::Hash.evaluate(true).find(:example, :name)).to eq(1)
    end
  end

  describe '.find_each' do
    it 'to be ["hello", "world"]' do
      ActiveOrm::Redis::Hash.create(:example, :name, 'hello')
      ActiveOrm::Redis::Hash.create(:example, :bday, 'world')

      expect(ActiveOrm::Redis::Hash.find_each(:example, :name, :bday)).to eq(['hello', 'world'])
    end

    it 'to be ["1", "2"]' do
      ActiveOrm::Redis::Hash.create(:example, :name, 1)
      ActiveOrm::Redis::Hash.create(:example, :bday, 2)

      expect(ActiveOrm::Redis::Hash.find_each(:example, :name, :bday)).to eq(['1', '2'])
      expect(ActiveOrm::Redis::Hash.evaluate(false).find_each(:example, :name, :bday)).to eq(['1', '2'])
    end

    it 'to be [1, 2]' do
      ActiveOrm::Redis::Hash.create(:example, :name, 1)
      ActiveOrm::Redis::Hash.create(:example, :bday, 2)

      expect(ActiveOrm::Redis::Hash.evaluate.find_each(:example, :name, :bday)).to eq([1, 2])
      expect(ActiveOrm::Redis::Hash.evaluate(true).find_each(:example, :name, :bday)).to eq([1, 2])
    end
  end

  describe '.all' do
    it 'to be { "name" => "hello", "bday" => "world" }' do
      ActiveOrm::Redis::Hash.create(:example, :name, 'hello')
      ActiveOrm::Redis::Hash.create(:example, :bday, 'world')

      expect(ActiveOrm::Redis::Hash.all(:example)).to eq({ 'name' => 'hello', 'bday' => 'world' })
    end

    it 'to be { "name" => "1", "bday" => "2" }' do
      ActiveOrm::Redis::Hash.create(:example, :name, 1)
      ActiveOrm::Redis::Hash.create(:example, :bday, 2)

      expect(ActiveOrm::Redis::Hash.all(:example)).to eq({ 'name' => '1', 'bday' => '2' })
      expect(ActiveOrm::Redis::Hash.evaluate(false).all(:example)).to eq({ 'name' => '1', 'bday' => '2' })
    end

    it 'to be { "name" => 1, "bday" => 2 }' do
      ActiveOrm::Redis::Hash.create(:example, :name, 1)
      ActiveOrm::Redis::Hash.create(:example, :bday, 2)

      expect(ActiveOrm::Redis::Hash.evaluate.all(:example)).to eq({ 'name' => 1, 'bday' => 2 })
      expect(ActiveOrm::Redis::Hash.evaluate(true).all(:example)).to eq({ 'name' => 1, 'bday' => 2 })
    end
  end

  describe '.keys' do
    it 'to be ["name", "bday"]' do
      ActiveOrm::Redis::Hash.create(:example, :name, 'hello')
      ActiveOrm::Redis::Hash.create(:example, :bday, 'world')

      expect(ActiveOrm::Redis::Hash.keys(:example)).to eq(['name', 'bday'])
    end

    it 'to be ["1", "2"]' do
      ActiveOrm::Redis::Hash.create(:example, 1, 'hello')
      ActiveOrm::Redis::Hash.create(:example, 2, 'world')

      expect(ActiveOrm::Redis::Hash.keys(:example)).to eq(['1', '2'])
      expect(ActiveOrm::Redis::Hash.evaluate(false).keys(:example)).to eq(['1', '2'])
    end

    it 'to be [1, 2]' do
      ActiveOrm::Redis::Hash.create(:example, 1, 'hello')
      ActiveOrm::Redis::Hash.create(:example, 2, 'world')

      expect(ActiveOrm::Redis::Hash.evaluate.keys(:example)).to eq([1, 2])
      expect(ActiveOrm::Redis::Hash.evaluate(true).keys(:example)).to eq([1, 2])
    end
  end

  describe '.values' do
    it 'to be ["hello", "world"]' do
      ActiveOrm::Redis::Hash.create(:example, :name, 'hello')
      ActiveOrm::Redis::Hash.create(:example, :bday, 'world')

      expect(ActiveOrm::Redis::Hash.values(:example)).to eq(['hello', 'world'])
    end

    it 'to be ["1", "2"]' do
      ActiveOrm::Redis::Hash.create(:example, :name, 1)
      ActiveOrm::Redis::Hash.create(:example, :bday, 2)

      expect(ActiveOrm::Redis::Hash.values(:example)).to eq(['1', '2'])
      expect(ActiveOrm::Redis::Hash.evaluate(false).values(:example)).to eq(['1', '2'])
    end

    it 'to be [1, 2]' do
      ActiveOrm::Redis::Hash.create(:example, :name, 1)
      ActiveOrm::Redis::Hash.create(:example, :bday, 2)

      expect(ActiveOrm::Redis::Hash.evaluate.values(:example)).to eq([1, 2])
      expect(ActiveOrm::Redis::Hash.evaluate(true).values(:example)).to eq([1, 2])
    end
  end

  describe '.value_length' do
    # TODO
  end

  describe '.count' do
    it 'to be 2' do
      ActiveOrm::Redis::Hash.create(:example, :name, 'hello')
      ActiveOrm::Redis::Hash.create(:example, :bday, 'world')

      expect(ActiveOrm::Redis::Hash.count(:example)).to eq(2)
    end
  end

  describe '.exists?' do
    it 'to be false' do
      ActiveOrm::Redis::Hash.create(:example, :name, 'redis')

      expect(ActiveOrm::Redis::Hash.exists?(:example, :bday)).to eq(false)
    end

    it 'to be false' do
      ActiveOrm::Redis::Hash.create(:example, :name, 'redis')

      expect(ActiveOrm::Redis::Hash.exists?(:example2, :bday)).to eq(false)
    end
  end

  describe '.create' do
    it 'to be "hello"' do
      ActiveOrm::Redis::Hash.create(:example, :name, 'hello')

      expect(ActiveOrm::Redis::Hash.find(:example, :name)).to eq('hello')
    end
  end

  describe '.create!' do
    it 'to be "hello"' do
      ActiveOrm::Redis::Hash.create!(:example, :name, 'hello')

      expect(ActiveOrm::Redis::Hash.find(:example, :name)).to eq('hello')
    end

    it 'to be "hello"' do
      ActiveOrm::Redis::Hash.create!(:example, :name, 'hello')
      ActiveOrm::Redis::Hash.create!(:example, :name, 'world')

      expect(ActiveOrm::Redis::Hash.find(:example, :name)).to eq('hello')
    end
  end

  describe '.create_each' do
    it 'to be "world"' do
      ActiveOrm::Redis::Hash.create_each(:example, :name, 'hello', :bday, 'world')

      expect(ActiveOrm::Redis::Hash.find(:example, :bday)).to eq('world')
    end
  end

  describe '.increment' do
    it 'to be "21"' do
      ActiveOrm::Redis::Hash.create(:example, :age, 19)
      ActiveOrm::Redis::Hash.increment(:example, :age, 2)

      expect(ActiveOrm::Redis::Hash.find(:example, :age)).to eq('21')
    end
  end

  describe '.destroy' do
    it 'to be nil' do
      ActiveOrm::Redis::Hash.create(:example, :name, 'hello')
      ActiveOrm::Redis::Hash.destroy(:example, :name)

      expect(ActiveOrm::Redis::Hash.find(:example, :name)).to eq(nil)
    end
  end

  describe '.scan' do
    # TODO
  end

end
