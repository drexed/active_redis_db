# ActiveRedisDB

[![Gem Version](https://badge.fury.io/rb/active_redis_db.svg)](http://badge.fury.io/rb/active_redis_db)
[![Build Status](https://travis-ci.org/drexed/active_redis_db.svg?branch=master)](https://travis-ci.org/drexed/active_redis_db)

ActiveRedisDB is a library for object ruby mapping of different databases.

**Supported:**
  * Redis

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_redis_db'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_redis_db

## Table of Contents

* [Configuration](#configuration)
* [Usage](#usage)
* [Rake](#rake)

## Configuration

**Options:**
 * client: add a custom Redis client

`rails generate active_redis_db:install` will generate the following file:
`../config/initalizers/active_redis_db.rb`

```ruby
if defined?(Redis)
  ActiveRedisDB.configure do |config|
    config.client = Redis.new(host: '10.0.1.1', port: 6380, db: 15)
  end
end
```

## Usage

**Commands:**
 * Geo
 * Hash
 * HyperLogLog
 * Key
 * List
 * PubSub
 * Script
 * Set
 * Sorted Set
 * String
 * Transaction

```ruby
ActiveRedisDB::String.create(:month, '01')
ActiveRedisDB::String.find(:month)           #=> '01'
ActiveRedisDB::String.evaluate.find(:month)  #=> 1

ActiveRedisDB::List.create(:user_1, { id: 32123, name: 'James Dean', username: 'alpha123' })
ActiveRedisDB::List.find(:user_1)            #=> { id: '32123', name: 'James Dean', username: 'alpha123' }
ActiveRedisDB::List.evaluate.find(:user_1)   #=> { id: 32123, name: 'James Dean', username: 'alpha123' }
```

## Rake

**Options:**
 * reset: reset current database
 * reset_all: reset all databases

`rake db:redis:reset` and `rake db:redis:reset_all`

## Contributing

Your contribution is welcome.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
