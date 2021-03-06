# frozen_string_literal: true

begin
  require 'fakeredis'
rescue LoadError
  require 'redis'
end

module ActiveRedisDB
  class Configuration

    attr_accessor :client

    def initialize
      @client = ::Redis.new
    end

  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield(configuration)
  end

end
