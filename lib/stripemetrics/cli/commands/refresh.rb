desc 'Refresh your data'
arg_name 'Describe arguments to refresh here'
command :refresh do |c|
  c.action do |global_options,options,args|
    puts "refresh command ran"
  end
end    