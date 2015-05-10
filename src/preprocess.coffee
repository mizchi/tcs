stripComments = require 'strip-comments'
module.exports = (text) ->
  stripComments(text)
    .split('\n')
    .filter (line) ->
      trimed = line.split( /\t|\s/ ).join('')
      trimed.length > 0 and (trimed.indexOf('#') isnt 0)
    .join('\n')
