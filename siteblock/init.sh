#!/bin/sh

cd $(dirname $0)
npm install
open "/Applications/Google Chrome.app" --args --remote-debugging-port=9222

