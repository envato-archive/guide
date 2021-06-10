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

  s.metadata["homepage_uri"] = s.homepage
  s.metadata["source_code_uri"] = "#{s.homepage}/tree/v#{s.version}"
  s.metadata["changelog_uri"] = "#{s.homepage}/blob/HEAD/CHANGELOG.md"
  s.metadata["bug_tracker_uri"] = "#{s.homepage}/issues"
  s.metadata["wiki_uri"] = "#{s.homepage}/wiki"
  s.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/#{s.name}/#{s.version}"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  s.required_ruby_version = ">= 2.6"

  s.add_dependency "railties", ">= 5.2"
  s.add_dependency "actionpack", ">= 5.2"
  s.add_dependency "actionview", ">= 5.2"
  s.add_dependency "activemodel", ">= 5.2"
  s.add_dependency "sprockets-rails"

  s.add_development_dependency "appraisal"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "pry"
  s.add_development_dependency "rails-controller-testing"
end
