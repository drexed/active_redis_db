# frozen_string_literal: true

require 'spec_helper'

describe ActiveOrm::Redis::HyperLogLog do

  before(:each) do
    ActiveOrm::Redis::Connection.flush_all
  end

  describe '.create' do
    # TODO
  end

  describe '.count' do
    # TODO
  end

  describe '.merge' do
    # TODO
  end

end
