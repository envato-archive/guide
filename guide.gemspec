$:.push File.expand_path("../lib", __FILE__)

require "guide/version"

Gem::Specification.new do |gem|
  gem.name        = "guide"
  gem.version     = Guide::VERSION
  gem.authors     = ["Jordan Lewis", "Luke Arndt", "Jiexin Huang"]
  gem.email       = ["jordan.lewis@envato.com", "luke@arndt.io", "hjx500@gmail.com"]
  gem.homepage    = "https://github.com/envato/guide-gem"
  gem.summary     = "Living styleguide for your Rails app"
  gem.description = "Living styleguide for your Rails app, by Envato"
  gem.license     = "MIT"

  gem.files = Dir["{app,config,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  gem.test_files = Dir["test/**/*"]

  gem.add_dependency "activesupport", ">= 3.0", "< 5"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rspec-its"
  gem.add_development_dependency "actionview"
  gem.add_development_dependency "pry"
end
