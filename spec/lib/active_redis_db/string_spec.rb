# frozen_string_literal: false

require 'spec_helper'

describe ActiveRedisDB::String do

  before(:each) do
    ActiveRedisDB::Connection.flush_all
  end

  describe '.find' do
    it 'to be nil' do
      expect(ActiveRedisDB::String.find(:example)).to eq(nil)
      expect(ActiveRedisDB::String.evaluate.find(:example)).to eq(nil)
      expect(ActiveRedisDB::String.evaluate(true).find(:example)).to eq(nil)
      expect(ActiveRedisDB::String.evaluate(false).find(:example)).to eq(nil)
    end

    it 'to be "123"' do
      ActiveRedisDB::String.create(:example1, '123')
      ActiveRedisDB::String.create(:example2, 123)

      expect(ActiveRedisDB::String.find(:example1)).to eq('123')
      expect(ActiveRedisDB::String.find(:example2)).to eq('123')
      expect(ActiveRedisDB::String.evaluate(false).find(:example1)).to eq('123')
      expect(ActiveRedisDB::String.evaluate(false).find(:example2)).to eq('123')
    end

    it 'to be 123' do
      ActiveRedisDB::String.create(:example1, '123')
      ActiveRedisDB::String.create(:example2, 123)

      expect(ActiveRedisDB::String.evaluate.find(:example1)).to eq(123)
      expect(ActiveRedisDB::String.evaluate.find(:example2)).to eq(123)
      expect(ActiveRedisDB::String.evaluate(true).find(:example1)).to eq(123)
      expect(ActiveRedisDB::String.evaluate(true).find(:example2)).to eq(123)
    end
  end

  describe '.find_each' do
    it 'to be [nil, nil]' do
      expect(ActiveRedisDB::String.find_each(:example, :example2)).to eq([nil, nil])
      expect(ActiveRedisDB::String.evaluate.find_each(:example, :example2)).to eq([nil, nil])
      expect(ActiveRedisDB::String.evaluate(true).find_each(:example, :example2)).to eq([nil, nil])
      expect(ActiveRedisDB::String.evaluate(false).find_each(:example, :example2)).to eq([nil, nil])
    end

    it 'to be ["one", "two"]' do
      ActiveRedisDB::String.create('example', 'one')
      ActiveRedisDB::String.create('example2', 'two')

      expect(ActiveRedisDB::String.find_each('example', 'example2')).to eq(['one', 'two'])
      expect(ActiveRedisDB::String.evaluate.find_each('example', 'example2')).to eq(['one', 'two'])
      expect(ActiveRedisDB::String.evaluate(true).find_each('example', 'example2')).to eq(['one', 'two'])
      expect(ActiveRedisDB::String.evaluate(false).find_each('example', 'example2')).to eq(['one', 'two'])
    end

    it 'to be ["1", "2"]' do
      ActiveRedisDB::String.create('example', '1')
      ActiveRedisDB::String.create('example2', 2)

      expect(ActiveRedisDB::String.find_each('example', 'example2')).to eq(['1', '2'])
      expect(ActiveRedisDB::String.evaluate(false).find_each('example', 'example2')).to eq(['1', '2'])
    end

    it 'to be [1, 2]' do
      ActiveRedisDB::String.create('example', '1')
      ActiveRedisDB::String.create('example2', 2)

      expect(ActiveRedisDB::String.evaluate.find_each('example', 'example2')).to eq([1, 2])
      expect(ActiveRedisDB::String.evaluate(true).find_each('example', 'example2')).to eq([1, 2])
    end
  end

  describe '.length' do
    it 'to be 11' do
      ActiveRedisDB::String.create(:example, 'hello world')

      expect(ActiveRedisDB::String.length(:example)).to eq(11)
    end
  end

  describe '.split' do
    it 'to be nil' do
      expect(ActiveRedisDB::String.split(:example, 0, 3)).to eq(nil)
    end

    it 'to be "hel"' do
      ActiveRedisDB::String.create(:example, 'hello world')

      expect(ActiveRedisDB::String.split(:example, 0, 2)).to eq('hel')
    end
  end

  describe '.create' do
    it 'to be "1"' do
      ActiveRedisDB::String.create(:example, '1')

      expect(ActiveRedisDB::String.find(:example)).to eq('1')
    end

    it 'to be "2"' do
      ActiveRedisDB::String.create(:example, '1')
      ActiveRedisDB::String.create(:example, '2')

      expect(ActiveRedisDB::String.find(:example)).to eq('2')
    end

    it 'to be "1"' do
      ActiveRedisDB::String.create(:example, '1')
      ActiveRedisDB::String.create(:example, '2', nx: true)

      expect(ActiveRedisDB::String.find(:example)).to eq('1')
    end

    it 'to be nil' do
      ActiveRedisDB::String.create(:example, '1', xx: true)

      expect(ActiveRedisDB::String.find(:example)).to eq(nil)
    end

    it 'to be "1"' do
      ActiveRedisDB::String.create(:example, '1', ex: 1)

      expect(ActiveRedisDB::String.find(:example)).to eq('1')
    end
  end

  describe '.create!' do
    it 'to be "1"' do
      ActiveRedisDB::String.create!(:example, '1')

      expect(ActiveRedisDB::String.find(:example)).to eq('1')
    end

    it 'to be "1"' do
      ActiveRedisDB::String.create(:example, '1')
      ActiveRedisDB::String.create!(:example, '2')

      expect(ActiveRedisDB::String.find(:example)).to eq('1')
    end
  end

  describe '.create_each' do
    it 'to be "world"' do
      ActiveRedisDB::String.create_each(:example, 'hello', :example2, 'world')

      expect(ActiveRedisDB::String.find(:example2)).to eq('world')
    end
  end

  describe '.create_each!' do
    it 'to be "hello"' do
      ActiveRedisDB::String.create_each!(:example, 'hello', :example2, 'world')

      expect(ActiveRedisDB::String.find(:example)).to eq('hello')
    end
  end

  describe '.create_until' do
    it 'to be nil' do
      ActiveRedisDB::String.create_until(:example, 'hello', 2)
      sleep(3)

      expect(ActiveRedisDB::String.find(:example)).to eq(nil)
    end
  end

  describe '.append' do
    it 'to be "hello"' do
      expect(ActiveRedisDB::String.append(:example, 'hello')).to eq('hello')
    end

    it 'to be "hello world"' do
      ActiveRedisDB::String.create(:example, 'hello')
      ActiveRedisDB::String.append(:example, ' world')

      expect(ActiveRedisDB::String.find(:example)).to eq('hello world')
    end
  end

  describe '.replace' do
    it 'to be nil' do
      expect(ActiveRedisDB::String.replace(:example, 'hello', 6)).to eq(nil)
    end

    it 'to be "hello redis"' do
      ActiveRedisDB::String.create(:example, 'hello world')
      ActiveRedisDB::String.replace(:example, 'redis', 6)

      expect(ActiveRedisDB::String.find(:example)).to eq('hello redis')
    end
  end

  describe '.decrement' do
    it 'to be -1' do
      expect(ActiveRedisDB::String.decrement('example')).to eq(-1)
    end

    it 'to be 1' do
      ActiveRedisDB::String.create('example', 2)

      expect(ActiveRedisDB::String.decrement('example')).to eq(1)
    end

    it 'to be 3' do
      ActiveRedisDB::String.create('example', 5)

      expect(ActiveRedisDB::String.decrement('example', 2)).to eq(3)
    end
  end

  describe '.increment' do
    it 'to be 1' do
      expect(ActiveRedisDB::String.increment('example')).to eq(1)
    end

    it 'to be 2' do
      ActiveRedisDB::String.create('example', 1)

      expect(ActiveRedisDB::String.increment('example')).to eq(2)
    end

    it 'to be 5' do
      ActiveRedisDB::String.create(:example, 1)

      expect(ActiveRedisDB::String.increment('example', 4)).to eq(5)
    end
  end

  describe '.reset' do
    it 'to be nil' do
      expect(ActiveRedisDB::String.reset(:example)).to eq(nil)
    end

    it 'to be "0"' do
      ActiveRedisDB::String.create(:example, 2)
      ActiveRedisDB::String.reset(:example)

      expect(ActiveRedisDB::String.find(:example)).to eq('0')
    end

    it 'to be "2"' do
      ActiveRedisDB::String.create(:example, 4)
      ActiveRedisDB::String.reset(:example, 2)

      expect(ActiveRedisDB::String.find(:example)).to eq('2')
    end
  end

  describe '.bit_count' do
    it 'to be 0' do
      expect(ActiveRedisDB::String.bit_count(:example)).to eq(0)
    end

    it 'to be 26' do
      ActiveRedisDB::String.create(:example, 'foobar')

      expect(ActiveRedisDB::String.bit_count(:example)).to eq(26)
    end

    it 'to be 4' do
      ActiveRedisDB::String.create(:example, 'foobar')

      expect(ActiveRedisDB::String.bit_count(:example, 0, 0)).to eq(4)
    end

    it 'to be 6' do
      ActiveRedisDB::String.create(:example, 'foobar')

      expect(ActiveRedisDB::String.bit_count(:example, 1, 1)).to eq(6)
    end

    it 'to be 10' do
      ActiveRedisDB::String.create(:example, 'foobar')

      expect(ActiveRedisDB::String.bit_count(:example, 0, 1)).to eq(10)
    end
  end

  describe '.bit_where' do
    it 'to be ...' do
      ActiveRedisDB::String.create(:sample1, 'abc')
      ActiveRedisDB::String.create(:sample2, 123)

      ActiveRedisDB::String.bit_where(:and, 'sample1&2', :sample1, :sample2)
      ActiveRedisDB::String.bit_where(:or, 'sample1|2', :sample1, :sample2)
      ActiveRedisDB::String.bit_where(:xor, 'sample1^2', :sample1, :sample2)
      # ActiveRedisDB::String.bit_where(:not, 'sample1~2', :sample1, :sample2)

      expect(ActiveRedisDB::String.find('sample1&2')).to eq("!\"#")
      expect(ActiveRedisDB::String.find('sample1|2')).to eq('qrs')
      expect(ActiveRedisDB::String.find('sample1^2')).to eq('PPP')
      # expect(ActiveRedisDB::String.find('sample1~2')).to eq('qrs')
    end
  end

  describe '.get_bit' do
    it 'to be 0' do
      ActiveRedisDB::String.create(:example, 'a')

      expect(ActiveRedisDB::String.get_bit(:example, 3)).to eq(0)
      expect(ActiveRedisDB::String.get_bit(:example, 4)).to eq(0)
      expect(ActiveRedisDB::String.get_bit(:example, 5)).to eq(0)
      expect(ActiveRedisDB::String.get_bit(:example, 6)).to eq(0)
    end

    it 'to be 1' do
      ActiveRedisDB::String.create(:example, 'a')

      expect(ActiveRedisDB::String.get_bit(:example, 1)).to eq(1)
      expect(ActiveRedisDB::String.get_bit(:example, 2)).to eq(1)
      expect(ActiveRedisDB::String.get_bit(:example, 7)).to eq(1)
    end
  end

  describe '.set_bit' do
    it 'to be 0' do
      ActiveRedisDB::String.set_bit(:example, 10, 0)

      expect(ActiveRedisDB::String.set_bit(:example, 10, 0)).to eq(0)
      expect(ActiveRedisDB::String.set_bit(:example, 10, 1)).to eq(0)
    end

    it 'to be 1' do
      ActiveRedisDB::String.set_bit(:example, 10, 1)

      expect(ActiveRedisDB::String.get_bit(:example, 10)).to eq(1)
    end
  end

end
