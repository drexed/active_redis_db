# frozen_string_literal: true

require 'spec_helper'

describe ActiveRedisDB::List do

  before(:each) do
    ActiveRedisDB::Connection.flush_all
  end

  describe '.find' do
    it 'to be nil' do
      expect(ActiveRedisDB::List.find(:example)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate.find(:example)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate(true).find(:example)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate(false).find(:example)).to eq(nil)
    end

    it 'to be nil' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.find(:example, 4)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate.find(:example, 4)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate(true).find(:example, 4)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate(false).find(:example, 4)).to eq(nil)
    end

    it 'to be "2"' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.find(:example, 2)).to eq('2')
      expect(ActiveRedisDB::List.evaluate(false).find(:example, 2)).to eq('2')
    end

    it 'to be 2' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.evaluate.find(:example, 2)).to eq(2)
      expect(ActiveRedisDB::List.evaluate(true).find(:example, 2)).to eq(2)
    end

    it 'to be "three"' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.find(:example)).to eq('three')
      expect(ActiveRedisDB::List.evaluate.find(:example)).to eq('three')
      expect(ActiveRedisDB::List.evaluate(true).find(:example)).to eq('three')
      expect(ActiveRedisDB::List.evaluate(false).find(:example)).to eq('three')
    end

    response = { one: 'two', three: 4, five: ['six', 7], eight: { nine: 'ten', eleven: ['twelve', 13] } }

    it 'to be #{response}' do
      ActiveRedisDB::List.create(:example, response)

      expect(ActiveRedisDB::List.evaluate.find(:example)).to eq(response)
      expect(ActiveRedisDB::List.evaluate(true).find(:example)).to eq(response)
    end
  end

  describe '.first' do
    it 'to be nil' do
      expect(ActiveRedisDB::List.first(:example)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate.first(:example)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate(true).first(:example)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate(false).first(:example)).to eq(nil)
    end

    it 'to be "three"' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.first(:example)).to eq('three')
      expect(ActiveRedisDB::List.evaluate.first(:example)).to eq('three')
      expect(ActiveRedisDB::List.evaluate(true).first(:example)).to eq('three')
      expect(ActiveRedisDB::List.evaluate(false).first(:example)).to eq('three')
    end

    it 'to be ["three", "2"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.first(:example, 2)).to eq(['three', '2'])
      expect(ActiveRedisDB::List.evaluate(false).first(:example, 2)).to eq(['three', '2'])
    end

    it 'to be ["three", 2]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.evaluate.first(:example, 2)).to eq(['three', 2])
      expect(ActiveRedisDB::List.evaluate(true).first(:example, 2)).to eq(['three', 2])
    end

    it 'to be ["three", "2", "one"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.first(:example, 4)).to eq(['three', '2', 'one'])
      expect(ActiveRedisDB::List.evaluate(false).first(:example, 4)).to eq(['three', '2', 'one'])
    end

    it 'to be ["three", 2, "one"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.evaluate.first(:example, 4)).to eq(['three', 2, 'one'])
      expect(ActiveRedisDB::List.evaluate(true).first(:example, 4)).to eq(['three', 2, 'one'])
    end
  end

  describe '.last' do
    it 'to be nil' do
      expect(ActiveRedisDB::List.last(:example)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate.last(:example)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate(true).last(:example)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate(false).last(:example)).to eq(nil)
    end

    it 'to be "one"' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 'two')
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.last(:example)).to eq('one')
      expect(ActiveRedisDB::List.evaluate.last(:example)).to eq('one')
      expect(ActiveRedisDB::List.evaluate(true).last(:example)).to eq('one')
      expect(ActiveRedisDB::List.evaluate(false).last(:example)).to eq('one')
    end

    it 'to be ["2", "one"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.last(:example, 2)).to eq(['2', 'one'])
      expect(ActiveRedisDB::List.evaluate(false).last(:example, 2)).to eq(['2', 'one'])
    end

    it 'to be [2, "one"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.evaluate.last(:example, 2)).to eq([2, 'one'])
      expect(ActiveRedisDB::List.evaluate(true).last(:example, 2)).to eq([2, 'one'])
    end

    it 'to be ["three", "2", "one"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.last(:example, 4)).to eq(['three', '2', 'one'])
      expect(ActiveRedisDB::List.evaluate(false).last(:example, 4)).to eq(['three', '2', 'one'])
    end

    it 'to be ["three", 2, "one"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.evaluate.last(:example, 4)).to eq(['three', 2, 'one'])
      expect(ActiveRedisDB::List.evaluate(true).last(:example, 4)).to eq(['three', 2, 'one'])
    end
  end

  describe '.between' do
    it 'to be nil' do
      expect(ActiveRedisDB::List.between(:example)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate.between(:example)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate(true).between(:example)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate(false).between(:example)).to eq(nil)
    end

    it 'to be ["2"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.between(:example, 2, 2)).to eq(['2'])
      expect(ActiveRedisDB::List.evaluate(false).between(:example, 2, 2)).to eq(['2'])
    end

    it 'to be [2]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.evaluate.between(:example, 2, 2)).to eq([2])
      expect(ActiveRedisDB::List.evaluate(true).between(:example, 2, 2)).to eq([2])
    end

    it 'to be ["2", "one"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.between(:example, 2, 3)).to eq(['2', 'one'])
      expect(ActiveRedisDB::List.evaluate(false).between(:example, 2, 3)).to eq(['2', 'one'])
    end

    it 'to be [2, "one"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.evaluate.between(:example, 2, 3)).to eq([2, 'one'])
      expect(ActiveRedisDB::List.evaluate(true).between(:example, 2, 3)).to eq([2, 'one'])
    end

    it 'to be ["three", "2", "one"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.between(:example)).to eq(['three', '2', 'one'])
      expect(ActiveRedisDB::List.evaluate(false).between(:example)).to eq(['three', '2', 'one'])
    end

    it 'to be ["three", 2, "one"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.evaluate.between(:example)).to eq(['three', 2, 'one'])
      expect(ActiveRedisDB::List.evaluate(true).between(:example)).to eq(['three', 2, 'one'])
    end
  end

  describe '.all' do
    it 'to be nil' do
      expect(ActiveRedisDB::List.all(:example)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate.all(:example)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate(true).all(:example)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate(false).all(:example)).to eq(nil)
    end

    it 'to be ["three", "2", "one"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.all(:example)).to eq(['three', '2', 'one'])
      expect(ActiveRedisDB::List.evaluate(false).all(:example)).to eq(['three', '2', 'one'])
    end

    it 'to be ["three", 2, "one"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.evaluate.all(:example)).to eq(['three', 2, 'one'])
      expect(ActiveRedisDB::List.evaluate(true).all(:example)).to eq(['three', 2, 'one'])
    end
  end

  describe '.count' do
    it 'to be 0' do
      expect(ActiveRedisDB::List.count(:example)).to eq(0)
    end

    it 'to be 3' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 'two')
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.count(:example)).to eq(3)
    end
  end

  describe '.create' do
    it 'to be ["1"], ["2"], ["3"], ["4"]' do
      ActiveRedisDB::List.create('example_1', '1')
      ActiveRedisDB::List.create(:example_2, 2)
      ActiveRedisDB::List.create('example_3', '3', 'prepend')
      ActiveRedisDB::List.create(:example_4, 4, :append)

      expect(ActiveRedisDB::List.all('example_1')).to eq(['1'])
      expect(ActiveRedisDB::List.all(:example_2)).to eq(['2'])
      expect(ActiveRedisDB::List.all('example_3')).to eq(['3'])
      expect(ActiveRedisDB::List.all(:example_4)).to eq(['4'])
    end

    it 'to be ["three", "2", "1"]' do
      ActiveRedisDB::List.create(:example, '1')
      ActiveRedisDB::List.create(:example, 2)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.all(:example)).to eq(['three', '2', '1'])
    end

    it 'to be ["four", "three", "2", "1"]' do
      ActiveRedisDB::List.create(:example, ['1', '2', 'three', 'four'])

      expect(ActiveRedisDB::List.all(:example)).to eq(['four', 'three', '2', '1'])
    end

    it 'to be ["three", "2", "1"]' do
      ActiveRedisDB::List.create(:example, '1')
      ActiveRedisDB::List.create(:example, 2, :prepend)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.all(:example)).to eq(['three', '2', '1'])
    end

    it 'to be ["four", "three", "2", "1"]' do
      ActiveRedisDB::List.create(:example, ['1', '2', 'three', 'four'], :prepend)

      expect(ActiveRedisDB::List.all(:example)).to eq(['four', 'three', '2', '1'])
    end

    it 'to be ["three", "1", "2"]' do
      ActiveRedisDB::List.create(:example, '1')
      ActiveRedisDB::List.create(:example, 2, :append)
      ActiveRedisDB::List.create(:example, 'three')

      expect(ActiveRedisDB::List.all(:example)).to eq(['three', '1', '2'])
    end

    it 'to be ["1", "2", "three", "four"]' do
      ActiveRedisDB::List.create(:example, ['1', '2', 'three', 'four'], :append)

      expect(ActiveRedisDB::List.all(:example)).to eq(['1', '2', 'three', 'four'])
    end
  end

  describe '.create!' do
    it 'to be nil' do
      ActiveRedisDB::List.create!(:example, 2)

      expect(ActiveRedisDB::List.all(:example)).to eq(nil)
    end

    it 'to be nil' do
      ActiveRedisDB::List.create!(:example, [1, 2, 3, 4])

      expect(ActiveRedisDB::List.all(:example)).to eq(nil)
    end

    it 'to be ["three", "2", "1"]' do
      ActiveRedisDB::List.create(:example, '1')
      ActiveRedisDB::List.create!(:example, 2)
      ActiveRedisDB::List.create!(:example, 'three')

      expect(ActiveRedisDB::List.all(:example)).to eq(['three', '2', '1'])
    end

    it 'to be ["four", "three", "2", "1"]' do
      ActiveRedisDB::List.create(:example, '1')
      ActiveRedisDB::List.create!(:example, [2, 'three', 'four'])

      expect(ActiveRedisDB::List.all(:example)).to eq(['four', 'three', '2', '1'])
    end

    it 'to be ["three", "2", "1"]' do
      ActiveRedisDB::List.create(:example, '1')
      ActiveRedisDB::List.create!(:example, 2, :prepend)
      ActiveRedisDB::List.create!(:example, 'three')

      expect(ActiveRedisDB::List.all(:example)).to eq(['three', '2', '1'])
    end

    it 'to be ["four", "three", "2", "1"]' do
      ActiveRedisDB::List.create(:example, '1')
      ActiveRedisDB::List.create!(:example, [2, 'three', 'four'], :prepend)

      expect(ActiveRedisDB::List.all(:example)).to eq(['four', 'three', '2', '1'])
    end

    it 'to be ["three", "1", "2"]' do
      ActiveRedisDB::List.create(:example, '1')
      ActiveRedisDB::List.create!(:example, 2, :append)
      ActiveRedisDB::List.create!(:example, 'three')

      expect(ActiveRedisDB::List.all(:example)).to eq(['three', '1', '2'])
    end

    it 'to be ["1", "2", "three", "four"]' do
      ActiveRedisDB::List.create(:example, '1')
      ActiveRedisDB::List.create!(:example, [2, 'three', 'four'], :append)

      expect(ActiveRedisDB::List.all(:example)).to eq(['1', '2', 'three', 'four'])
    end
  end

  describe '.create_limit' do
    it 'to be ["three", "two"]' do
      ActiveRedisDB::List.create_limit(:example, 'one', 2)
      ActiveRedisDB::List.create_limit(:example, 'two', 2)
      ActiveRedisDB::List.create_limit(:example, 'three', 2)

      expect(ActiveRedisDB::List.all(:example)).to eq(['three', 'two'])
    end

    it 'to be ["four", "three", "two"]' do
      ActiveRedisDB::List.create_limit(:example, ['one', 'two', 'three', 'four'], 3)

      expect(ActiveRedisDB::List.all(:example)).to eq(['four', 'three', 'two'])
    end

    it 'to be ["three", "two"]' do
      ActiveRedisDB::List.create_limit(:example, 'one', 2)
      ActiveRedisDB::List.create_limit(:example, 'two', 2, :prepend)
      ActiveRedisDB::List.create_limit(:example, 'three', 2)

      expect(ActiveRedisDB::List.all(:example)).to eq(['three', 'two'])
    end

    it 'to be ["four", "three", "two"]' do
      ActiveRedisDB::List.create_limit(:example, ['one', 'two', 'three', 'four'], 3, :prepend)

      expect(ActiveRedisDB::List.all(:example)).to eq(['four', 'three', 'two'])
    end

    it 'to be ["three", "one"]' do
      ActiveRedisDB::List.create_limit(:example, 'one', 2)
      ActiveRedisDB::List.create_limit(:example, 'two', 2, :append)
      ActiveRedisDB::List.create_limit(:example, 'three', 2)

      expect(ActiveRedisDB::List.all(:example)).to eq(['three', 'one'])
    end

    it 'to be ["one", "two", "three"]' do
      ActiveRedisDB::List.create_limit(:example, ['one', 'two', 'three', 'four'], 3, :append)

      expect(ActiveRedisDB::List.all(:example)).to eq(['one', 'two', 'three'])
    end
  end

  describe '.create_limit!' do
    it 'to be nil' do
      ActiveRedisDB::List.create_limit!(:example, 'one', 2)
      ActiveRedisDB::List.create_limit!(:example, 'two', 2)
      ActiveRedisDB::List.create_limit!(:example, 'three', 2)

      expect(ActiveRedisDB::List.all(:example)).to eq(nil)
    end

    it 'to be nil' do
      ActiveRedisDB::List.create_limit!(:example, ['one', 'two', 'three'], 2)

      expect(ActiveRedisDB::List.all(:example)).to eq(nil)
    end

    it 'to be ["three", "two"]' do
      ActiveRedisDB::List.create_limit(:example, 'one', 2)
      ActiveRedisDB::List.create_limit!(:example, 'two', 2)
      ActiveRedisDB::List.create_limit!(:example, 'three', 2)

      expect(ActiveRedisDB::List.all(:example)).to eq(['three', 'two'])
    end

    it 'to be ["four", "three", "two"]' do
      ActiveRedisDB::List.create_limit(:example, 'one', 3)
      ActiveRedisDB::List.create_limit!(:example, ['two', 'three', 'four'], 3)

      expect(ActiveRedisDB::List.all(:example)).to eq(['four', 'three', 'two'])
    end

    it 'to be ["three", "two"]' do
      ActiveRedisDB::List.create_limit(:example, 'one', 2)
      ActiveRedisDB::List.create_limit!(:example, 'two', 2, :prepend)
      ActiveRedisDB::List.create_limit!(:example, 'three', 2)

      expect(ActiveRedisDB::List.all(:example)).to eq(['three', 'two'])
    end

    it 'to be ["four", "three", "two"]' do
      ActiveRedisDB::List.create_limit(:example, 'one', 3)
      ActiveRedisDB::List.create_limit!(:example, ['two', 'three', 'four'], 3, :prepend)

      expect(ActiveRedisDB::List.all(:example)).to eq(['four', 'three', 'two'])
    end

    it 'to be ["three", "one"]' do
      ActiveRedisDB::List.create_limit(:example, 'one', 2)
      ActiveRedisDB::List.create_limit!(:example, 'two', 2, :append)
      ActiveRedisDB::List.create_limit!(:example, 'three', 2)

      expect(ActiveRedisDB::List.all(:example)).to eq(['three', 'one'])
    end

    it 'to be ["one", "two", "three"]' do
      ActiveRedisDB::List.create_limit(:example, 'one', 3)
      ActiveRedisDB::List.create_limit!(:example, ['two', 'three', 'four'], 3, :append)

      expect(ActiveRedisDB::List.all(:example)).to eq(['one', 'two', 'three'])
    end
  end

  describe '.create_before' do
    it 'to be ["three", "four", "two", "one"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 'two')
      ActiveRedisDB::List.create(:example, 'three')

      ActiveRedisDB::List.create_before(:example, 'two', 'four')

      expect(ActiveRedisDB::List.all(:example)).to eq(['three', 'four', 'two', 'one'])
    end
  end

  describe '.create_after' do
    it 'to be ["three", "two", "four", "one"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 'two')
      ActiveRedisDB::List.create(:example, 'three')

      ActiveRedisDB::List.create_after(:example, 'two', 'four')

      expect(ActiveRedisDB::List.all(:example)).to eq(['three', 'two', 'four', 'one'])
    end
  end

  describe '.update' do
    it 'to be nil' do
      expect(ActiveRedisDB::List.update(:example, 1, 'v1')).to eq(nil)
    end

    it 'to be ["four", "five", "three"]' do
      ActiveRedisDB::List.create(:example, 'one', :append)
      ActiveRedisDB::List.create(:example, 'two', :append)
      ActiveRedisDB::List.create(:example, 'three', :append)

      ActiveRedisDB::List.update(:example, 0, 'four')
      ActiveRedisDB::List.update(:example, -2, 'five')

      expect(ActiveRedisDB::List.all(:example)).to eq(['four', 'five', 'three'])
    end
  end

  describe '.move' do
    it 'to be nil' do
      expect(ActiveRedisDB::List.move(:example1, :example2)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate.move(:example1, :example2)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate(true).move(:example1, :example2)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate(false).move(:example1, :example2)).to eq(nil)
    end

    it 'to be "3"' do
      ActiveRedisDB::List.create(:example1, 1, :append)
      ActiveRedisDB::List.create(:example1, 'two', :append)
      ActiveRedisDB::List.create(:example1, '3', :append)

      expect(ActiveRedisDB::List.move(:example1, :example2)).to eq('3')
    end

    it 'to be 3' do
      ActiveRedisDB::List.create(:example1, 1, :append)
      ActiveRedisDB::List.create(:example1, 'two', :append)
      ActiveRedisDB::List.create(:example1, '3', :append)

      expect(ActiveRedisDB::List.evaluate.move(:example1, :example2)).to eq(3)
    end

    it 'to be ["1", "two", "3"]' do
      ActiveRedisDB::List.create(:example1, 1, :append)
      ActiveRedisDB::List.create(:example1, 'two', :append)
      ActiveRedisDB::List.create(:example1, '3', :append)

      ActiveRedisDB::List.move(:example1, :example2)

      expect(ActiveRedisDB::List.all(:example1)).to eq(['1', 'two'])
    end

    it 'to be ["1", "two", "3"]' do
      ActiveRedisDB::List.create(:example1, 1, :append)
      ActiveRedisDB::List.create(:example1, 'two', :append)
      ActiveRedisDB::List.create(:example1, '3', :append)

      ActiveRedisDB::List.move(:example1, :example2)

      expect(ActiveRedisDB::List.all(:example2)).to eq(['3'])
    end
  end

  describe '.move_blocking' do
    # TODO
  end

  describe '.destroy' do
    it 'to be 0' do
      expect(ActiveRedisDB::List.destroy(:example, 1, 'v1')).to eq(0)
    end

    it 'to be 2' do
      ActiveRedisDB::List.create(:example, 'v1', :append)
      ActiveRedisDB::List.create(:example, 'v2', :append)
      ActiveRedisDB::List.create(:example, 'v2', :append)
      ActiveRedisDB::List.create(:example, 'v2', :append)
      ActiveRedisDB::List.create(:example, 'v1', :append)

      ActiveRedisDB::List.destroy(:example, 1, 'v1')
      ActiveRedisDB::List.destroy(:example, -2, 'v2')

      expect(ActiveRedisDB::List.count(:example)).to eq(2)
    end
  end

  describe '.destroy_first' do
    it 'to be nil' do
      expect(ActiveRedisDB::List.destroy_first(:example)).to eq(nil)
    end

    it 'to be ["two", "one"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 'two')
      ActiveRedisDB::List.create(:example, 'three')

      ActiveRedisDB::List.destroy_first(:example)

      expect(ActiveRedisDB::List.all(:example)).to eq(['two', 'one'])
    end

    it 'to be ["one"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 'two')
      ActiveRedisDB::List.create(:example, 'three')
      ActiveRedisDB::List.create(:example, 'four')

      ActiveRedisDB::List.destroy_first(:example, 3)

      expect(ActiveRedisDB::List.all(:example)).to eq(['one'])
    end
  end

  describe '.destroy_last' do
    it 'to be nil' do
      expect(ActiveRedisDB::List.destroy_last(:example)).to eq(nil)
    end

    it 'to be ["three", "two"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 'two')
      ActiveRedisDB::List.create(:example, 'three')

      ActiveRedisDB::List.destroy_last(:example)

      expect(ActiveRedisDB::List.all(:example)).to eq(['three', 'two'])
    end

    it 'to be ["four"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 'two')
      ActiveRedisDB::List.create(:example, 'three')
      ActiveRedisDB::List.create(:example, 'four')

      ActiveRedisDB::List.destroy_last(:example, 3)

      expect(ActiveRedisDB::List.all(:example)).to eq(['four'])
    end
  end

  describe '.destroy_except' do
    it 'to be nil' do
      expect(ActiveRedisDB::List.destroy_except(:example, 2, 3)).to eq(nil)
    end

    it 'to be ["three", "two"]' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 'two')
      ActiveRedisDB::List.create(:example, 'three')
      ActiveRedisDB::List.create(:example, 'four')

      ActiveRedisDB::List.destroy_except(:example, 2, 3)

      expect(ActiveRedisDB::List.all(:example)).to eq(['three', 'two'])
    end
  end

  describe '.destroy_all' do
    it 'to be nil' do
      expect(ActiveRedisDB::List.destroy_all(:example)).to eq(nil)
    end

    it 'to be nil' do
      ActiveRedisDB::List.create(:example, 'one')
      ActiveRedisDB::List.create(:example, 'two')
      ActiveRedisDB::List.create(:example, 'three')

      ActiveRedisDB::List.destroy_all(:example)

      expect(ActiveRedisDB::List.all(:example)).to eq(nil)
    end
  end

  describe '.pop' do
    it 'to be nil' do
      expect(ActiveRedisDB::List.pop(:example)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate.pop(:example)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate(true).pop(:example)).to eq(nil)
      expect(ActiveRedisDB::List.evaluate(false).pop(:example)).to eq(nil)
    end

    it 'to be "one"' do
      ActiveRedisDB::List.create(:example, 'one', :append)
      ActiveRedisDB::List.create(:example, 'two', :append)
      ActiveRedisDB::List.create(:example, 'three', :append)

      expect(ActiveRedisDB::List.pop(:example)).to eq('one')
    end

    it 'to be 1' do
      ActiveRedisDB::List.create(:example, 1, :append)
      ActiveRedisDB::List.create(:example, 'two', :append)
      ActiveRedisDB::List.create(:example, '3', :append)

      expect(ActiveRedisDB::List.evaluate.pop(:example)).to eq(1)
    end

    it 'to be "three"' do
      ActiveRedisDB::List.create(:example, 'one', :append)
      ActiveRedisDB::List.create(:example, 'two', :append)
      ActiveRedisDB::List.create(:example, 'three', :append)

      expect(ActiveRedisDB::List.pop(:example, :append)).to eq('three')
    end

    it 'to be 3' do
      ActiveRedisDB::List.create(:example, 1, :append)
      ActiveRedisDB::List.create(:example, 'two', :append)
      ActiveRedisDB::List.create(:example, 3, :append)

      expect(ActiveRedisDB::List.evaluate(true).pop(:example, :append)).to eq(3)
    end

    it 'to be ["two", "three"]' do
      ActiveRedisDB::List.create(:example, 'one', :append)
      ActiveRedisDB::List.create(:example, 'two', :append)
      ActiveRedisDB::List.create(:example, 'three', :append)
      ActiveRedisDB::List.pop(:example)

      expect(ActiveRedisDB::List.all(:example)).to eq(['two', 'three'])
    end

    it 'to be ["two", 3]' do
      ActiveRedisDB::List.create(:example, 1, :append)
      ActiveRedisDB::List.create(:example, 'two', :append)
      ActiveRedisDB::List.create(:example, '3', :append)
      ActiveRedisDB::List.pop(:example)

      expect(ActiveRedisDB::List.evaluate.all(:example)).to eq(['two', 3])
    end

    it 'to be ["one", "two"]' do
      ActiveRedisDB::List.create(:example, 'one', :append)
      ActiveRedisDB::List.create(:example, 'two', :append)
      ActiveRedisDB::List.create(:example, 'three', :append)
      ActiveRedisDB::List.pop(:example, :append)

      expect(ActiveRedisDB::List.all(:example)).to eq(['one', 'two'])
    end

    it 'to be [1, "two"]' do
      ActiveRedisDB::List.create(:example, 1, :append)
      ActiveRedisDB::List.create(:example, 'two', :append)
      ActiveRedisDB::List.create(:example, '3', :append)
      ActiveRedisDB::List.pop(:example, :append)

      expect(ActiveRedisDB::List.evaluate.all(:example)).to eq([1, 'two'])
    end
  end

  describe '.pop_blocking' do
    # TODO
  end

end
