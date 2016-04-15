#!/bin/bash

set -o nounset
set -o errexit

# prepare assets compile env
npm prune
npm install

# front end assets compile
npm run build

# do git release
