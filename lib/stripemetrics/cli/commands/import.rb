desc 'Import customer and subscritpion data'
#arg_name 'Describe arguments to import here'
command :import do |c|
  c.flag [:f,:filename], :arg_name => 'file_name',
                 :desc => 'The (csv) filename of deleted customers to import'
  c.action do |global_options,options,args|
    puts "import command ran"
  end
end    