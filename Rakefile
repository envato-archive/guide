require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

if ENV['APPRAISAL_INITIALIZED'] || ENV['TRAVIS']
  task default: :spec
else
  require 'appraisal'
  task default: :appraisal
end
