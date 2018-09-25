# frozen_string_literal: true

class ActiveRedisDB::Base
  class << self

    @@evaluate = false

    def client(new_client = nil)
      new_client || ActiveRedisDB.configuration.client
    end

    def evaluate(value = true)
      @@evaluate = value
      self
    end

    private

    def evaluate?
      value = @@evaluate
      @@evaluate = false
      value
    end

    def append?(order)
      order.to_s == 'append'
    end

    # rubocop:disable Security/Eval
    def metaform(value)
      eval(value.to_s)
    rescue StandardError
      value
    end
    # rubocop:enable Security/Eval

    def metaform_array(datum)
      datum.map { |val| metaform(val) }
    end

    def metaform_hash(datum)
      datum.each { |key, val| datum[key] = metaform(val) }
    end

    def metamorph_array(datum)
      case datum.first.class.name
      when 'Array' then datum.map { |arr| metaform_array(arr) }
      when 'Hash' then datum.map { |hsh| metaform_hash(hsh) }
      else metaform_array(datum)
      end
    end

    def metamorph(datum)
      case datum.class.name
      when 'Array' then metamorph_array(datum)
      when 'Hash' then metaform_hash(datum)
      else metaform(datum)
      end
    end

    def metatransform(datum)
      return if datum.empty?

      evaluate? ? metamorph(datum) : datum
    end

    def milliseconds?(format)
      format.to_s == 'milliseconds'
    end

    def normalize_key(key)
      key.to_s
    end

    def prepend?(order)
      order.to_s == 'prepend'
    end

    def seconds?(format)
      format.to_s == 'seconds'
    end

    def stringify_keys(value)
      value.map { |key, _| key.to_s }
    end

  end
end
