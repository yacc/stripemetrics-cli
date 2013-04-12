module Stripemetrics
  class Client
    module Import
      def import
        get('/v1/imports', :require_auth => true)
      end
    end
  end
end
