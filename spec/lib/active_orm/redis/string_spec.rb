# frozen_string_literal: false

require 'spec_helper'

describe ActiveOrm::Redis::String do

  before(:each) do
    ActiveOrm::Redis::Connection.flush_all
  end

  describe '.find' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::String.find(:example)).to eq(nil)
      expect(ActiveOrm::Redis::String.evaluate.find(:example)).to eq(nil)
      expect(ActiveOrm::Redis::String.evaluate(true).find(:example)).to eq(nil)
      expect(ActiveOrm::Redis::String.evaluate(false).find(:example)).to eq(nil)
    end

    it 'to be "123"' do
      ActiveOrm::Redis::String.create(:example1, '123')
      ActiveOrm::Redis::String.create(:example2, 123)

      expect(ActiveOrm::Redis::String.find(:example1)).to eq('123')
      expect(ActiveOrm::Redis::String.find(:example2)).to eq('123')
      expect(ActiveOrm::Redis::String.evaluate(false).find(:example1)).to eq('123')
      expect(ActiveOrm::Redis::String.evaluate(false).find(:example2)).to eq('123')
    end

    it 'to be 123' do
      ActiveOrm::Redis::String.create(:example1, '123')
      ActiveOrm::Redis::String.create(:example2, 123)

      expect(ActiveOrm::Redis::String.evaluate.find(:example1)).to eq(123)
      expect(ActiveOrm::Redis::String.evaluate.find(:example2)).to eq(123)
      expect(ActiveOrm::Redis::String.evaluate(true).find(:example1)).to eq(123)
      expect(ActiveOrm::Redis::String.evaluate(true).find(:example2)).to eq(123)
    end
  end

  describe '.find_each' do
    it 'to be [nil, nil]' do
      expect(ActiveOrm::Redis::String.find_each(:example, :example2)).to eq([nil, nil])
      expect(ActiveOrm::Redis::String.evaluate.find_each(:example, :example2)).to eq([nil, nil])
      expect(ActiveOrm::Redis::String.evaluate(true).find_each(:example, :example2)).to eq([nil, nil])
      expect(ActiveOrm::Redis::String.evaluate(false).find_each(:example, :example2)).to eq([nil, nil])
    end

    it 'to be ["one", "two"]' do
      ActiveOrm::Redis::String.create('example', 'one')
      ActiveOrm::Redis::String.create('example2', 'two')

      expect(ActiveOrm::Redis::String.find_each('example', 'example2')).to eq(['one', 'two'])
      expect(ActiveOrm::Redis::String.evaluate.find_each('example', 'example2')).to eq(['one', 'two'])
      expect(ActiveOrm::Redis::String.evaluate(true).find_each('example', 'example2')).to eq(['one', 'two'])
      expect(ActiveOrm::Redis::String.evaluate(false).find_each('example', 'example2')).to eq(['one', 'two'])
    end

    it 'to be ["1", "2"]' do
      ActiveOrm::Redis::String.create('example', '1')
      ActiveOrm::Redis::String.create('example2', 2)

      expect(ActiveOrm::Redis::String.find_each('example', 'example2')).to eq(['1', '2'])
      expect(ActiveOrm::Redis::String.evaluate(false).find_each('example', 'example2')).to eq(['1', '2'])
    end

    it 'to be [1, 2]' do
      ActiveOrm::Redis::String.create('example', '1')
      ActiveOrm::Redis::String.create('example2', 2)

      expect(ActiveOrm::Redis::String.evaluate.find_each('example', 'example2')).to eq([1, 2])
      expect(ActiveOrm::Redis::String.evaluate(true).find_each('example', 'example2')).to eq([1, 2])
    end
  end

  describe '.length' do
    it 'to be 11' do
      ActiveOrm::Redis::String.create(:example, 'hello world')

      expect(ActiveOrm::Redis::String.length(:example)).to eq(11)
    end
  end

  describe '.split' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::String.split(:example, 0, 3)).to eq(nil)
    end

    it 'to be "hel"' do
      ActiveOrm::Redis::String.create(:example, 'hello world')

      expect(ActiveOrm::Redis::String.split(:example, 0, 2)).to eq('hel')
    end
  end

  describe '.create' do
    it 'to be "1"' do
      ActiveOrm::Redis::String.create(:example, '1')

      expect(ActiveOrm::Redis::String.find(:example)).to eq('1')
    end

    it 'to be "2"' do
      ActiveOrm::Redis::String.create(:example, '1')
      ActiveOrm::Redis::String.create(:example, '2')

      expect(ActiveOrm::Redis::String.find(:example)).to eq('2')
    end

    it 'to be "1"' do
      ActiveOrm::Redis::String.create(:example, '1')
      ActiveOrm::Redis::String.create(:example, '2', nx: true)

      expect(ActiveOrm::Redis::String.find(:example)).to eq('1')
    end

    it 'to be nil' do
      ActiveOrm::Redis::String.create(:example, '1', xx: true)

      expect(ActiveOrm::Redis::String.find(:example)).to eq(nil)
    end

    it 'to be "1"' do
      ActiveOrm::Redis::String.create(:example, '1', ex: 1)

      expect(ActiveOrm::Redis::String.find(:example)).to eq('1')
    end
  end

  describe '.create!' do
    it 'to be "1"' do
      ActiveOrm::Redis::String.create!(:example, '1')

      expect(ActiveOrm::Redis::String.find(:example)).to eq('1')
    end

    it 'to be "1"' do
      ActiveOrm::Redis::String.create(:example, '1')
      ActiveOrm::Redis::String.create!(:example, '2')

      expect(ActiveOrm::Redis::String.find(:example)).to eq('1')
    end
  end

  describe '.create_each' do
    it 'to be "world"' do
      ActiveOrm::Redis::String.create_each(:example, 'hello', :example2, 'world')

      expect(ActiveOrm::Redis::String.find(:example2)).to eq('world')
    end
  end

  describe '.create_each!' do
    it 'to be "hello"' do
      ActiveOrm::Redis::String.create_each!(:example, 'hello', :example2, 'world')

      expect(ActiveOrm::Redis::String.find(:example)).to eq('hello')
    end
  end

  describe '.create_until' do
    it 'to be nil' do
      ActiveOrm::Redis::String.create_until(:example, 'hello', 2)
      sleep(3)

      expect(ActiveOrm::Redis::String.find(:example)).to eq(nil)
    end
  end

  describe '.append' do
    it 'to be "hello"' do
      expect(ActiveOrm::Redis::String.append(:example, 'hello')).to eq('hello')
    end

    it 'to be "hello world"' do
      ActiveOrm::Redis::String.create(:example, 'hello')
      ActiveOrm::Redis::String.append(:example, ' world')

      expect(ActiveOrm::Redis::String.find(:example)).to eq('hello world')
    end
  end

  describe '.replace' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::String.replace(:example, 'hello', 6)).to eq(nil)
    end

    it 'to be "hello redis"' do
      ActiveOrm::Redis::String.create(:example, 'hello world')
      ActiveOrm::Redis::String.replace(:example, 'redis', 6)

      expect(ActiveOrm::Redis::String.find(:example)).to eq('hello redis')
    end
  end

  describe '.decrement' do
    it 'to be -1' do
      expect(ActiveOrm::Redis::String.decrement('example')).to eq(-1)
    end

    it 'to be 1' do
      ActiveOrm::Redis::String.create('example', 2)

      expect(ActiveOrm::Redis::String.decrement('example')).to eq(1)
    end

    it 'to be 3' do
      ActiveOrm::Redis::String.create('example', 5)

      expect(ActiveOrm::Redis::String.decrement('example', 2)).to eq(3)
    end
  end

  describe '.increment' do
    it 'to be 1' do
      expect(ActiveOrm::Redis::String.increment('example')).to eq(1)
    end

    it 'to be 2' do
      ActiveOrm::Redis::String.create('example', 1)

      expect(ActiveOrm::Redis::String.increment('example')).to eq(2)
    end

    it 'to be 5' do
      ActiveOrm::Redis::String.create(:example, 1)

      expect(ActiveOrm::Redis::String.increment('example', 4)).to eq(5)
    end
  end

  describe '.reset' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::String.reset(:example)).to eq(nil)
    end

    it 'to be "0"' do
      ActiveOrm::Redis::String.create(:example, 2)
      ActiveOrm::Redis::String.reset(:example)

      expect(ActiveOrm::Redis::String.find(:example)).to eq('0')
    end

    it 'to be "2"' do
      ActiveOrm::Redis::String.create(:example, 4)
      ActiveOrm::Redis::String.reset(:example, 2)

      expect(ActiveOrm::Redis::String.find(:example)).to eq('2')
    end
  end

  describe '.bit_count' do
    it 'to be 0' do
      expect(ActiveOrm::Redis::String.bit_count(:example)).to eq(0)
    end

    it 'to be 26' do
      ActiveOrm::Redis::String.create(:example, 'foobar')

      expect(ActiveOrm::Redis::String.bit_count(:example)).to eq(26)
    end

    it 'to be 4' do
      ActiveOrm::Redis::String.create(:example, 'foobar')

      expect(ActiveOrm::Redis::String.bit_count(:example, 0, 0)).to eq(4)
    end

    it 'to be 6' do
      ActiveOrm::Redis::String.create(:example, 'foobar')

      expect(ActiveOrm::Redis::String.bit_count(:example, 1, 1)).to eq(6)
    end

    it 'to be 10' do
      ActiveOrm::Redis::String.create(:example, 'foobar')

      expect(ActiveOrm::Redis::String.bit_count(:example, 0, 1)).to eq(10)
    end
  end

  describe '.bit_where' do
    it 'to be ...' do
      ActiveOrm::Redis::String.create(:sample1, 'abc')
      ActiveOrm::Redis::String.create(:sample2, 123)

      ActiveOrm::Redis::String.bit_where(:and, 'sample1&2', :sample1, :sample2)
      ActiveOrm::Redis::String.bit_where(:or, 'sample1|2', :sample1, :sample2)
      ActiveOrm::Redis::String.bit_where(:xor, 'sample1^2', :sample1, :sample2)
      # ActiveOrm::Redis::String.bit_where(:not, 'sample1~2', :sample1, :sample2)

      expect(ActiveOrm::Redis::String.find('sample1&2')).to eq("!\"#")
      expect(ActiveOrm::Redis::String.find('sample1|2')).to eq('qrs')
      expect(ActiveOrm::Redis::String.find('sample1^2')).to eq('PPP')
      # expect(ActiveOrm::Redis::String.find('sample1~2')).to eq('qrs')
    end
  end

  describe '.get_bit' do
    it 'to be 0' do
      ActiveOrm::Redis::String.create(:example, 'a')

      expect(ActiveOrm::Redis::String.get_bit(:example, 3)).to eq(0)
      expect(ActiveOrm::Redis::String.get_bit(:example, 4)).to eq(0)
      expect(ActiveOrm::Redis::String.get_bit(:example, 5)).to eq(0)
      expect(ActiveOrm::Redis::String.get_bit(:example, 6)).to eq(0)
    end

    it 'to be 1' do
      ActiveOrm::Redis::String.create(:example, 'a')

      expect(ActiveOrm::Redis::String.get_bit(:example, 1)).to eq(1)
      expect(ActiveOrm::Redis::String.get_bit(:example, 2)).to eq(1)
      expect(ActiveOrm::Redis::String.get_bit(:example, 7)).to eq(1)
    end
  end

  describe '.set_bit' do
    it 'to be 0' do
      ActiveOrm::Redis::String.set_bit(:example, 10, 0)

      expect(ActiveOrm::Redis::String.set_bit(:example, 10, 0)).to eq(0)
      expect(ActiveOrm::Redis::String.set_bit(:example, 10, 1)).to eq(0)
    end

    it 'to be 1' do
      ActiveOrm::Redis::String.set_bit(:example, 10, 1)

      expect(ActiveOrm::Redis::String.get_bit(:example, 10)).to eq(1)
    end
  end

end
