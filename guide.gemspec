$:.push File.expand_path("../lib", __FILE__)

require "guide/version"

Gem::Specification.new do |s|
  s.name        = "guide"
  s.version     = Guide::VERSION
  s.authors     = ["Luke Arndt", "Jordan Lewis", "Jiexin Huang"]
  s.email       = ["luke@arndt.io", "jordan@lewis.io", "hjx500@gmail.com"]
  s.homepage    = "https://github.com/envato/guide"
  s.summary     = "Living styleguide for your Rails application"
  s.description = "Document your Rails application with a living styleguide and component library"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.4"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "pry"
end
