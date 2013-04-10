desc 'Login and authorize with StripeMetrics.com'
command :login do |c|
  c.action do |global,options,args|
    username = ask("StripeMetrics.com login:      ")
    password = ask("Enter your password:  ") { |q| q.echo = false }

    # api_client = Stripemetrics::ApiClient.new
    # auth = Stripemetrics::Authorization.new(api_client,{:email => username,:password => password})
  end
end