require 'launchy'

desc 'Register a new account with StripeMetrics.com'
command :register do |c|
  c.action do |global,options,args|
    begin
      say("<%= color('Connecting you with Stripemetrics.com ....', :yellow) %>")
      Launchy.open( "http://stripemetrics.dev/register")
      say("<%= color('If you registration was successful, you should be ale to use your credentials to login.', :bold) %>")
      say("<%= color('Try login in with this command:\nstripemetrics-cli login',:bold) %>")

    rescue Stripemetrics::Client::AuthError
      exit_now! 'Registration failed!'
    rescue
      exit_now! 'Oops ...'
    end
  end
end