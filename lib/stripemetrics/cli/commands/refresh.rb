desc 'Refresh your data'
arg_name 'Describe arguments to refresh here'
command :refresh do |c|
  c.action do |global_options,options,args|
    begin
      token = @client.refresh
      say("<%= color('Running import, this might take a while ....', :yellow) %>")
      say("<%= color('You can generate a partial report at anytime,', :yellow) %>")
      say("<%= color('If the imports are not finished, partial data is used to generate the reports.', :yellow) %>")

    rescue Stripemetrics::Client::AuthError
      exit_now! "You need to authorize with StripeMetrics.com first!\nTry login in with this command:\nstripemetrics-cli login"
    rescue
      exit_now! 'Oops ...'
    end
  end
end    