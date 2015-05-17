#!/usr/bin/env sh
# ../../tcs src/hello.tcs -o _tcs/hello.js -t flow
# flow && babel _tcs/hello.js -o lib/hello.js

../../tcs -s src -o _tcs -t flow
flow
../../tcs -s src -o lib  -t es5
