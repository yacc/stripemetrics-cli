module Stripemetrics
  class Client
    module Refresh
      def refresh
        response = post('imports/refresh', :require_auth => true)
        raise TargetError if response.status == 404
        raise AuthError if response.status == 401
        (response.status == 200) ? 'success' : 'failure'
      end
    end
  end
end
