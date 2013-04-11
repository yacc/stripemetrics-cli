require 'faraday_middleware'

module Stripemetrics
  class Client
    module Connection
      private

      def connection
        connection = Faraday.new target_url do |conn|
          conn.request :json
          conn.response :json, :content_type => /\bjson$/
          #conn.use :instrumentation
          conn.adapter Faraday.default_adapter
        end
      end
    end
  end
end

