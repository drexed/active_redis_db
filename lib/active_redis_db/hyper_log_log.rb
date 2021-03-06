# frozen_string_literal: true

class ActiveRedisDB::HyperLogLog < ActiveRedisDB::Base
  class << self

    def create(key, member)
      client.pfadd(normalize_key(key), member)
    end

    def count(*args)
      client.pfcount(args)
    end

    def merge(key, *keys)
      client.pfmerge(normalize_key(key), keys)
    end

  end
end
