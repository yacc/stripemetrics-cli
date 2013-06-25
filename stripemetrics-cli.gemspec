# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','stripemetrics','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'stripemetrics-cli'
  s.version = Stripemetrics::VERSION
  s.author = 'Yacin Bahi'
  s.email = 'yacinb@gmail.com'
  s.homepage = 'https://stripemetrics.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Command Line Interfce for StripeMetrics'
# Add your other files here if you make them
  s.files = %w(
bin/stripemetrics-cli
lib/stripemetrics/version.rb
lib/stripemetrics.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','stripemetrics-cli.rdoc']
  s.rdoc_options << '--title' << 'stripemetrics-cli' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'stripemetrics-cli'
  
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'aruba'
  s.add_development_dependency 'rspec', '~> 2.6'
  s.add_development_dependency 'webmock', '~> 1.6'
  s.add_development_dependency 'fakefs' #, :require => "fakefs/safe"

  s.add_runtime_dependency 'gli','2.6.0rc1'
  s.add_runtime_dependency 'launchy', '2.2.0'
  s.add_runtime_dependency 'netrc', '0.7.7'
  s.add_runtime_dependency 'highline', '1.6.15'
  s.add_runtime_dependency 'faraday_middleware'
  s.add_runtime_dependency 'command_line_reporter', '>=3.0'

end
