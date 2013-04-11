module Stripemetrics
  class Client
    module Info
      def info
        get(Stripemetrics::INFO_PATH, :require_auth => true)
      end
    end
  end
end
