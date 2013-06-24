desc 'Login and authorize with StripeMetrics.com'
command :login do |c|
  c.action do |global,options,args|
    begin
      username = ask("Entrer your StripeMetrics.com login:      ")
      password = ask("Enter your password:  ") { |q| q.echo = false }

      say("<%= color('Attempting to login....', :yellow) %>")
      netrc_file = @client.login(username, password)
      say("<%= color('Login successful!', :bold) %>")
      say("<%= color('Credentials saved in #{netrc_file}', :bold) %>")

    rescue Stripemetrics::Client::AuthError
      exit_now! 'Login failed!'
    rescue Stripemetrics::Client::TargetError
      exit_now! 'Oops ... something went wrong ;-('
    end
  end
end