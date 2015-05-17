tcs = require('../lib/index')
{inspect} = require('util')
path = require('path')
fs =require('fs')
glob = require 'glob'
mkdirp = require 'mkdirp'

argv = require('minimist')(process.argv.slice(2))

printBeautifiedCode = (source, options = {}) ->
  code = tcs.compile source, options

printAst = (source, options = {}) ->
  code = tcs.parse source, options
  inspect code, depth: null

[target] = argv._

{execSync} = require 'child_process'

run = (argv) ->
  out = argv.outDir ? argv.o
  src = argv.srcDir ? argv.s

  if src and out
    srcDir = path.join(process.cwd(), src)
    outDir = path.join(process.cwd(), out)
    targets = glob.sync srcDir + '/**/*.tcs'
    for targetPath in targets when fs.statSync(targetPath).isFile()
      # compile
      source = fs.readFileSync(targetPath).toString()
      code = tcs.compile source, argv

      # output
      outputPath = targetPath
        .replace(srcDir, outDir)
        .replace(/\.tcs?/, '.js')

      # ensure dir
      outDir = path.dirname outputPath
      mkdirp.sync outDir

      fs.writeFileSync(outputPath, code)
      console.error targetPath, "->", outputPath
    # TODO: auto generate filename by extname
  else
    targetPath = path.join process.cwd(), argv._[0]
    source = fs.readFileSync(targetPath).toString()
    code = tcs.compile source, argv
    console.log code

run(argv)
