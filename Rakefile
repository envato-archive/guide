# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

assets_target = 'app/assets'
js_target = "#{assets_target}/javascripts/guide"
css_target = "#{assets_target}/stylesheets/guide"

CLEAN << assets_target
RSpec::Core::RakeTask.new(:spec)
task spec: %w[generate_assets]
task build: %w[clean generate_assets]
task generate_assets: %W[
  #{js_target}/application.js
  #{js_target}/scenario.js
  #{css_target}/application.css
]

rule(%r{^#{js_target}/.+\.js$} => [->(n) { n.sub(js_target, 'javascript') }, 'node_modules/.install']) do |t|
  sh "yarn browserify #{t.source} -o #{t.name}"
end

rule(%r{^#{css_target}/.+\.css$} => [->(n) { n.sub(css_target, 'styles') }, 'node_modules/.install']) do |t|
  sh "yarn postcss #{t.source} -o #{t.name}"
end

file 'node_modules/.install' => %w[package.json yarn.lock] do
  sh 'yarn install'
  touch 'node_modules/.install'
end

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
