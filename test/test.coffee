fs = require 'fs'
path = require 'path'
tcs = require('../src/index')
{inspect} = require('util')

# Try to parse
list = [
  'expr'
  'assignment'
  # 'for'
  # 'if'
  # 'identifier'
  # 'indent'
]

# for i in list
for i in []
  source = fs.readFileSync(path.join __dirname, "fixtures/#{i}.tcs").toString()
  try
    ast = tcs.parse(source)
    try
      compiled = tcs._compile ast
      Function compiled
    catch e
      console.error i + ' invalid output'
      console.error e
      # process.exit(1)
  catch e
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
    # throw new Error (formatter source, e)

  console.error inspect ast, depth: null # show ast
  code = tcs._compile(ast)
  console.log code # show code
  # execTemp(code)
