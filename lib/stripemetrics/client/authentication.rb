module Stripemetrics
  class Client
    module Authentication
      attr_accessor :auth_token
      attr_reader :user

      def login(username, password)
        response = post("auth/tokens", 
                        :body => {:username => username, :password => password })
        raise TargetError if response["code"] == 200

        @user = username
        @auth_token = response["token"]
      end

      def auth_token_valid?
        descr = info
        if descr
          return false unless descr[:user]
          return false unless descr[:usage]
          @user = descr[:user]
          true
        end
      end

      def logged_in?
        user
      end
    end
  end
end
