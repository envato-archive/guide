require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :setup_test_app, [:rails_version] do |_task, args|
  require_relative './spec/test_apps/setup'
  TestApps::Setup.call args.fetch(:rails_version) {
    abort "Example usage: rake #{ARGV[0]}[5.1.4]"
  }
end

if ENV['APPRAISAL_INITIALIZED'] || ENV['TRAVIS']
  task default: :spec
else
  require 'appraisal'
  task default: :appraisal
end
