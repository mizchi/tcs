fs = require 'fs'
path = require 'path'
tcs = require('../src/index')
{inspect} = require('util')

# Try to parse
list = [
  'assignment'
  'binary'
  'declare-variable'
  'expr'
  'func'
  'class'
  'for'
  'if'
  'interface'
  'module'
  'statement'
]

for i in list
# for i in []
  source = fs.readFileSync(path.join __dirname, "fixtures/#{i}.tcs").toString()
  try
    ast = tcs.parse(source)
    try
      compiled = tcs._compile ast, target: 'flow'
    catch e
      console.error i + ' invalid output'
  catch e
    console.log 'eee'
    console.error e

if target = process.argv[3] ? process.argv[2]
  console.error 'exec', target
  source = fs.readFileSync(path.join process.cwd(), target).toString()
  ast = null
  try
    ast = tcs.parse(source)
  catch e
    formatter = require('../src/format-error.coffee')
    console.log 'parser failed on', target
    throw e

  console.error inspect ast, depth: null # show ast
  code = tcs._compile(ast, {target: 'flow'})
  console.log code # show code
