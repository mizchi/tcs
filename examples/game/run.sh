#!/usr/bin/env sh
../../tcs src/game.tcs -o _tcs/game.js -t flow
flow && babel _tcs/game.js -o lib/game.js
