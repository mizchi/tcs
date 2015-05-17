#!/usr/bin/env sh
../../tcs src/hello.tcs -o _tcs/hello.js -t flow
flow && babel _tcs/hello.js -o lib/hello.js

tcs -o _tcs src/**/*.tcs -t flow
tcs -o lib src/**/*.tcs -t es5
