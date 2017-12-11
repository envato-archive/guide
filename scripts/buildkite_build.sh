#! /bin/bash

set -ex

bundle install --path vendor/bundle --retry 3
bundle exec appraisal install
bundle exec appraisal rspec spec
