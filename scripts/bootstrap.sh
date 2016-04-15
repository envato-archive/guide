#!/bin/bash

set -o nounset
set -o errexit

if [ -z $(which ruby) ]; then
    echo "Could not find 'ruby' in your PATH!"
    exit 1
fi

if [ -z $(which bundler) ]; then
    echo "Could not find 'bundler' in your PATH!"
    exit 1
fi

RUBY=$(which ruby)
BUNDLER=$(which bundler)

checksum_bundle() {
    (((find Gemfile Gemfile.lock .bundle/bin -type f) | xargs cat) && $RUBY -v && $BUNDLER -v) | md5
}

write_checksum() {
    mkdir -p tmp
    checksum_bundle > tmp/bundle_checksum.txt
}

log() {
    local color=$1
    local message="$@"
    local reset='\033[0m'
    echo -e "${color}====> ${message}${reset}"
}

status() {
    local green='\033[0;32m'
    log $green "$@"
}

info() {
    local blue='\033[0;34m'
    log $blue "$@"
}

# Shamelessly copied from Heroku's nodejs buildpack
# https://github.com/heroku/heroku-buildpack-nodejs/blob/67291e8c9afa15720219652e490d34d9d28735a6/lib/binaries.sh#L45
install_npm() {
    local version="$1"
    if [ "$version" == "" ]; then
        echo "Using default npm version: `npm --version`"
    else
        if [[ `npm --version` == "$version" ]]; then
            echo "npm `npm --version` already installed with node"
        else
            echo "Downloading and installing npm $version (replacing version `npm --version`)..."
            npm install --unsafe-perm --quiet -g npm@$version 2>&1 >/dev/null
        fi
    fi
}

if [[ $# > 0 ]] && [ "$1" == "--pristine" ]; then
    status "Cleaning installed gems ..."
    rm -rf .bundle/bin .bundle/ruby/* tmp/bundle_checksum.txt
    shift
fi

if [ "$(checksum_bundle)" = "$(cat tmp/bundle_checksum.txt 2>/dev/null)" ]; then
    status "Bundle already up to date!"
else
    status "Installing gems ..."
    bundle install --path .bundle --local --binstubs .bundle/bin --quiet && write_checksum
fi

status "Configuring bundle console ..."
grep -q BUNDLE_CONSOLE .bundle/config || bundle config --local console pry

status "Checking npm version..."
install_npm 3.5.3

status "Installing npm modules ..."
npm prune
npm install

echo ""
info "Bootstrapped! To start the project, run"
info "    cd spec/test_app && foreman start"
info "    npm run watch"
echo ""
