# frozen_string_literal: true

require 'redis'

url   = ENV['REDIS_URL'] || 'redis://localhost:6379'
REDIS = Redis.new(url: url, timeout: 10)
