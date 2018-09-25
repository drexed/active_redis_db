# frozen_string_literal: true

require 'rails/railtie'

%w[
  version railtie configuration base connection geo hash hyper_log_log
  key list pub_sub script set sorted_set string transaction
].each do |file_name|
  require "active_redis_db/#{file_name}"
end

require 'generators/active_redis_db/install_generator'
