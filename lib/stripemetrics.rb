require 'stripemetrics/version.rb'
require 'stripemetrics/client'
require 'stripemetrics/cli'

module Stripemetrics
  APPS_PATH            = '/apps'
  DEFAULT_CONFIG_PATH = '~/.vmc'
  DEFAULT_LOCAL_TARGET = 'http://api.vcap.me'
  INFO_PATH            = '/info'
  USERS_PATH           = '/users'
end
