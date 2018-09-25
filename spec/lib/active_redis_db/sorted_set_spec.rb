# frozen_string_literal: true

require 'spec_helper'

describe ActiveRedisDB::SortedSet do

  before(:each) do
    ActiveRedisDB::Connection.flush_all
  end

  describe '.find' do
    it 'to be nil' do
      expect(ActiveRedisDB::SortedSet.find(:example, 1)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate.find(:example, 1)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(true).find(:example, 1)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(false).find(:example, 1)).to eq(nil)
    end

    it 'to be "two"' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.find(:example, 2)).to eq('two')
      expect(ActiveRedisDB::SortedSet.evaluate(false).find(:example, 2)).to eq('two')
    end

    it 'to be 3' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.evaluate.find(:example, 3)).to eq(3)
      expect(ActiveRedisDB::SortedSet.evaluate(true).find(:example, 3)).to eq(3)
    end

    it 'should return ["1", 1.0]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.find(:example, 1, with_scores: true)).to eq(['1', 1.0])
      expect(ActiveRedisDB::SortedSet.evaluate(false).find(:example, 1, with_scores: true)).to eq(['1', 1.0])
    end

    it 'should return [1, 1.0]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.evaluate.find(:example, 1, with_scores: true)).to eq([1, 1.0])
      expect(ActiveRedisDB::SortedSet.evaluate(true).find(:example, 1, with_scores: true)).to eq([1, 1.0])
    end
  end

  describe '.find_score' do
    it 'to be nil' do
      expect(ActiveRedisDB::SortedSet.find_score(:example, 1)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate.find_score(:example, 1)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(true).find_score(:example, 1)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(false).find_score(:example, 1)).to eq(nil)
    end

    it 'to be "two"' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.find_score(:example, 2)).to eq('2')
      expect(ActiveRedisDB::SortedSet.evaluate(false).find_score(:example, 2)).to eq('2')
    end

    it 'to be 2' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.evaluate.find_score(:example, 2)).to eq(2)
      expect(ActiveRedisDB::SortedSet.evaluate(true).find_score(:example, 2)).to eq(2)
    end

    it 'should return ["1", 1.0]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.find_score(:example, 1, with_scores: true)).to eq(['one', 1.0])
      expect(ActiveRedisDB::SortedSet.evaluate(false).find_score(:example, 1, with_scores: true)).to eq(['one', 1.0])
    end

    it 'should return [1, 1.0]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.evaluate.find_score(:example, 2, with_scores: true)).to eq([2, 2.0])
      expect(ActiveRedisDB::SortedSet.evaluate(true).find_score(:example, 2, with_scores: true)).to eq([2, 2.0])
    end
  end

  describe '.first' do
    it 'to be nil' do
      expect(ActiveRedisDB::SortedSet.first(:example)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate.first(:example)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(true).first(:example)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(false).first(:example)).to eq(nil)
    end

    it 'to be "1"' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.first(:example)).to eq('1')
      expect(ActiveRedisDB::SortedSet.evaluate(false).first(:example)).to eq('1')
    end

    it 'to be 1' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.evaluate.first(:example)).to eq(1)
      expect(ActiveRedisDB::SortedSet.evaluate(true).first(:example)).to eq(1)
    end

    it 'should return ["1", 1.0]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.first(:example, with_scores: true)).to eq(['1', 1.0])
      expect(ActiveRedisDB::SortedSet.evaluate(false).first(:example, with_scores: true)).to eq(['1', 1.0])
    end

    it 'should return [1, 1.0]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.evaluate.first(:example, with_scores: true)).to eq([1, 1.0])
      expect(ActiveRedisDB::SortedSet.evaluate(true).first(:example, with_scores: true)).to eq([1, 1.0])
    end
  end

  describe '.first_score' do
    it 'to be nil' do
      expect(ActiveRedisDB::SortedSet.first_score(:example)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate.first_score(:example)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(true).first_score(:example)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(false).first_score(:example)).to eq(nil)
    end

    it 'to be "1"' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.first_score(:example)).to eq('1')
      expect(ActiveRedisDB::SortedSet.evaluate(false).first_score(:example)).to eq('1')
    end

    it 'to be 1' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.evaluate.first_score(:example)).to eq(1)
      expect(ActiveRedisDB::SortedSet.evaluate(true).first_score(:example)).to eq(1)
    end

    it 'should return ["1", 1.0]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.first_score(:example, with_scores: true)).to eq(['1', 1.0])
      expect(ActiveRedisDB::SortedSet.evaluate(false).first_score(:example, with_scores: true)).to eq(['1', 1.0])
    end

    it 'should return [1, 1.0]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.evaluate.first_score(:example, with_scores: true)).to eq([1, 1.0])
      expect(ActiveRedisDB::SortedSet.evaluate(true).first_score(:example, with_scores: true)).to eq([1, 1.0])
    end
  end

  describe '.last' do
    it 'to be nil' do
      expect(ActiveRedisDB::SortedSet.last(:example)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate.last(:example)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(true).last(:example)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(false).last(:example)).to eq(nil)
    end

    it 'to be "3"' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.last(:example)).to eq('3')
      expect(ActiveRedisDB::SortedSet.evaluate(false).last(:example)).to eq('3')
    end

    it 'to be 3' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.evaluate.last(:example)).to eq(3)
      expect(ActiveRedisDB::SortedSet.evaluate(true).last(:example)).to eq(3)
    end

    it 'should return ["3", 3.0]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.last(:example, with_scores: true)).to eq(['3', 3.0])
      expect(ActiveRedisDB::SortedSet.evaluate(false).last(:example, with_scores: true)).to eq(['3', 3.0])
    end

    it 'should return [3, 3.0]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.evaluate.last(:example, with_scores: true)).to eq([3, 3.0])
      expect(ActiveRedisDB::SortedSet.evaluate(true).last(:example, with_scores: true)).to eq([3, 3.0])
    end
  end

  describe '.last_score' do
    it 'to be nil' do
      expect(ActiveRedisDB::SortedSet.last_score(:example)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate.last_score(:example)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(true).last_score(:example)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(false).last_score(:example)).to eq(nil)
    end

    it 'to be "1"' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.last_score(:example)).to eq('1')
      expect(ActiveRedisDB::SortedSet.evaluate(false).last_score(:example)).to eq('1')
    end

    it 'to be 1' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.evaluate.last_score(:example)).to eq(1)
      expect(ActiveRedisDB::SortedSet.evaluate(true).last_score(:example)).to eq(1)
    end

    it 'should return ["1", 1.0]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.last_score(:example, with_scores: true)).to eq(['1', 1.0])
      expect(ActiveRedisDB::SortedSet.evaluate(false).last_score(:example, with_scores: true)).to eq(['1', 1.0])
    end

    it 'should return [1, 1.0]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(ActiveRedisDB::SortedSet.evaluate.last_score(:example, with_scores: true)).to eq([1, 1.0])
      expect(ActiveRedisDB::SortedSet.evaluate(true).last_score(:example, with_scores: true)).to eq([1, 1.0])
    end
  end

  describe '.between' do
    it 'to be nil' do
      expect(ActiveRedisDB::SortedSet.between(:example, 1, 2)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate.between(:example, 1, 2)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(true).between(:example, 1, 2)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(false).between(:example, 1, 2)).to eq(nil)
    end

    it 'to be ["one", "two"]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, 'two', 3, 'three')

      expect(ActiveRedisDB::SortedSet.between(:example, 1, 2)).to eq(['one', 'two'])
      expect(ActiveRedisDB::SortedSet.evaluate(false).between(:example, 1, 2)).to eq(['one', 'two'])
    end

    it 'to be [1, 2]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, '2', 3, '3')

      expect(ActiveRedisDB::SortedSet.evaluate.between(:example, 1, 2)).to eq([1, 2])
      expect(ActiveRedisDB::SortedSet.evaluate(true).between(:example, 1, 2)).to eq([1, 2])
    end

    it 'should return [["one", 1.0], ["2", 2.0]]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.between(:example, 1, 2, with_scores: true)).to eq([['one', 1.0], ['2', 2.0]])
      expect(ActiveRedisDB::SortedSet.evaluate(false).between(:example, 1, 2, with_scores: true)).to eq([['one', 1.0], ['2', 2.0]])
    end

    it 'should return [["one", 1.0], [2, 2.0]]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.evaluate.between(:example, 1, 2, with_scores: true)).to eq([['one', 1.0], [2, 2.0]])
      expect(ActiveRedisDB::SortedSet.evaluate(true).between(:example, 1, 2, with_scores: true)).to eq([['one', 1.0], [2, 2.0]])
    end
  end

  describe '.between_reverse' do
    it 'to be nil' do
      expect(ActiveRedisDB::SortedSet.between_reverse(:example, 1, 2)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate.between_reverse(:example, 1, 2)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(true).between_reverse(:example, 1, 2)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(false).between_reverse(:example, 1, 2)).to eq(nil)
    end

    it 'to be ["three", "two"]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, 'two', 3, 'three')

      expect(ActiveRedisDB::SortedSet.between_reverse(:example, 1, 2)).to eq(['three', 'two'])
      expect(ActiveRedisDB::SortedSet.evaluate(false).between_reverse(:example, 1, 2)).to eq(['three', 'two'])
    end

    it 'to be [3, 2]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 1, 2, '2', 3, '3')

      expect(ActiveRedisDB::SortedSet.evaluate.between_reverse(:example, 1, 2)).to eq([3, 2])
      expect(ActiveRedisDB::SortedSet.evaluate(true).between_reverse(:example, 1, 2)).to eq([3, 2])
    end

    it 'should return [["three", 3.0], ["2", 2.0]]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.between_reverse(:example, 1, 2, with_scores: true)).to eq([['three', 3.0], ['2', 2.0]])
      expect(ActiveRedisDB::SortedSet.evaluate(false).between_reverse(:example, 1, 2, with_scores: true)).to eq([['three', 3.0], ['2', 2.0]])
    end

    it 'should return [["three", 3.0], [2, 2.0]]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.evaluate.between_reverse(:example, 1, 2, with_scores: true)).to eq([['three', 3.0], [2, 2.0]])
      expect(ActiveRedisDB::SortedSet.evaluate(true).between_reverse(:example, 1, 2, with_scores: true)).to eq([['three', 3.0], [2, 2.0]])
    end
  end

  describe '.between_scores' do
    it 'to be nil' do
      expect(ActiveRedisDB::SortedSet.between_scores(:example, 1, 2)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate.between_scores(:example, 1, 2)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(true).between_scores(:example, 1, 2)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(false).between_scores(:example, 1, 2)).to eq(nil)
    end

    it 'to be nil' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.between_scores(:example, 100, 1)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(false).between_scores(:example, 100, 1)).to eq(nil)
    end

    it 'to be ["one", "2", "three"]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.between_scores(:example, 1, 100)).to eq(['one', '2', 'three'])
      expect(ActiveRedisDB::SortedSet.evaluate(false).between_scores(:example, 1, 100)).to eq(['one', '2', 'three'])
    end

    it 'to be ["one", 2, "three"]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.evaluate.between_scores(:example, 1, 100)).to eq(['one', 2, 'three'])
      expect(ActiveRedisDB::SortedSet.evaluate(true).between_scores(:example, 1, 100)).to eq(['one', 2, 'three'])
    end

    it 'to be ["one", "2"]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.between_scores(:example, 1, 2)).to eq(['one', '2'])
      expect(ActiveRedisDB::SortedSet.evaluate(false).between_scores(:example, 1, 2)).to eq(['one', '2'])
    end

    it 'to be ["one", 2]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.evaluate.between_scores(:example, 1, 2)).to eq(['one', 2])
      expect(ActiveRedisDB::SortedSet.evaluate(true).between_scores(:example, 1, 2)).to eq(['one', 2])
    end

    it 'should return [["one", 1.0], ["2", 2.0]]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.between_scores(:example, 1, 2, with_scores: true)).to eq([['one', 1.0], ['2', 2.0]])
      expect(ActiveRedisDB::SortedSet.evaluate(false).between_scores(:example, 1, 2, with_scores: true)).to eq([['one', 1.0], ['2', 2.0]])
    end

    it 'should return [["one", 1.0], [2, 2.0]]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.evaluate.between_scores(:example, 1, 2, with_scores: true)).to eq([['one', 1.0], [2, 2.0]])
      expect(ActiveRedisDB::SortedSet.evaluate(true).between_scores(:example, 1, 2, with_scores: true)).to eq([['one', 1.0], [2, 2.0]])
    end
  end

  describe '.between_scores_reverse' do
    it 'to be nil' do
      expect(ActiveRedisDB::SortedSet.between_scores_reverse(:example, 1, 2)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate.between_scores_reverse(:example, 1, 2)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(true).between_scores_reverse(:example, 1, 2)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(false).between_scores_reverse(:example, 1, 2)).to eq(nil)
    end

    it 'to be nil' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.between_scores_reverse(:example, 1, 100)).to eq(nil)
      expect(ActiveRedisDB::SortedSet.evaluate(false).between_scores_reverse(:example, 1, 100)).to eq(nil)
    end

    it 'to be ["three", "2", "one"]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.between_scores_reverse(:example, 100, 1)).to eq(['three', '2', 'one'])
      expect(ActiveRedisDB::SortedSet.evaluate(false).between_scores_reverse(:example, 100, 1)).to eq(['three', '2', 'one'])
    end

    it 'to be ["three", 2, "one"]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.evaluate.between_scores_reverse(:example, 100, 1)).to eq(['three', 2, 'one'])
      expect(ActiveRedisDB::SortedSet.evaluate(true).between_scores_reverse(:example, 100, 1)).to eq(['three', 2, 'one'])
    end

    it 'to be ["2", "one"]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.between_scores_reverse(:example, 2, 1)).to eq(['2', 'one'])
      expect(ActiveRedisDB::SortedSet.evaluate(false).between_scores_reverse(:example, 2, 1)).to eq(['2', 'one'])
    end

    it 'to be [2, "one"]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.evaluate.between_scores_reverse(:example, 2, 1)).to eq([2, 'one'])
      expect(ActiveRedisDB::SortedSet.evaluate(true).between_scores_reverse(:example, 2, 1)).to eq([2, 'one'])
    end

    it 'should return [["2", 2.0], ["one", 1.0]]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.between_scores_reverse(:example, 2, 1, with_scores: true)).to eq([['2', 2.0], ['one', 1.0]])
      expect(ActiveRedisDB::SortedSet.evaluate(false).between_scores_reverse(:example, 2, 1, with_scores: true)).to eq([['2', 2.0], ['one', 1.0]])
    end

    it 'should return [[2, 2.0], ["one", 2]]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.evaluate.between_scores_reverse(:example, 2, 1, with_scores: true)).to eq([[2, 2.0], ['one', 1.0]])
      expect(ActiveRedisDB::SortedSet.evaluate(true).between_scores_reverse(:example, 2, 1, with_scores: true)).to eq([[2, 2.0], ['one', 1.0]])
    end
  end

  describe '.between_lex' do
    # TODO
  end
  describe '.between_lex_reverse' do
    # TODO
  end

  describe '.all' do
    it 'to be ["one", "2", "three"]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.all(:example)).to eq(%w[one 2 three])
    end

    it 'to be [["one", 1.0], ["2", 2.0], ["three", 3.0]]' do
      array = [["one", 1.0], ["2", 2.0], ["three", 3.0]]
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.all(:example, with_scores: true)).to eq(array)
    end
  end

  describe '.all_reverse' do
    it 'to be ["three", "2", "one"]' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.all_reverse(:example)).to eq(%w[three 2 one])
    end

    it 'to be [["three", 3.0], ["2", 2.0], ["one", 1.0]]' do
      array = [["three", 3.0], ["2", 2.0], ["one", 1.0]]
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.all_reverse(:example, with_scores: true)).to eq(array)
    end
  end

  describe '.position' do
    it 'to be nil' do
      expect(ActiveRedisDB::SortedSet.position(:example, 'one')).to eq(nil)
    end

    it 'to be nil' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.position(:example, 'four')).to eq(nil)
    end

    it 'to be 3' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.position(:example, 'three')).to eq(3)
    end
  end

  describe '.position_reverse' do
    it 'to be nil' do
      expect(ActiveRedisDB::SortedSet.position_reverse(:example, 'one')).to eq(nil)
    end

    it 'to be nil' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.position_reverse(:example, 'four')).to eq(nil)
    end

    it 'to be 3' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.position_reverse(:example, 'three')).to eq(1)
    end
  end

  describe '.score' do
    it 'to be nil' do
      expect(ActiveRedisDB::SortedSet.score(:example, 'one')).to eq(nil)
    end

    it 'to be nil' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.score(:example, 'four')).to eq(nil)
    end

    it 'to be 3' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.score(:example, 'three')).to eq(3.0)
    end
  end

  describe '.count' do
    it 'to be 0' do
      expect(ActiveRedisDB::SortedSet.count(:example)).to eq(0)
    end

    it 'to be 3' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.count(:example)).to eq(3)
    end
  end

  describe '.count_between' do
    it 'to be 0' do
      expect(ActiveRedisDB::SortedSet.count_between(:example, 2, 3)).to eq(0)
    end

    it 'to be 2' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(ActiveRedisDB::SortedSet.count_between(:example, 2, 3)).to eq(2)
    end
  end

  describe '.create' do
    it 'to be 2' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one')

      expect(ActiveRedisDB::SortedSet.between(:example, 1, 1)).to eq(['one'])
    end
  end

  describe '.create_intersection' do
    # TODO
  end

  describe '.create_combination' do
    # TODO
  end

  describe '.increment' do
    it 'to be 3' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one')

      expect(ActiveRedisDB::SortedSet.increment(:example, 'one', 2)).to eq(3)
      expect(ActiveRedisDB::SortedSet.score(:example, 'one')).to eq(3)
    end
  end

  describe '.decrement' do
    it 'to be -1' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one')

      expect(ActiveRedisDB::SortedSet.decrement(:example, 'one', 2)).to eq(-1)
      expect(ActiveRedisDB::SortedSet.score(:example, 'one')).to eq(-1)
    end
  end

  describe '.destroy' do
    it 'to be 2' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one')
      ActiveRedisDB::SortedSet.create(:example, 2, 'two')
      ActiveRedisDB::SortedSet.create(:example, 3, 'three')

      expect(ActiveRedisDB::SortedSet.destroy(:example, 'two')).to eq(true)
      expect(ActiveRedisDB::SortedSet.find(:example, 2)).to eq('three')
    end
  end

  describe '.destroy_between' do
    it 'to be 0' do
      expect(ActiveRedisDB::SortedSet.destroy_between(:example, 1, 2)).to eq(0)
    end

    it 'to be 2' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one')
      ActiveRedisDB::SortedSet.create(:example, 2, 'two')
      ActiveRedisDB::SortedSet.create(:example, 3, 'three')

      expect(ActiveRedisDB::SortedSet.destroy_between(:example, 1, 2)).to eq(2)
      expect(ActiveRedisDB::SortedSet.count(:example)).to eq(1)
    end
  end

  describe '.destroy_scores' do
    it 'to be 0' do
      expect(ActiveRedisDB::SortedSet.destroy_scores(:example, 1, 2)).to eq(0)
    end

    it 'to be 2' do
      ActiveRedisDB::SortedSet.create(:example, 1, 'one')
      ActiveRedisDB::SortedSet.create(:example, 2, 'two')
      ActiveRedisDB::SortedSet.create(:example, 3, 'three')

      expect(ActiveRedisDB::SortedSet.destroy_scores(:example, 0, 2)).to eq(2)
      expect(ActiveRedisDB::SortedSet.count(:example)).to eq(1)
    end
  end

  describe '.destroy_lex' do
    # TODO
  end

  describe '.scan' do
    # TODO
  end

end
