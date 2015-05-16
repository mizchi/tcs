recast = require 'recast'

# ProgramNode => string
module.exports = (node, options = {}) ->
  "/* @flow */\n" + recast.print(node).code
