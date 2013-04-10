require "base64"
require "excon"
require "securerandom"
require "uri"
require "zlib"


module Stripemetrics
  class ApiClient
    require "stripemetrics/api_client/errors"
    require "stripemetrics/api_client/login"

    HEADERS = {
      'Accept'                => 'application/json',
      'Accept-Encoding'       => 'gzip',
      'User-Agent'            => "stripemetrics-cli-rb/0.0.1",
      'X-Ruby-Version'        => RUBY_VERSION,
      'X-Ruby-Platform'       => RUBY_PLATFORM
    }
    OPTIONS = {
      :headers  => {},
      :host     => 'api.stripemetrics.com',
      :nonblock => false,
      :scheme   => 'https'
    }

    def initialize(options={})
      options = OPTIONS.merge(options)

      @api_key = options.delete(:api_key) 
      if !@api_key && options.has_key?(:username) && options.has_key?(:password)
        @connection = Excon.new("#{options[:scheme]}://#{options[:host]}", options.merge(:headers => HEADERS))
        @api_key = self.post_login(options[:username], options[:password]).body["api_key"]
      end

      user_pass = ":#{@api_key}"
      options[:headers] = HEADERS.merge({
        'Authorization' => "Basic #{Base64.encode64(user_pass).gsub("\n", '')}",
      }).merge(options[:headers])

      @connection = Excon.new("#{options[:scheme]}://#{options[:host]}", options)      
    end  


    def request(params, &block)
      begin
        response = @connection.request(params, &block)
      rescue Excon::Errors::HTTPStatusError => error
        klass = case error.response.status
          when 401 then Stripemetrics::API::Errors::Unauthorized
          when 402 then Stripemetrics::API::Errors::VerificationRequired
          when 403 then Stripemetrics::API::Errors::Forbidden
          when 404
            if error.request[:path].match /\/apps\/\/.*/
              Stripemetrics::API::Errors::NilApp
            else
              Stripemetrics::API::Errors::NotFound
            end
          when 408 then Stripemetrics::API::Errors::Timeout
          when 422 then Stripemetrics::API::Errors::RequestFailed
          when 423 then Stripemetrics::API::Errors::Locked
          when 429 then Stripemetrics::API::Errors::RateLimitExceeded
          when /50./ then Stripemetrics::API::Errors::RequestFailed
          else Stripemetrics::API::Errors::ErrorWithResponse
        end

        reerror = klass.new(error.message, error.response)
        reerror.set_backtrace(error.backtrace)
        raise(reerror)
      end

      if response.body && !response.body.empty?
        if response.headers['Content-Encoding'] == 'gzip'
          response.body = Zlib::GzipReader.new(StringIO.new(response.body)).read
        end
        begin
          response.body = Stripemetrics::API::OkJson.decode(response.body)
        rescue
          # leave non-JSON body as is
        end
      end

      # reset (non-persistent) connection
      @connection.reset

      response
    end
    private

    def app_params(params)
      app_params = {}
      params.each do |key, value|
        app_params["app[#{key}]"] = value
      end
      app_params
    end

    def addon_params(params)
      params.inject({}) do |accum, (key, value)|
        accum["config[#{key}]"] = value
        accum
      end
    end

    def escape(string)
      CGI.escape(string).gsub('.', '%2E')
    end

    def ps_options(params)
      if ps_env = params.delete(:ps_env) || params.delete('ps_env')
        ps_env.each do |key, value|
          params["ps_env[#{key}]"] = value
        end
      end
      params
    end

  end
end
