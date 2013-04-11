require 'stripemetrics/client/authentication'
require 'stripemetrics/client/connection'
require 'stripemetrics/client/errors'
require 'stripemetrics/client/info'
require 'stripemetrics/client/request'

module Stripemetrics
  class Client
    attr_accessor :http_adapter, :target_url

    def initialize(options={})
      @auth_token = options[:auth_token]
      @target_url = options[:target_url] || Stripemetrics::DEFAULT_LOCAL_TARGET
      @http_adapter = :net_http
    end

    include Authentication
    include Connection
    include Info
    include Request
  end
end
