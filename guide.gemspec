$:.push File.expand_path("../lib", __FILE__)

require "guide/version"

Gem::Specification.new do |s|
  s.name        = "guide"
  s.version     = Guide::VERSION
  s.authors     = ["Luke Arndt", "Jordan Lewis", "Jiexin Huang"]
  s.email       = ["luke@arndt.io", "jordan@lewis.io", "hjx500@gmail.com"]
  s.homepage    = "https://github.com/envato/guide"
  s.summary     = "Living documentation for your Rails application"
  s.description = "Document your Rails application with a living component library and styleguide"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "railties", ">= 4"
  s.add_dependency "actionpack", ">= 4"
  s.add_dependency "actionview", ">= 4"
  s.add_dependency "activemodel", ">= 4"
  s.add_dependency "sprockets-rails"
  s.add_dependency "sass-rails", ">= 3.2"

  s.add_development_dependency "appraisal"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "pry"
  s.add_development_dependency "rails-controller-testing"
end
