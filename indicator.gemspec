$:.push File.expand_path("../lib", __FILE__)

description = <<TEXT
Sinatra app that drives the delcom indicator light
TEXT


Gem::Specification.new do |s|
  s.name        = "indicator"
  s.summary     = %q{Sinatra app that drives the delcom indicator light}
  s.description = description
  s.homepage    = "http://github.com/playup/indicator"
  s.authors     = ["PlayUp Devops"]
  s.email       = ["devops@playup.com"]

  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY

  s.add_runtime_dependency 'sinatra'  , '1.0'
  s.add_runtime_dependency 'haml'     , '2.2.23'
  s.add_runtime_dependency 'ruby-usb' , '0.1.3'

  s.add_development_dependency 'rake', '~> 0.9.2'

  s.require_paths = ["lib"]
  s.files         = Dir["lib/*", "init.d", "README.md", "LICENSE"]
  s.executables   = ["indicatord", "jenkins_light"]
end

