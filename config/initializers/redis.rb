# frozen_string_literal: true

require 'redis'

url   = ENV.fetch('REDIS_URL', 'redis://redis:6379/1')
REDIS = Redis.new(url: url, timeout: 10)
