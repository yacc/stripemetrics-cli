require 'stripemetrics/version.rb'
require 'stripemetrics/client'
require 'stripemetrics/cli'

module Stripemetrics
  case ENV['smenv'] # StripeMetricsEnvironment
  when 'development'
    DEFAULT_LOCAL_TARGET = 'http://api.stripemetrics.dev/v1'
    # DEFAULT_LOCAL_TARGET = 'http://0.0.0.0:9292/v1'
  else
    DEFAULT_LOCAL_TARGET = 'https://api.stripemetrics.com/v1'
  end
end
