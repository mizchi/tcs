#!/usr/bin/env sh
../../tcs src/game.tcs -o _tcs/game.js
flow && babel _tcs/game.js -o lib/game.js
