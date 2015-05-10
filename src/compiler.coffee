recast = require 'recast'

# ProgramNode => string
module.exports = (node, options = {}) ->
  recast.print(node).code
