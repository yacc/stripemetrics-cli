desc 'Login and authorize with StripeMetrics.com'
command :login do |c|
  c.action do |global,options,args|
    begin
      username = ask("Entrer your StripeMetrics.com login:      ")
      password = ask("Enter your password:  ") { |q| q.echo = false }

      say("<%= color('Attempting to login....', :yellow) %>")
      token = @client.login(username, password)
      say("<%= color('Login successful!', :bold) %>")

    rescue Stripemetrics::Client::AuthError
      exit_now! 'Login failed!'
    rescue
      exit_now! 'Oops ...'
    end
  end
end