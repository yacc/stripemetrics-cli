desc 'Refresh your data'
arg_name 'Describe arguments to refresh here'
command :refresh do |c|
  c.action do |global_options,options,args|
    begin
      status = @client.refresh
      say("<%= color('Refreshing your data, this might take a while ....', :yellow) %>")
      say("<%= color('You can generate a partial report at anytime,', :yellow) %>")
      say("<%= color('If the imports are not finished, partial data is used to generate the reports.', :yellow) %>")

    rescue Stripemetrics::Client::AuthError
      exit_now! "You need to authorize with StripeMetrics.com first!\nTry login in with this command:\nstripemetrics-cli login"
    rescue Exception => e
      exit_now! "Oops ... #{e.message}"
    end
  end
end    