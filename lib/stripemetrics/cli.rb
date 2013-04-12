require 'gli'
require 'highline/import'

include GLI::App

program_desc 'Get stripe metrics from the command line'
version Stripemetrics::VERSION

require 'stripemetrics/cli/commands'

pre do |global,command,options,args|
  @client ||= Stripemetrics::Client.new
  true
end

post do |global,command,options,args|
  # Post logic here
  # Use skips_post before a command to skip this
  # block on that command only
end

on_error do |exception|
  # Error logic here
  # return false to skip default error handling
  true
end

