# frozen_string_literal: true

if defined?(Redis)
  ActiveOrm::Redis.configure do |config|
    config.client = Redis.new
  end
end
