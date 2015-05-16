#!/usr/bin/env sh
../../tcs src/hello.tcs -o _tcs/hello.js
flow && babel _tcs/hello.js -o lib/hello.js
