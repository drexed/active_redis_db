# frozen_string_literal: true

if defined?(Redis)
  ActiveRedisDB.configure do |config|
    config.client = Redis.new
  end
end
