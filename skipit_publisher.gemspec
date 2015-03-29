$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "skipit_publisher/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "skipit_publisher"
  s.version     = SkipitPublisher::VERSION
  s.authors     = ["Iwo Dziechciarow"]
  s.email       = ["iiwo@o2.pl"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of SkipitPublisher."
  s.description = "TODO: Description of SkipitPublisher."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'rails'
  s.add_dependency 'rpush'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'

  s.add_development_dependency "sqlite3"
end
