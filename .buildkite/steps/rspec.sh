#!/usr/bin/env bash
set -euo pipefail

echo "--- :bundler: Bundling"
bundle install
bundle exec appraisal install

echo "+++ :rspec: Running RSpec"
bundle exec appraisal rspec spec
