desc 'Generate report(s)'
arg_name 'metric1, metrics2[,metric3]*'
long_desc <<-EOS
  Generates a report from your StripeMetrics data. The reports include all the metrics by default.\n
  The report is an ascii table that shows the metrics and compares it to last month, then explicitly calculates the monthly change, the trailing six month average and finally compares the metric to the goal best communicates the state of that metric
  ex: bundle exec ./bin/stripemetrics-cli report churn charges
  EOS
command :report do |c|
  c.switch [:a,:all]
  c.action do |global_options,options,args|
    begin
      say("<%= color('Gathering data from StripeMetrics ....', :yellow) %>")
      metrics = @client.get_metrics
      token = @client.print metrics, options, args
      say("<%= color('(*) TSM Average column is the Trailing Six Month Compound Growth Rate', :blue) %>")
    rescue Stripemetrics::Client::AuthError
      exit_now! "You need to authorize with StripeMetrics.com first!\nTry login in with this command:\nstripemetrics-cli login"
    rescue Exception => e
      exit_now! "Oops ... #{e.message}"
    end
  end
end

