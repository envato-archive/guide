#!/usr/bin/env bash
set -euo pipefail

echo "--- Installing xvfb"
apt-get update -y
apt-get install -y libgtk2.0-0 libgconf-2-4 libasound2 libxtst6 libxss1 libnss3 xvfb

echo "--- :npm: Installing"
npm install

echo "+++ :npm: Testing"
Xvfb -ac -screen scrn 1280x2000x24 :10 &
export DISPLAY=:10
npm test
