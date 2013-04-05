require 'netrc'

module StripemetricsCli
  class Authorization
    attr_reader :token

    def initialize(api_client,options={})
      @netrc_file = options[:netrcf] || netrc_path
      if options.has_key?(:email) && options.has_key?(:password)
        @username = options[:email]
        @token    = api_client.get_token(options[:email],options[:password])
        write_credentials
      else
        @token = read_token
      end    
    end

    def login!

    end

    def logout!

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

      if (@username && @token)
        netrc["api.#{host}"] = @username,@token
        netrc.save
      end
    end

  end
end
