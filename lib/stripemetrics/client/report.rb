module Stripemetrics
  class Client
    module Report
      def report
        get('/v1/reports', :require_auth => true)
      end
    end
  end
end
