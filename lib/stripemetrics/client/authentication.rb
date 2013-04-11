module Stripemetrics
  class Client
    module Authentication
      attr_accessor :auth_token
      attr_reader :user

      def login(username, password, options={})      
        @netrc_file = options[:netrcf] || netrc_path
        if username && password
          response = post("auth/tokens", 
                          :body => {:username => username, :password => password })
          raise TargetError if response["code"] == 200

          @user = username
          @auth_token = response["token"]
          write_credentials
        else
          @auth_token = read_token
        end  
        @auth_token  
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

    def valid?
      @token
    end

    def host
      "stripemetrics.com"  
    end

    def netrc_path
      default = Netrc.default_path
      encrypted = default + ".gpg"
      if File.exists?(encrypted)
        encrypted
      else
        default
      end
    end

    def netrc   # :nodoc:
      @netrc ||= begin
        File.exists?(@netrc_file) && Netrc.read(@netrc_file)
      rescue => error
        if error.message =~ /^Permission bits for/
          perm = File.stat(@netrc_file).mode & 0777
          abort("Permissions #{perm} for '#{netrc_path}' are too open. You should run `chmod 0600 #{netrc_path}` so that your credentials are NOT accessible by others.")
        else
          raise error
        end
      end
    end

    def read_token
      token = if netrc
        credentials = netrc["api.#{host}"]
        credentials[1] if credentials
      end
    end

    def write_credentials
      FileUtils.mkdir_p(File.dirname(@netrc_file))
      FileUtils.touch(@netrc_file)      
      FileUtils.chmod(0600, @netrc_file) unless RUBY_PLATFORM =~ /mswin32|mingw32/

      if (@user && @auth_token)
        netrc["api.#{host}"] = @user,@auth_token
        netrc.save
      end
    end

    end
  end
end
