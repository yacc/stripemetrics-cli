module Stripemetrics
  class Client
    module Info
      def info
        get(Stripemetrics::INFO_PATH)
      end
    end
  end
end
