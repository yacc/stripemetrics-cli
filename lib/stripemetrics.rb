require 'stripemetrics/version.rb'
require 'stripemetrics/client'
require 'stripemetrics/cli'

module Stripemetrics
  case ENV['smenv'] # StripeMetricsEnvironment
  when 'staging'
    DEFAULT_LOCAL_TARGET = 'http://stripemetrics1-yacc.dotcloud.com'
  when 'production'  
    DEFAULT_LOCAL_TARGET = 'http://api.stripemetrics.com'
  else
    DEFAULT_LOCAL_TARGET = 'http://api.stripemetrics.com'
  end
end
