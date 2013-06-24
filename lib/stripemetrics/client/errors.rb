module Stripemetrics
  class Client
    class AuthError <  RuntimeError; end
    class TargetError < RuntimeError; end
    class ApiError < RuntimeError; end
  end
end
