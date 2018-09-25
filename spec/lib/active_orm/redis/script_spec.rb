# frozen_string_literal: true

require 'spec_helper'

describe ActiveOrm::Redis::Script do

  before(:each) do
    ActiveOrm::Redis::Connection.flush_all
  end

  describe '.script' do
    # TODO
  end

  describe '.eval' do
    # TODO
  end

  describe '.evalsha' do
    # TODO
  end

end
