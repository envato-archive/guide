#! /bin/bash

set -ex

bundle install --local --path vendor/bundle --retry 3
bundle exec rspec spec
