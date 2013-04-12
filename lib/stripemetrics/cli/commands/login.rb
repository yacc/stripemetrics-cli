desc 'Login and authorize with StripeMetrics.com'
command :login do |c|
  c.action do |global,options,args|
    begin
      username = ask("Entrer your StripeMetrics.com login:      ")
      password = ask("Enter your password:  ") { |q| q.echo = false }

      say("<%= color('Attempting to login....', :yellow) %>")
      token = @client.login(username, password)
      say("<%= color('Login successful!', :bold) %>")

      #config.update(:tokens, token)
    # rescue Stripemetrics::Client::TargetError
    #   say("<%= color('Login failed!', :red) %>")
    rescue Stripemetrics::Client::AuthError
      say("<%= color('Login failed!', :red) %>")
    end
  end
end