recast = require 'recast'
babel = require 'babel-core'

# ProgramNode => string
compileToFlow = (node, options = {}) ->
  "/* @flow */\n" + recast.print(node).code

# ProgramNode => string
compileToES5 = (node, options = {}) ->
  babel.transform(recast.print(node).code)

module.exports = (node, opts = {}) =>
  target = opts.t ? opts.target
  if target is 'flow'
    compileToFlow node, opts
  else # if target is 'es5'
    compileToES5(node, opts).code
