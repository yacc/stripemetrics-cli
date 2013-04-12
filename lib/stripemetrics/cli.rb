require 'gli'
require 'highline/import'

include GLI::App

program_desc 'Get stripe metrics from the command line'
version Stripemetrics::VERSION
desc 'Development mode'
switch [:d,:development]

require 'stripemetrics/cli/commands'

pre do |global,command,options,args|
  @client ||= Stripemetrics::Client.new
  # if command.name != :help && command.name != :login
  #     @client ||= Stripemetrics::Client.new(:target_url => config.target)
  #   unless auth.valid?
  #     exit_now!("You need to authorize with StripeMetrics.com ! Try login in first with this command:\nstripemetrics-cli login")
  #   end
  # end  
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

