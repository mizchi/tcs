#!/usr/bin/env sh
rm -r _tcs
mkdir _tcs
../../tcs src/game.tcs -o _tcs/game.js -t flow
../../tcs src/entity.tcs -o _tcs/entity.js -t flow

# flow
# babel _tcs/game.js -o lib/game.js
