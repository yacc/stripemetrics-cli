require 'stripemetrics/client/authentication'
require 'stripemetrics/client/connection'
require 'stripemetrics/client/request'
require 'stripemetrics/client/errors'
require 'stripemetrics/client/info'
require 'stripemetrics/client/import'
require 'stripemetrics/client/refresh'
require 'stripemetrics/client/report'
require 'command_line_reporter'

module Stripemetrics
  class Client
    attr_accessor :http_adapter, :target_url
    include CommandLineReporter

    def initialize(options={})
      @auth_token = options[:auth_token]
      @target_url = options[:target_url] || Stripemetrics::DEFAULT_LOCAL_TARGET
      @http_adapter = :net_http
    end

    include Authentication
    include Connection
    include Request
    include Info
    include Import
    include Refresh
    include Report
    
  end
end
