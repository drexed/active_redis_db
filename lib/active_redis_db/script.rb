# frozen_string_literal: true

class ActiveRedisDB::Script < ActiveRedisDB::Base
  class << self

    def script(command, *args)
      client.script(command, args)
    end

    def eval(*args)
      client.eval(:eval, args)
    end

    def evalsha(*args)
      client.eval(:evalsha, args)
    end

  end
end
