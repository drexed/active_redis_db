# frozen_string_literal: true

require 'spec_helper'

describe ActiveOrm::Redis::Set do

  before(:each) do
    ActiveOrm::Redis::Connection.flush_all
  end

  describe '.find' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::Set.find(:example)).to eq(nil)
      expect(ActiveOrm::Redis::Set.evaluate.find(:example)).to eq(nil)
      expect(ActiveOrm::Redis::Set.evaluate(true).find(:example)).to eq(nil)
      expect(ActiveOrm::Redis::Set.evaluate(false).find(:example)).to eq(nil)
    end

    it 'to be ["2", "1"]' do
      ActiveOrm::Redis::Set.create(:example, '1')
      ActiveOrm::Redis::Set.create(:example, 2)

      expect(ActiveOrm::Redis::Set.find(:example)).to eq(['2', '1'])
      expect(ActiveOrm::Redis::Set.evaluate(false).find(:example)).to eq(['2', '1'])
    end

    it 'to be [2, 1]' do
      ActiveOrm::Redis::Set.create(:example, '1')
      ActiveOrm::Redis::Set.create(:example, 2)

      expect(ActiveOrm::Redis::Set.evaluate.find(:example)).to eq([2, 1])
      expect(ActiveOrm::Redis::Set.evaluate(true).find(:example)).to eq([2, 1])
    end
  end

  describe '.combine' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::Set.combine(:example, :example2)).to eq(nil)
      expect(ActiveOrm::Redis::Set.evaluate.combine(:example, :example2)).to eq(nil)
      expect(ActiveOrm::Redis::Set.evaluate(true).combine(:example, :example2)).to eq(nil)
      expect(ActiveOrm::Redis::Set.evaluate(false).combine(:example, :example2)).to eq(nil)
    end

    it 'to be ["1", "2", "4"]' do
      ActiveOrm::Redis::Set.create(:example, '1')
      ActiveOrm::Redis::Set.create(:example, 2)
      ActiveOrm::Redis::Set.create(:example2, '2')
      ActiveOrm::Redis::Set.create(:example2, 4)

      expect(ActiveOrm::Redis::Set.combine(:example, :example2)).to eq(['1', '2', '4'])
      expect(ActiveOrm::Redis::Set.evaluate(false).combine(:example, :example2)).to eq(['1', '2', '4'])
    end

    it 'to be [1, 2, 4]' do
      ActiveOrm::Redis::Set.create(:example, '1')
      ActiveOrm::Redis::Set.create(:example, 2)
      ActiveOrm::Redis::Set.create(:example2, '2')
      ActiveOrm::Redis::Set.create(:example2, 4)

      expect(ActiveOrm::Redis::Set.evaluate.combine(:example, :example2)).to eq([1, 2, 4])
      expect(ActiveOrm::Redis::Set.evaluate(true).combine(:example, :example2)).to eq([1, 2, 4])
    end
  end

  describe '.difference' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::Set.difference(:example, :example2)).to eq(nil)
      expect(ActiveOrm::Redis::Set.evaluate.difference(:example, :example2)).to eq(nil)
      expect(ActiveOrm::Redis::Set.evaluate(true).difference(:example, :example2)).to eq(nil)
      expect(ActiveOrm::Redis::Set.evaluate(false).difference(:example, :example2)).to eq(nil)
    end

    it 'to be nil' do
      ActiveOrm::Redis::Set.create(:example, '1')
      ActiveOrm::Redis::Set.create(:example, 1)
      ActiveOrm::Redis::Set.create(:example2, '1')
      ActiveOrm::Redis::Set.create(:example2, 1)

      expect(ActiveOrm::Redis::Set.difference(:example, :example2)).to eq(nil)
      expect(ActiveOrm::Redis::Set.evaluate(false).difference(:example, :example2)).to eq(nil)
    end

    it 'to be ["1"]' do
      ActiveOrm::Redis::Set.create(:example, '1')
      ActiveOrm::Redis::Set.create(:example, 2)
      ActiveOrm::Redis::Set.create(:example2, '2')
      ActiveOrm::Redis::Set.create(:example2, 3)

      expect(ActiveOrm::Redis::Set.difference(:example, :example2)).to eq(['1'])
      expect(ActiveOrm::Redis::Set.evaluate(false).difference(:example, :example2)).to eq(['1'])
    end

    it 'to be ["3"]' do
      ActiveOrm::Redis::Set.create(:example, 1)
      ActiveOrm::Redis::Set.create(:example, 2)
      ActiveOrm::Redis::Set.create(:example2, '2')
      ActiveOrm::Redis::Set.create(:example2, '3')

      expect(ActiveOrm::Redis::Set.difference(:example2, :example)).to eq(['3'])
      expect(ActiveOrm::Redis::Set.evaluate(false).difference(:example2, :example)).to eq(['3'])
    end

    it 'to be [3]' do
      ActiveOrm::Redis::Set.create(:example, 1)
      ActiveOrm::Redis::Set.create(:example, 2)
      ActiveOrm::Redis::Set.create(:example2, '2')
      ActiveOrm::Redis::Set.create(:example2, '3')

      expect(ActiveOrm::Redis::Set.evaluate.difference(:example2, :example)).to eq([3])
      expect(ActiveOrm::Redis::Set.evaluate(true).difference(:example2, :example)).to eq([3])
    end
  end

  describe '.intersection' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::Set.intersection(:example, :example2, :example3)).to eq(nil)
      expect(ActiveOrm::Redis::Set.evaluate.intersection(:example, :example2, :example3)).to eq(nil)
      expect(ActiveOrm::Redis::Set.evaluate(true).intersection(:example, :example2, :example3)).to eq(nil)
      expect(ActiveOrm::Redis::Set.evaluate(false).intersection(:example, :example2, :example3)).to eq(nil)
    end

    it 'to be nil' do
      ActiveOrm::Redis::Set.create(:example, '1')
      ActiveOrm::Redis::Set.create(:example, 2)
      ActiveOrm::Redis::Set.create(:example2, '3')
      ActiveOrm::Redis::Set.create(:example2, 4)
      ActiveOrm::Redis::Set.create(:example3, '5')
      ActiveOrm::Redis::Set.create(:example3, 6)

      expect(ActiveOrm::Redis::Set.intersection(:example, :example2, :example3)).to eq(nil)
      expect(ActiveOrm::Redis::Set.evaluate.intersection(:example, :example2, :example3)).to eq(nil)
      expect(ActiveOrm::Redis::Set.evaluate(true).intersection(:example, :example2, :example3)).to eq(nil)
      expect(ActiveOrm::Redis::Set.evaluate(false).intersection(:example, :example2, :example3)).to eq(nil)
    end

    it 'to be ["2"]' do
      ActiveOrm::Redis::Set.create(:example, '1')
      ActiveOrm::Redis::Set.create(:example, 2)
      ActiveOrm::Redis::Set.create(:example2, '2')
      ActiveOrm::Redis::Set.create(:example2, 3)
      ActiveOrm::Redis::Set.create(:example3, '2')
      ActiveOrm::Redis::Set.create(:example3, 4)

      expect(ActiveOrm::Redis::Set.intersection(:example, :example2, :example3)).to eq(['2'])
      expect(ActiveOrm::Redis::Set.evaluate(false).intersection(:example, :example2, :example3)).to eq(['2'])
    end

    it 'to be [2]' do
      ActiveOrm::Redis::Set.create(:example, '1')
      ActiveOrm::Redis::Set.create(:example, 2)
      ActiveOrm::Redis::Set.create(:example2, '2')
      ActiveOrm::Redis::Set.create(:example2, 3)
      ActiveOrm::Redis::Set.create(:example3, '2')
      ActiveOrm::Redis::Set.create(:example3, 4)

      expect(ActiveOrm::Redis::Set.evaluate.intersection(:example, :example2, :example3)).to eq([2])
      expect(ActiveOrm::Redis::Set.evaluate(true).intersection(:example, :example2, :example3)).to eq([2])
    end
  end

  describe '.sample' do
    it 'to be nil' do
      expect(ActiveOrm::Redis::Set.sample(:example)).to eq(nil)
      expect(ActiveOrm::Redis::Set.evaluate.sample(:example)).to eq(nil)
      expect(ActiveOrm::Redis::Set.evaluate(true).sample(:example)).to eq(nil)
      expect(ActiveOrm::Redis::Set.evaluate(false).sample(:example)).to eq(nil)
    end

    it 'to be ["1", "2", "4"]' do
      ActiveOrm::Redis::Set.create(:example, '1')
      ActiveOrm::Redis::Set.create(:example, 2)
      ActiveOrm::Redis::Set.create(:example2, '2')
      ActiveOrm::Redis::Set.create(:example2, 4)

      expect(ActiveOrm::Redis::Set.combine(:example, :example2)).to eq(['1', '2', '4'])
      expect(ActiveOrm::Redis::Set.evaluate(false).combine(:example, :example2)).to eq(['1', '2', '4'])
    end

    it 'to be [1, 2, 4]' do
      ActiveOrm::Redis::Set.create(:example, '1')
      ActiveOrm::Redis::Set.create(:example, 2)
      ActiveOrm::Redis::Set.create(:example2, '2')
      ActiveOrm::Redis::Set.create(:example2, 4)

      expect(ActiveOrm::Redis::Set.evaluate.combine(:example, :example2)).to eq([1, 2, 4])
      expect(ActiveOrm::Redis::Set.evaluate(true).combine(:example, :example2)).to eq([1, 2, 4])
    end
  end

  describe '.value?' do
    it 'to be true' do
      ActiveOrm::Redis::Set.create(:example, 'one')
      ActiveOrm::Redis::Set.create(:example, 'two')

      expect(ActiveOrm::Redis::Set.value?(:example, 'one')).to eq(true)
    end

    it 'to be false' do
      ActiveOrm::Redis::Set.create(:example, 'one')
      ActiveOrm::Redis::Set.create(:example, 'two')

      expect(ActiveOrm::Redis::Set.value?(:example, 'three')).to eq(false)
    end
  end

  describe '.count' do
    it 'to be 2' do
      ActiveOrm::Redis::Set.create(:example, 'one')
      ActiveOrm::Redis::Set.create(:example, 'two')

      expect(ActiveOrm::Redis::Set.count(:example)).to eq(2)
    end
  end

  describe '.create' do
    it 'to be ["one"]' do
      ActiveOrm::Redis::Set.create(:example, 'one')

      expect(ActiveOrm::Redis::Set.find(:example)).to eq(['one'])
    end

    it 'to be ["two", "one"]' do
      ActiveOrm::Redis::Set.create(:example, 'one', 'two')

      expect(ActiveOrm::Redis::Set.find(:example)).to eq(['two', 'one'])
    end
  end

  describe '.create_differenece' do
    it 'to be ["one"]' do
      ActiveOrm::Redis::Set.create(:example1, 'one')
      ActiveOrm::Redis::Set.create(:example1, 'two')
      ActiveOrm::Redis::Set.create(:example2, 'two')
      ActiveOrm::Redis::Set.create(:example2, 'three')
      ActiveOrm::Redis::Set.create_difference(:example3, :example1, :example2)

      expect(ActiveOrm::Redis::Set.find(:example3)).to eq(['one'])
    end
  end

  describe '.create_intersection' do
    it 'to be ["two"]' do
      ActiveOrm::Redis::Set.create(:example1, 'one')
      ActiveOrm::Redis::Set.create(:example1, 'two')
      ActiveOrm::Redis::Set.create(:example2, 'two')
      ActiveOrm::Redis::Set.create(:example2, 'three')
      ActiveOrm::Redis::Set.create(:example3, 'two')
      ActiveOrm::Redis::Set.create(:example3, 'four')
      ActiveOrm::Redis::Set.create_intersection(:example4, :example1, :example2, :example3)

      expect(ActiveOrm::Redis::Set.find(:example4)).to eq(['two'])
    end
  end

  describe '.create_combination' do
    it 'to be ["four", "three", "two", "one"]' do
      ActiveOrm::Redis::Set.create(:example1, 'one')
      ActiveOrm::Redis::Set.create(:example1, 'two')
      ActiveOrm::Redis::Set.create(:example2, 'two')
      ActiveOrm::Redis::Set.create(:example2, 'three')
      ActiveOrm::Redis::Set.create(:example3, 'two')
      ActiveOrm::Redis::Set.create(:example3, 'four')
      ActiveOrm::Redis::Set.create_combination(:example4, :example1, :example2, :example3)

      expect(ActiveOrm::Redis::Set.find(:example4)).to eq(['four', 'three', 'two', 'one'])
    end
  end

  describe '.move' do
    it 'to be "three"' do
      ActiveOrm::Redis::Set.create(:example, 'one')
      ActiveOrm::Redis::Set.create(:example, 'two')
      ActiveOrm::Redis::Set.create(:example2, 'three')
      ActiveOrm::Redis::Set.create(:example2, 'four')
      ActiveOrm::Redis::Set.move(:example2, :example, 'four')

      expect(ActiveOrm::Redis::Set.find(:example2)).to eq(['three'])
    end
  end

  describe '.destroy' do
    it 'to be ["three", "one"]' do
      ActiveOrm::Redis::Set.create(:example, 'one')
      ActiveOrm::Redis::Set.create(:example, 'two')
      ActiveOrm::Redis::Set.create(:example, 'three')
      ActiveOrm::Redis::Set.destroy(:example, 'two')

      expect(ActiveOrm::Redis::Set.find(:example)).to eq(['three', 'one'])
    end

    it 'to be ["two"]' do
      ActiveOrm::Redis::Set.create(:example, 'one')
      ActiveOrm::Redis::Set.create(:example, 'two')
      ActiveOrm::Redis::Set.create(:example, 'three')
      ActiveOrm::Redis::Set.destroy(:example, ['three', 'one'])

      expect(ActiveOrm::Redis::Set.find(:example)).to eq(['two'])
    end
  end

  describe '.scan' do
    # TODO
  end

end
