module Stripemetrics
  class Client
    module Info
      def info
        get('v1/info', :require_auth => true)
      end
    end
  end
end
