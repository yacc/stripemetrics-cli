desc 'Test authentication with StripeMetrics.com'
command :ping do |c|
  c.action do |global,options,args|
    begin
      say("<%= color('ping....', :yellow) %>")
      pong = @client.ping
      say("<%= color('#{pong}!', :yellow) %>")
    rescue Stripemetrics::Client::AuthError
      exit_now! 'Dropped the ball .... login failed!'
    rescue # Stripemetrics::Client::TargetError
      exit_now! 'Oops ... something went wrong ;-('
    end
  end
end