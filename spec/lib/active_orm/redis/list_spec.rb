# frozen_string_literal: true

require 'spec_helper'

describe ActiveOrm::Redis::List do

  before(:each) do
    ActiveOrm::Redis::Connection.flush_all
  end

  describe '.find' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::List.find(:example)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate.find(:example)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate(true).find(:example)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate(false).find(:example)).to eq(nil)
    end

    it 'to be nil' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.find(:example, 4)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate.find(:example, 4)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate(true).find(:example, 4)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate(false).find(:example, 4)).to eq(nil)
    end

    it 'to be "2"' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.find(:example, 2)).to eq('2')
      expect(ActiveOrm::Redis::List.evaluate(false).find(:example, 2)).to eq('2')
    end

    it 'to be 2' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.evaluate.find(:example, 2)).to eq(2)
      expect(ActiveOrm::Redis::List.evaluate(true).find(:example, 2)).to eq(2)
    end

    it 'to be "three"' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.find(:example)).to eq('three')
      expect(ActiveOrm::Redis::List.evaluate.find(:example)).to eq('three')
      expect(ActiveOrm::Redis::List.evaluate(true).find(:example)).to eq('three')
      expect(ActiveOrm::Redis::List.evaluate(false).find(:example)).to eq('three')
    end

    response = { one: 'two', three: 4, five: ['six', 7], eight: { nine: 'ten', eleven: ['twelve', 13] } }

    it 'to be #{response}' do
      ActiveOrm::Redis::List.create(:example, response)

      expect(ActiveOrm::Redis::List.evaluate.find(:example)).to eq(response)
      expect(ActiveOrm::Redis::List.evaluate(true).find(:example)).to eq(response)
    end
  end

  describe '.first' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::List.first(:example)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate.first(:example)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate(true).first(:example)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate(false).first(:example)).to eq(nil)
    end

    it 'to be "three"' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.first(:example)).to eq('three')
      expect(ActiveOrm::Redis::List.evaluate.first(:example)).to eq('three')
      expect(ActiveOrm::Redis::List.evaluate(true).first(:example)).to eq('three')
      expect(ActiveOrm::Redis::List.evaluate(false).first(:example)).to eq('three')
    end

    it 'to be ["three", "2"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.first(:example, 2)).to eq(['three', '2'])
      expect(ActiveOrm::Redis::List.evaluate(false).first(:example, 2)).to eq(['three', '2'])
    end

    it 'to be ["three", 2]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.evaluate.first(:example, 2)).to eq(['three', 2])
      expect(ActiveOrm::Redis::List.evaluate(true).first(:example, 2)).to eq(['three', 2])
    end

    it 'to be ["three", "2", "one"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.first(:example, 4)).to eq(['three', '2', 'one'])
      expect(ActiveOrm::Redis::List.evaluate(false).first(:example, 4)).to eq(['three', '2', 'one'])
    end

    it 'to be ["three", 2, "one"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.evaluate.first(:example, 4)).to eq(['three', 2, 'one'])
      expect(ActiveOrm::Redis::List.evaluate(true).first(:example, 4)).to eq(['three', 2, 'one'])
    end
  end

  describe '.last' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::List.last(:example)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate.last(:example)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate(true).last(:example)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate(false).last(:example)).to eq(nil)
    end

    it 'to be "one"' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 'two')
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.last(:example)).to eq('one')
      expect(ActiveOrm::Redis::List.evaluate.last(:example)).to eq('one')
      expect(ActiveOrm::Redis::List.evaluate(true).last(:example)).to eq('one')
      expect(ActiveOrm::Redis::List.evaluate(false).last(:example)).to eq('one')
    end

    it 'to be ["2", "one"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.last(:example, 2)).to eq(['2', 'one'])
      expect(ActiveOrm::Redis::List.evaluate(false).last(:example, 2)).to eq(['2', 'one'])
    end

    it 'to be [2, "one"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.evaluate.last(:example, 2)).to eq([2, 'one'])
      expect(ActiveOrm::Redis::List.evaluate(true).last(:example, 2)).to eq([2, 'one'])
    end

    it 'to be ["three", "2", "one"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.last(:example, 4)).to eq(['three', '2', 'one'])
      expect(ActiveOrm::Redis::List.evaluate(false).last(:example, 4)).to eq(['three', '2', 'one'])
    end

    it 'to be ["three", 2, "one"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.evaluate.last(:example, 4)).to eq(['three', 2, 'one'])
      expect(ActiveOrm::Redis::List.evaluate(true).last(:example, 4)).to eq(['three', 2, 'one'])
    end
  end

  describe '.between' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::List.between(:example)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate.between(:example)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate(true).between(:example)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate(false).between(:example)).to eq(nil)
    end

    it 'to be ["2"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.between(:example, 2, 2)).to eq(['2'])
      expect(ActiveOrm::Redis::List.evaluate(false).between(:example, 2, 2)).to eq(['2'])
    end

    it 'to be [2]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.evaluate.between(:example, 2, 2)).to eq([2])
      expect(ActiveOrm::Redis::List.evaluate(true).between(:example, 2, 2)).to eq([2])
    end

    it 'to be ["2", "one"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.between(:example, 2, 3)).to eq(['2', 'one'])
      expect(ActiveOrm::Redis::List.evaluate(false).between(:example, 2, 3)).to eq(['2', 'one'])
    end

    it 'to be [2, "one"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.evaluate.between(:example, 2, 3)).to eq([2, 'one'])
      expect(ActiveOrm::Redis::List.evaluate(true).between(:example, 2, 3)).to eq([2, 'one'])
    end

    it 'to be ["three", "2", "one"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.between(:example)).to eq(['three', '2', 'one'])
      expect(ActiveOrm::Redis::List.evaluate(false).between(:example)).to eq(['three', '2', 'one'])
    end

    it 'to be ["three", 2, "one"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.evaluate.between(:example)).to eq(['three', 2, 'one'])
      expect(ActiveOrm::Redis::List.evaluate(true).between(:example)).to eq(['three', 2, 'one'])
    end
  end

  describe '.all' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::List.all(:example)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate.all(:example)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate(true).all(:example)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate(false).all(:example)).to eq(nil)
    end

    it 'to be ["three", "2", "one"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['three', '2', 'one'])
      expect(ActiveOrm::Redis::List.evaluate(false).all(:example)).to eq(['three', '2', 'one'])
    end

    it 'to be ["three", 2, "one"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.evaluate.all(:example)).to eq(['three', 2, 'one'])
      expect(ActiveOrm::Redis::List.evaluate(true).all(:example)).to eq(['three', 2, 'one'])
    end
  end

  describe '.count' do
    it 'to be 0' do
      expect(ActiveOrm::Redis::List.count(:example)).to eq(0)
    end

    it 'to be 3' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 'two')
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.count(:example)).to eq(3)
    end
  end

  describe '.create' do
    it 'to be ["1"], ["2"], ["3"], ["4"]' do
      ActiveOrm::Redis::List.create('example_1', '1')
      ActiveOrm::Redis::List.create(:example_2, 2)
      ActiveOrm::Redis::List.create('example_3', '3', 'prepend')
      ActiveOrm::Redis::List.create(:example_4, 4, :append)

      expect(ActiveOrm::Redis::List.all('example_1')).to eq(['1'])
      expect(ActiveOrm::Redis::List.all(:example_2)).to eq(['2'])
      expect(ActiveOrm::Redis::List.all('example_3')).to eq(['3'])
      expect(ActiveOrm::Redis::List.all(:example_4)).to eq(['4'])
    end

    it 'to be ["three", "2", "1"]' do
      ActiveOrm::Redis::List.create(:example, '1')
      ActiveOrm::Redis::List.create(:example, 2)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['three', '2', '1'])
    end

    it 'to be ["four", "three", "2", "1"]' do
      ActiveOrm::Redis::List.create(:example, ['1', '2', 'three', 'four'])

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['four', 'three', '2', '1'])
    end

    it 'to be ["three", "2", "1"]' do
      ActiveOrm::Redis::List.create(:example, '1')
      ActiveOrm::Redis::List.create(:example, 2, :prepend)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['three', '2', '1'])
    end

    it 'to be ["four", "three", "2", "1"]' do
      ActiveOrm::Redis::List.create(:example, ['1', '2', 'three', 'four'], :prepend)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['four', 'three', '2', '1'])
    end

    it 'to be ["three", "1", "2"]' do
      ActiveOrm::Redis::List.create(:example, '1')
      ActiveOrm::Redis::List.create(:example, 2, :append)
      ActiveOrm::Redis::List.create(:example, 'three')

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['three', '1', '2'])
    end

    it 'to be ["1", "2", "three", "four"]' do
      ActiveOrm::Redis::List.create(:example, ['1', '2', 'three', 'four'], :append)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['1', '2', 'three', 'four'])
    end
  end

  describe '.create!' do
    it 'to be nil' do
      ActiveOrm::Redis::List.create!(:example, 2)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(nil)
    end

    it 'to be nil' do
      ActiveOrm::Redis::List.create!(:example, [1, 2, 3, 4])

      expect(ActiveOrm::Redis::List.all(:example)).to eq(nil)
    end

    it 'to be ["three", "2", "1"]' do
      ActiveOrm::Redis::List.create(:example, '1')
      ActiveOrm::Redis::List.create!(:example, 2)
      ActiveOrm::Redis::List.create!(:example, 'three')

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['three', '2', '1'])
    end

    it 'to be ["four", "three", "2", "1"]' do
      ActiveOrm::Redis::List.create(:example, '1')
      ActiveOrm::Redis::List.create!(:example, [2, 'three', 'four'])

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['four', 'three', '2', '1'])
    end

    it 'to be ["three", "2", "1"]' do
      ActiveOrm::Redis::List.create(:example, '1')
      ActiveOrm::Redis::List.create!(:example, 2, :prepend)
      ActiveOrm::Redis::List.create!(:example, 'three')

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['three', '2', '1'])
    end

    it 'to be ["four", "three", "2", "1"]' do
      ActiveOrm::Redis::List.create(:example, '1')
      ActiveOrm::Redis::List.create!(:example, [2, 'three', 'four'], :prepend)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['four', 'three', '2', '1'])
    end

    it 'to be ["three", "1", "2"]' do
      ActiveOrm::Redis::List.create(:example, '1')
      ActiveOrm::Redis::List.create!(:example, 2, :append)
      ActiveOrm::Redis::List.create!(:example, 'three')

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['three', '1', '2'])
    end

    it 'to be ["1", "2", "three", "four"]' do
      ActiveOrm::Redis::List.create(:example, '1')
      ActiveOrm::Redis::List.create!(:example, [2, 'three', 'four'], :append)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['1', '2', 'three', 'four'])
    end
  end

  describe '.create_limit' do
    it 'to be ["three", "two"]' do
      ActiveOrm::Redis::List.create_limit(:example, 'one', 2)
      ActiveOrm::Redis::List.create_limit(:example, 'two', 2)
      ActiveOrm::Redis::List.create_limit(:example, 'three', 2)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['three', 'two'])
    end

    it 'to be ["four", "three", "two"]' do
      ActiveOrm::Redis::List.create_limit(:example, ['one', 'two', 'three', 'four'], 3)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['four', 'three', 'two'])
    end

    it 'to be ["three", "two"]' do
      ActiveOrm::Redis::List.create_limit(:example, 'one', 2)
      ActiveOrm::Redis::List.create_limit(:example, 'two', 2, :prepend)
      ActiveOrm::Redis::List.create_limit(:example, 'three', 2)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['three', 'two'])
    end

    it 'to be ["four", "three", "two"]' do
      ActiveOrm::Redis::List.create_limit(:example, ['one', 'two', 'three', 'four'], 3, :prepend)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['four', 'three', 'two'])
    end

    it 'to be ["three", "one"]' do
      ActiveOrm::Redis::List.create_limit(:example, 'one', 2)
      ActiveOrm::Redis::List.create_limit(:example, 'two', 2, :append)
      ActiveOrm::Redis::List.create_limit(:example, 'three', 2)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['three', 'one'])
    end

    it 'to be ["one", "two", "three"]' do
      ActiveOrm::Redis::List.create_limit(:example, ['one', 'two', 'three', 'four'], 3, :append)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['one', 'two', 'three'])
    end
  end

  describe '.create_limit!' do
    it 'to be nil' do
      ActiveOrm::Redis::List.create_limit!(:example, 'one', 2)
      ActiveOrm::Redis::List.create_limit!(:example, 'two', 2)
      ActiveOrm::Redis::List.create_limit!(:example, 'three', 2)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(nil)
    end

    it 'to be nil' do
      ActiveOrm::Redis::List.create_limit!(:example, ['one', 'two', 'three'], 2)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(nil)
    end

    it 'to be ["three", "two"]' do
      ActiveOrm::Redis::List.create_limit(:example, 'one', 2)
      ActiveOrm::Redis::List.create_limit!(:example, 'two', 2)
      ActiveOrm::Redis::List.create_limit!(:example, 'three', 2)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['three', 'two'])
    end

    it 'to be ["four", "three", "two"]' do
      ActiveOrm::Redis::List.create_limit(:example, 'one', 3)
      ActiveOrm::Redis::List.create_limit!(:example, ['two', 'three', 'four'], 3)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['four', 'three', 'two'])
    end

    it 'to be ["three", "two"]' do
      ActiveOrm::Redis::List.create_limit(:example, 'one', 2)
      ActiveOrm::Redis::List.create_limit!(:example, 'two', 2, :prepend)
      ActiveOrm::Redis::List.create_limit!(:example, 'three', 2)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['three', 'two'])
    end

    it 'to be ["four", "three", "two"]' do
      ActiveOrm::Redis::List.create_limit(:example, 'one', 3)
      ActiveOrm::Redis::List.create_limit!(:example, ['two', 'three', 'four'], 3, :prepend)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['four', 'three', 'two'])
    end

    it 'to be ["three", "one"]' do
      ActiveOrm::Redis::List.create_limit(:example, 'one', 2)
      ActiveOrm::Redis::List.create_limit!(:example, 'two', 2, :append)
      ActiveOrm::Redis::List.create_limit!(:example, 'three', 2)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['three', 'one'])
    end

    it 'to be ["one", "two", "three"]' do
      ActiveOrm::Redis::List.create_limit(:example, 'one', 3)
      ActiveOrm::Redis::List.create_limit!(:example, ['two', 'three', 'four'], 3, :append)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['one', 'two', 'three'])
    end
  end

  describe '.create_before' do
    it 'to be ["three", "four", "two", "one"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 'two')
      ActiveOrm::Redis::List.create(:example, 'three')

      ActiveOrm::Redis::List.create_before(:example, 'two', 'four')

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['three', 'four', 'two', 'one'])
    end
  end

  describe '.create_after' do
    it 'to be ["three", "two", "four", "one"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 'two')
      ActiveOrm::Redis::List.create(:example, 'three')

      ActiveOrm::Redis::List.create_after(:example, 'two', 'four')

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['three', 'two', 'four', 'one'])
    end
  end

  describe '.update' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::List.update(:example, 1, 'v1')).to eq(nil)
    end

    it 'to be ["four", "five", "three"]' do
      ActiveOrm::Redis::List.create(:example, 'one', :append)
      ActiveOrm::Redis::List.create(:example, 'two', :append)
      ActiveOrm::Redis::List.create(:example, 'three', :append)

      ActiveOrm::Redis::List.update(:example, 0, 'four')
      ActiveOrm::Redis::List.update(:example, -2, 'five')

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['four', 'five', 'three'])
    end
  end

  describe '.move' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::List.move(:example1, :example2)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate.move(:example1, :example2)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate(true).move(:example1, :example2)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate(false).move(:example1, :example2)).to eq(nil)
    end

    it 'to be "3"' do
      ActiveOrm::Redis::List.create(:example1, 1, :append)
      ActiveOrm::Redis::List.create(:example1, 'two', :append)
      ActiveOrm::Redis::List.create(:example1, '3', :append)

      expect(ActiveOrm::Redis::List.move(:example1, :example2)).to eq('3')
    end

    it 'to be 3' do
      ActiveOrm::Redis::List.create(:example1, 1, :append)
      ActiveOrm::Redis::List.create(:example1, 'two', :append)
      ActiveOrm::Redis::List.create(:example1, '3', :append)

      expect(ActiveOrm::Redis::List.evaluate.move(:example1, :example2)).to eq(3)
    end

    it 'to be ["1", "two", "3"]' do
      ActiveOrm::Redis::List.create(:example1, 1, :append)
      ActiveOrm::Redis::List.create(:example1, 'two', :append)
      ActiveOrm::Redis::List.create(:example1, '3', :append)

      ActiveOrm::Redis::List.move(:example1, :example2)

      expect(ActiveOrm::Redis::List.all(:example1)).to eq(['1', 'two'])
    end

    it 'to be ["1", "two", "3"]' do
      ActiveOrm::Redis::List.create(:example1, 1, :append)
      ActiveOrm::Redis::List.create(:example1, 'two', :append)
      ActiveOrm::Redis::List.create(:example1, '3', :append)

      ActiveOrm::Redis::List.move(:example1, :example2)

      expect(ActiveOrm::Redis::List.all(:example2)).to eq(['3'])
    end
  end

  describe '.move_blocking' do
    # TODO
  end

  describe '.destroy' do
    it 'to be 0' do
      expect(ActiveOrm::Redis::List.destroy(:example, 1, 'v1')).to eq(0)
    end

    it 'to be 2' do
      ActiveOrm::Redis::List.create(:example, 'v1', :append)
      ActiveOrm::Redis::List.create(:example, 'v2', :append)
      ActiveOrm::Redis::List.create(:example, 'v2', :append)
      ActiveOrm::Redis::List.create(:example, 'v2', :append)
      ActiveOrm::Redis::List.create(:example, 'v1', :append)

      ActiveOrm::Redis::List.destroy(:example, 1, 'v1')
      ActiveOrm::Redis::List.destroy(:example, -2, 'v2')

      expect(ActiveOrm::Redis::List.count(:example)).to eq(2)
    end
  end

  describe '.destroy_first' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::List.destroy_first(:example)).to eq(nil)
    end

    it 'to be ["two", "one"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 'two')
      ActiveOrm::Redis::List.create(:example, 'three')

      ActiveOrm::Redis::List.destroy_first(:example)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['two', 'one'])
    end

    it 'to be ["one"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 'two')
      ActiveOrm::Redis::List.create(:example, 'three')
      ActiveOrm::Redis::List.create(:example, 'four')

      ActiveOrm::Redis::List.destroy_first(:example, 3)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['one'])
    end
  end

  describe '.destroy_last' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::List.destroy_last(:example)).to eq(nil)
    end

    it 'to be ["three", "two"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 'two')
      ActiveOrm::Redis::List.create(:example, 'three')

      ActiveOrm::Redis::List.destroy_last(:example)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['three', 'two'])
    end

    it 'to be ["four"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 'two')
      ActiveOrm::Redis::List.create(:example, 'three')
      ActiveOrm::Redis::List.create(:example, 'four')

      ActiveOrm::Redis::List.destroy_last(:example, 3)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['four'])
    end
  end

  describe '.destroy_except' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::List.destroy_except(:example, 2, 3)).to eq(nil)
    end

    it 'to be ["three", "two"]' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 'two')
      ActiveOrm::Redis::List.create(:example, 'three')
      ActiveOrm::Redis::List.create(:example, 'four')

      ActiveOrm::Redis::List.destroy_except(:example, 2, 3)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['three', 'two'])
    end
  end

  describe '.destroy_all' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::List.destroy_all(:example)).to eq(nil)
    end

    it 'to be nil' do
      ActiveOrm::Redis::List.create(:example, 'one')
      ActiveOrm::Redis::List.create(:example, 'two')
      ActiveOrm::Redis::List.create(:example, 'three')

      ActiveOrm::Redis::List.destroy_all(:example)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(nil)
    end
  end

  describe '.pop' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::List.pop(:example)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate.pop(:example)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate(true).pop(:example)).to eq(nil)
      expect(ActiveOrm::Redis::List.evaluate(false).pop(:example)).to eq(nil)
    end

    it 'to be "one"' do
      ActiveOrm::Redis::List.create(:example, 'one', :append)
      ActiveOrm::Redis::List.create(:example, 'two', :append)
      ActiveOrm::Redis::List.create(:example, 'three', :append)

      expect(ActiveOrm::Redis::List.pop(:example)).to eq('one')
    end

    it 'to be 1' do
      ActiveOrm::Redis::List.create(:example, 1, :append)
      ActiveOrm::Redis::List.create(:example, 'two', :append)
      ActiveOrm::Redis::List.create(:example, '3', :append)

      expect(ActiveOrm::Redis::List.evaluate.pop(:example)).to eq(1)
    end

    it 'to be "three"' do
      ActiveOrm::Redis::List.create(:example, 'one', :append)
      ActiveOrm::Redis::List.create(:example, 'two', :append)
      ActiveOrm::Redis::List.create(:example, 'three', :append)

      expect(ActiveOrm::Redis::List.pop(:example, :append)).to eq('three')
    end

    it 'to be 3' do
      ActiveOrm::Redis::List.create(:example, 1, :append)
      ActiveOrm::Redis::List.create(:example, 'two', :append)
      ActiveOrm::Redis::List.create(:example, 3, :append)

      expect(ActiveOrm::Redis::List.evaluate(true).pop(:example, :append)).to eq(3)
    end

    it 'to be ["two", "three"]' do
      ActiveOrm::Redis::List.create(:example, 'one', :append)
      ActiveOrm::Redis::List.create(:example, 'two', :append)
      ActiveOrm::Redis::List.create(:example, 'three', :append)
      ActiveOrm::Redis::List.pop(:example)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['two', 'three'])
    end

    it 'to be ["two", 3]' do
      ActiveOrm::Redis::List.create(:example, 1, :append)
      ActiveOrm::Redis::List.create(:example, 'two', :append)
      ActiveOrm::Redis::List.create(:example, '3', :append)
      ActiveOrm::Redis::List.pop(:example)

      expect(ActiveOrm::Redis::List.evaluate.all(:example)).to eq(['two', 3])
    end

    it 'to be ["one", "two"]' do
      ActiveOrm::Redis::List.create(:example, 'one', :append)
      ActiveOrm::Redis::List.create(:example, 'two', :append)
      ActiveOrm::Redis::List.create(:example, 'three', :append)
      ActiveOrm::Redis::List.pop(:example, :append)

      expect(ActiveOrm::Redis::List.all(:example)).to eq(['one', 'two'])
    end

    it 'to be [1, "two"]' do
      ActiveOrm::Redis::List.create(:example, 1, :append)
      ActiveOrm::Redis::List.create(:example, 'two', :append)
      ActiveOrm::Redis::List.create(:example, '3', :append)
      ActiveOrm::Redis::List.pop(:example, :append)

      expect(ActiveOrm::Redis::List.evaluate.all(:example)).to eq([1, 'two'])
    end
  end

  describe '.pop_blocking' do
    # TODO
  end

end
