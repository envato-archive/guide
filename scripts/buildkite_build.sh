#! /bin/bash

set -ex

bundle install --path vendor/bundle --retry 3
bundle exec rspec spec
