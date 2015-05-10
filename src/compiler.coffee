# postprocess
camelize = require 'camelize'

_compile = (node) ->
  switch node.type
    when 'if'
      condCode = _compile node.condition

      children = node.body.map (child) -> _compile(child)
      childrenCode = children.join(';')

      ifCode = """
      if(#{condCode}) { #{childrenCode} }
      """

      if node.consequents?.length
        for consequent in node.consequents
          consequentCondCode = _compile consequent.condition
          consequentCode =
            consequent.body
              .map((child) -> _compile(child))
              .join(';')

          ifCode += "else if(#{consequentCondCode}) { #{consequentCode} }"

      if node.alternate?
        alternateChildrenCode =
          node.alternate.body
            .map((child) -> _compile(child))
            .join(';')
        ifCode += "else { #{alternateChildrenCode} }"

      ifCode

    when 'forIn'
      bodyCode = node.body
        .map((c) -> _compile(c) + ';')
        .join('')
      """
      for(var __i in #{_compile node.right}) {
        #{if node.second? then "var #{node.second.value} = __i;" else ""}
        var #{node.left.value} = #{_compile node.right}[__i];
        #{bodyCode};
      }
      """

    when 'forOf'
      bodyCode = node.body
        .map((c) -> _compile(c) + ';')
        .join('')
      """
      for(var __i in #{_compile node.right}) {
        #{if node.second? then "var #{node.second.value} = __i;" else ""}
        var #{node.left.value} = #{_compile node.right}[__i];
        #{bodyCode};
      }
      """

    when 'comment'
      "/* #{node.value} */"

    when 'string'
      "\'#{node.value}\'"
    when 'number'
      "#{node.value}"
    when 'boolean'
      "#{node.value}"
    when 'identifier'
      node.value
    when 'thisIdentifier'
      "self\.#{node.value}"
    else
      throw 'unknow node: ' + node.type

recast = require 'recast'
# ProgramNode => string
module.exports = (node, options = {}) ->
  exportTarget = options.export ? 'module.exports'
  # node
  recast.print(node).code
