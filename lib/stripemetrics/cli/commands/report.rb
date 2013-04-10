desc 'Generate report(s)'
arg_name 'Describe arguments to report here'
command :report do |c|
  c.action do |global_options,options,args|
    puts "report command ran"
  end
end
