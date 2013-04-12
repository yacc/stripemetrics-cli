require 'stripemetrics/version.rb'
require 'stripemetrics/client'
require 'stripemetrics/cli'

module Stripemetrics
  case ENV['smenv'] # StripeMetricsEnvironment
  when 'test'
    DEFAULT_LOCAL_TARGET = 'http://api.stripemetrics.dev/v1'
  when 'development'
    DEFAULT_LOCAL_TARGET = 'http://api.stripemetrics.dev/v1'
  when 'staging'
    DEFAULT_LOCAL_TARGET = 'http://stripemetrics1-yacc.dotcloud.com/v1'
  when 'production'  
    DEFAULT_LOCAL_TARGET = 'http://api.stripemetrics.com/v1'
  else
    DEFAULT_LOCAL_TARGET = 'http://api.stripemetrics.com/v1'
  end
end
