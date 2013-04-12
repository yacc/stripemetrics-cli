module Stripemetrics
  class Client
    module Refresh
      def refresh
        get('/v1/refresh', :require_auth => true)
      end
    end
  end
end
