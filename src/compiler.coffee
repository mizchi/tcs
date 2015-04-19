# postprocess
Babel = require "babel-core"
camelize = require 'camelize'

transformCode = (code) ->
  Babel.transform(code)
    .code
    .replace('\"use strict\";\n', '')
    .replace('\'use strict\';\n', '')

buildProps = (node) ->
  obj = {}
  classNames = []

  if node.props?
    obj.__mergeables = node.props.children.filter (p) -> p.type is 'mergeable-object'

    props = node.props.children.filter (p) -> p.type is 'property'
    for i in props
      if i.key is 'className'
        classNames.push i.expr
      else
        obj[i.key] = compile(i.expr)

  # style
  if node.styles?
    style = {}
    for s in node.styles.children
      # camelize for react style
      style[camelize s.key] = compile(s.expr)
    obj.style = style

  # classes and id
  if node.value?.modifiers?
    for m in node.value.modifiers
      switch m.type
        when 'className' then classNames.push {type:'string', value: m.value}
        when 'id'  then obj.id  = '\'' + m.value + '\''
        when 'ref' then obj.ref = '\'' + m.value + '\''
        when 'key' then obj.key = '\'' + m.value + '\''
  if classNames.length > 0
    code = classNames
      .map((e) -> compile(e))
      .join(',')
    obj.className = '[' + code + '].join("")'
  obj

_wrapStr = (s) -> '\'' + s + '\''
expandObj = (obj) ->
  kv =
    for k, v of obj when k not in ['__mergeables']
      if v instanceof Object
        _wrapStr(k) + ': ' + expandObj(v)
      else
        _wrapStr(k) + ':' + v
  ret = '{' + kv.join(',') + '}'
  if obj.__mergeables?.length
    objs = obj.__mergeables
      .map((m) -> m.key)
      .join(',')
    "__extend({}, #{objs}, #{ret})"
  else
    ret

isUpperCase = (text) ->
  text.toUpperCase() is text

module.exports = compile = (node) ->
  switch node.type
    when 'program'
      codes = node.body.map (n) -> compile(n)
      """
      function(__props) {
        if(__props == null) __props = {};
        return __runtime(function($){
          #{codes.join('\n')}
        });
      }
      """
    when 'element'
      props = buildProps(node)
      propsStr = expandObj props
      elementType =
        if isUpperCase(node.value.elementType[0])
          compile(type:'identifier', value:node.value.elementType)
        else
          node.value.elementType

      unless node.children
        return "$('#{elementType}', #{propsStr})"

      if node.children.type in ['identifier', 'boolean', 'number', 'string', 'inlineText', 'embededCode']
        return "$('#{elementType}', #{propsStr}, #{compile node.children})"

      children = node.children.map (child) -> compile(child)
      childrenCode = 'function(){' + (children?.join(';') ? '') + ';}'
      "$('#{elementType}', #{propsStr}, #{childrenCode})"

    when 'code'
      transformCode node.value

    when 'multilineCode'
      transformCode node.value

    when 'embededExpr'
      node.value

    when 'free'
      node.value

    when 'if'
      children = node.body.map (child) -> compile(child)
      childrenCode = children.join(';')
      condCode = compile node.condition

      """
      if(#{condCode}) { #{childrenCode} }
      """

    when 'forIn'
      bodyCode = node.body
        .map((c) -> compile(c) + ';')
        .join('')
      """
      for(var __i in #{compile node.right}) {
        #{if node.second? then "var #{node.second.value} = __i;" else ""}
        var #{node.left.value} = #{compile node.right}[__i];
        #{bodyCode};
      }
      """

    when 'forOf'
      bodyCode = node.body
        .map((c) -> compile(c) + ';')
        .join('')
      """
      for(var __i in #{compile node.right}) {
        #{if node.second? then "var #{node.second.value} = __i;" else ""}
        var #{node.left.value} = #{compile node.right}[__i];
        #{bodyCode};
      }
      """

    when 'comment'
      "/* #{node.value} */"

    when 'text'
      "$('span', {}, '#{node.value}')"

    when 'inlineText'
      "\'#{node.value}\'"

    when 'string'
      "\'#{node.value}\'"
    when 'number'
      "#{node.value}"
    when 'boolean'
      "#{node.value}"
    when 'identifier'
      node.value
    when 'thisIdentifier'
      "__props\.#{node.value}"
    else
      throw 'unknow node: ' + node.type
