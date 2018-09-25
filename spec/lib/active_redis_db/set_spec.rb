# frozen_string_literal: true

require 'spec_helper'

describe ActiveRedisDB::Set do

  before(:each) do
    ActiveRedisDB::Connection.flush_all
  end

  describe '.find' do
    it 'to be nil' do
      expect(ActiveRedisDB::Set.find(:example)).to eq(nil)
      expect(ActiveRedisDB::Set.evaluate.find(:example)).to eq(nil)
      expect(ActiveRedisDB::Set.evaluate(true).find(:example)).to eq(nil)
      expect(ActiveRedisDB::Set.evaluate(false).find(:example)).to eq(nil)
    end

    it 'to be ["2", "1"]' do
      ActiveRedisDB::Set.create(:example, '1')
      ActiveRedisDB::Set.create(:example, 2)

      expect(ActiveRedisDB::Set.find(:example)).to eq(['2', '1'])
      expect(ActiveRedisDB::Set.evaluate(false).find(:example)).to eq(['2', '1'])
    end

    it 'to be [2, 1]' do
      ActiveRedisDB::Set.create(:example, '1')
      ActiveRedisDB::Set.create(:example, 2)

      expect(ActiveRedisDB::Set.evaluate.find(:example)).to eq([2, 1])
      expect(ActiveRedisDB::Set.evaluate(true).find(:example)).to eq([2, 1])
    end
  end

  describe '.combine' do
    it 'to be nil' do
      expect(ActiveRedisDB::Set.combine(:example, :example2)).to eq(nil)
      expect(ActiveRedisDB::Set.evaluate.combine(:example, :example2)).to eq(nil)
      expect(ActiveRedisDB::Set.evaluate(true).combine(:example, :example2)).to eq(nil)
      expect(ActiveRedisDB::Set.evaluate(false).combine(:example, :example2)).to eq(nil)
    end

    it 'to be ["1", "2", "4"]' do
      ActiveRedisDB::Set.create(:example, '1')
      ActiveRedisDB::Set.create(:example, 2)
      ActiveRedisDB::Set.create(:example2, '2')
      ActiveRedisDB::Set.create(:example2, 4)

      expect(ActiveRedisDB::Set.combine(:example, :example2)).to eq(['1', '2', '4'])
      expect(ActiveRedisDB::Set.evaluate(false).combine(:example, :example2)).to eq(['1', '2', '4'])
    end

    it 'to be [1, 2, 4]' do
      ActiveRedisDB::Set.create(:example, '1')
      ActiveRedisDB::Set.create(:example, 2)
      ActiveRedisDB::Set.create(:example2, '2')
      ActiveRedisDB::Set.create(:example2, 4)

      expect(ActiveRedisDB::Set.evaluate.combine(:example, :example2)).to eq([1, 2, 4])
      expect(ActiveRedisDB::Set.evaluate(true).combine(:example, :example2)).to eq([1, 2, 4])
    end
  end

  describe '.difference' do
    it 'to be nil' do
      expect(ActiveRedisDB::Set.difference(:example, :example2)).to eq(nil)
      expect(ActiveRedisDB::Set.evaluate.difference(:example, :example2)).to eq(nil)
      expect(ActiveRedisDB::Set.evaluate(true).difference(:example, :example2)).to eq(nil)
      expect(ActiveRedisDB::Set.evaluate(false).difference(:example, :example2)).to eq(nil)
    end

    it 'to be nil' do
      ActiveRedisDB::Set.create(:example, '1')
      ActiveRedisDB::Set.create(:example, 1)
      ActiveRedisDB::Set.create(:example2, '1')
      ActiveRedisDB::Set.create(:example2, 1)

      expect(ActiveRedisDB::Set.difference(:example, :example2)).to eq(nil)
      expect(ActiveRedisDB::Set.evaluate(false).difference(:example, :example2)).to eq(nil)
    end

    it 'to be ["1"]' do
      ActiveRedisDB::Set.create(:example, '1')
      ActiveRedisDB::Set.create(:example, 2)
      ActiveRedisDB::Set.create(:example2, '2')
      ActiveRedisDB::Set.create(:example2, 3)

      expect(ActiveRedisDB::Set.difference(:example, :example2)).to eq(['1'])
      expect(ActiveRedisDB::Set.evaluate(false).difference(:example, :example2)).to eq(['1'])
    end

    it 'to be ["3"]' do
      ActiveRedisDB::Set.create(:example, 1)
      ActiveRedisDB::Set.create(:example, 2)
      ActiveRedisDB::Set.create(:example2, '2')
      ActiveRedisDB::Set.create(:example2, '3')

      expect(ActiveRedisDB::Set.difference(:example2, :example)).to eq(['3'])
      expect(ActiveRedisDB::Set.evaluate(false).difference(:example2, :example)).to eq(['3'])
    end

    it 'to be [3]' do
      ActiveRedisDB::Set.create(:example, 1)
      ActiveRedisDB::Set.create(:example, 2)
      ActiveRedisDB::Set.create(:example2, '2')
      ActiveRedisDB::Set.create(:example2, '3')

      expect(ActiveRedisDB::Set.evaluate.difference(:example2, :example)).to eq([3])
      expect(ActiveRedisDB::Set.evaluate(true).difference(:example2, :example)).to eq([3])
    end
  end

  describe '.intersection' do
    it 'to be nil' do
      expect(ActiveRedisDB::Set.intersection(:example, :example2, :example3)).to eq(nil)
      expect(ActiveRedisDB::Set.evaluate.intersection(:example, :example2, :example3)).to eq(nil)
      expect(ActiveRedisDB::Set.evaluate(true).intersection(:example, :example2, :example3)).to eq(nil)
      expect(ActiveRedisDB::Set.evaluate(false).intersection(:example, :example2, :example3)).to eq(nil)
    end

    it 'to be nil' do
      ActiveRedisDB::Set.create(:example, '1')
      ActiveRedisDB::Set.create(:example, 2)
      ActiveRedisDB::Set.create(:example2, '3')
      ActiveRedisDB::Set.create(:example2, 4)
      ActiveRedisDB::Set.create(:example3, '5')
      ActiveRedisDB::Set.create(:example3, 6)

      expect(ActiveRedisDB::Set.intersection(:example, :example2, :example3)).to eq(nil)
      expect(ActiveRedisDB::Set.evaluate.intersection(:example, :example2, :example3)).to eq(nil)
      expect(ActiveRedisDB::Set.evaluate(true).intersection(:example, :example2, :example3)).to eq(nil)
      expect(ActiveRedisDB::Set.evaluate(false).intersection(:example, :example2, :example3)).to eq(nil)
    end

    it 'to be ["2"]' do
      ActiveRedisDB::Set.create(:example, '1')
      ActiveRedisDB::Set.create(:example, 2)
      ActiveRedisDB::Set.create(:example2, '2')
      ActiveRedisDB::Set.create(:example2, 3)
      ActiveRedisDB::Set.create(:example3, '2')
      ActiveRedisDB::Set.create(:example3, 4)

      expect(ActiveRedisDB::Set.intersection(:example, :example2, :example3)).to eq(['2'])
      expect(ActiveRedisDB::Set.evaluate(false).intersection(:example, :example2, :example3)).to eq(['2'])
    end

    it 'to be [2]' do
      ActiveRedisDB::Set.create(:example, '1')
      ActiveRedisDB::Set.create(:example, 2)
      ActiveRedisDB::Set.create(:example2, '2')
      ActiveRedisDB::Set.create(:example2, 3)
      ActiveRedisDB::Set.create(:example3, '2')
      ActiveRedisDB::Set.create(:example3, 4)

      expect(ActiveRedisDB::Set.evaluate.intersection(:example, :example2, :example3)).to eq([2])
      expect(ActiveRedisDB::Set.evaluate(true).intersection(:example, :example2, :example3)).to eq([2])
    end
  end

  describe '.sample' do
    it 'to be nil' do
      expect(ActiveRedisDB::Set.sample(:example)).to eq(nil)
      expect(ActiveRedisDB::Set.evaluate.sample(:example)).to eq(nil)
      expect(ActiveRedisDB::Set.evaluate(true).sample(:example)).to eq(nil)
      expect(ActiveRedisDB::Set.evaluate(false).sample(:example)).to eq(nil)
    end

    it 'to be ["1", "2", "4"]' do
      ActiveRedisDB::Set.create(:example, '1')
      ActiveRedisDB::Set.create(:example, 2)
      ActiveRedisDB::Set.create(:example2, '2')
      ActiveRedisDB::Set.create(:example2, 4)

      expect(ActiveRedisDB::Set.combine(:example, :example2)).to eq(['1', '2', '4'])
      expect(ActiveRedisDB::Set.evaluate(false).combine(:example, :example2)).to eq(['1', '2', '4'])
    end

    it 'to be [1, 2, 4]' do
      ActiveRedisDB::Set.create(:example, '1')
      ActiveRedisDB::Set.create(:example, 2)
      ActiveRedisDB::Set.create(:example2, '2')
      ActiveRedisDB::Set.create(:example2, 4)

      expect(ActiveRedisDB::Set.evaluate.combine(:example, :example2)).to eq([1, 2, 4])
      expect(ActiveRedisDB::Set.evaluate(true).combine(:example, :example2)).to eq([1, 2, 4])
    end
  end

  describe '.value?' do
    it 'to be true' do
      ActiveRedisDB::Set.create(:example, 'one')
      ActiveRedisDB::Set.create(:example, 'two')

      expect(ActiveRedisDB::Set.value?(:example, 'one')).to eq(true)
    end

    it 'to be false' do
      ActiveRedisDB::Set.create(:example, 'one')
      ActiveRedisDB::Set.create(:example, 'two')

      expect(ActiveRedisDB::Set.value?(:example, 'three')).to eq(false)
    end
  end

  describe '.count' do
    it 'to be 2' do
      ActiveRedisDB::Set.create(:example, 'one')
      ActiveRedisDB::Set.create(:example, 'two')

      expect(ActiveRedisDB::Set.count(:example)).to eq(2)
    end
  end

  describe '.create' do
    it 'to be ["one"]' do
      ActiveRedisDB::Set.create(:example, 'one')

      expect(ActiveRedisDB::Set.find(:example)).to eq(['one'])
    end

    it 'to be ["two", "one"]' do
      ActiveRedisDB::Set.create(:example, 'one', 'two')

      expect(ActiveRedisDB::Set.find(:example)).to eq(['two', 'one'])
    end
  end

  describe '.create_differenece' do
    it 'to be ["one"]' do
      ActiveRedisDB::Set.create(:example1, 'one')
      ActiveRedisDB::Set.create(:example1, 'two')
      ActiveRedisDB::Set.create(:example2, 'two')
      ActiveRedisDB::Set.create(:example2, 'three')
      ActiveRedisDB::Set.create_difference(:example3, :example1, :example2)

      expect(ActiveRedisDB::Set.find(:example3)).to eq(['one'])
    end
  end

  describe '.create_intersection' do
    it 'to be ["two"]' do
      ActiveRedisDB::Set.create(:example1, 'one')
      ActiveRedisDB::Set.create(:example1, 'two')
      ActiveRedisDB::Set.create(:example2, 'two')
      ActiveRedisDB::Set.create(:example2, 'three')
      ActiveRedisDB::Set.create(:example3, 'two')
      ActiveRedisDB::Set.create(:example3, 'four')
      ActiveRedisDB::Set.create_intersection(:example4, :example1, :example2, :example3)

      expect(ActiveRedisDB::Set.find(:example4)).to eq(['two'])
    end
  end

  describe '.create_combination' do
    it 'to be ["four", "three", "two", "one"]' do
      ActiveRedisDB::Set.create(:example1, 'one')
      ActiveRedisDB::Set.create(:example1, 'two')
      ActiveRedisDB::Set.create(:example2, 'two')
      ActiveRedisDB::Set.create(:example2, 'three')
      ActiveRedisDB::Set.create(:example3, 'two')
      ActiveRedisDB::Set.create(:example3, 'four')
      ActiveRedisDB::Set.create_combination(:example4, :example1, :example2, :example3)

      expect(ActiveRedisDB::Set.find(:example4)).to eq(['four', 'three', 'two', 'one'])
    end
  end

  describe '.move' do
    it 'to be "three"' do
      ActiveRedisDB::Set.create(:example, 'one')
      ActiveRedisDB::Set.create(:example, 'two')
      ActiveRedisDB::Set.create(:example2, 'three')
      ActiveRedisDB::Set.create(:example2, 'four')
      ActiveRedisDB::Set.move(:example2, :example, 'four')

      expect(ActiveRedisDB::Set.find(:example2)).to eq(['three'])
    end
  end

  describe '.destroy' do
    it 'to be ["three", "one"]' do
      ActiveRedisDB::Set.create(:example, 'one')
      ActiveRedisDB::Set.create(:example, 'two')
      ActiveRedisDB::Set.create(:example, 'three')
      ActiveRedisDB::Set.destroy(:example, 'two')

      expect(ActiveRedisDB::Set.find(:example)).to eq(['three', 'one'])
    end

    it 'to be ["two"]' do
      ActiveRedisDB::Set.create(:example, 'one')
      ActiveRedisDB::Set.create(:example, 'two')
      ActiveRedisDB::Set.create(:example, 'three')
      ActiveRedisDB::Set.destroy(:example, ['three', 'one'])

      expect(ActiveRedisDB::Set.find(:example)).to eq(['two'])
    end
  end

  describe '.scan' do
    # TODO
  end

end
