# tcs

Tiny and typed CoffeeScript like language. Script for ES6 age.

WIP: heavily under development

## Features

- compile to flowtype code with type annotation
- It's a just parser for flowtype ast.

## Compare with coffeescript

### **YES**

- indent style in function, class, interface
- type annotation and typecheck by flowtype
- implicit return in function
- `@` is this

### **NO**

- `parentheses less implicit function call` - it is a bit difficult for parser
- `implicit variable declaration` - we may want to use let, const, var or other I don't know yet.
- `for expression` - use Array.prototype.map

### TODO

- regexp expression
- member access after func call `foo().bar`
- sourcemap
- cli interface
- gulp
- browserify
- genrator
- destructive assingment
- raw js expression

and many corner bugs of parser.

Advanced tasks

- if expression
- switch expression
- class expression
- JSX
- Pattern match

## Example

```coffee
# this is comment

# expr

1
a.b
(a()).b
1 > 2
{}
{a: 1, b: 2}
{
  c: 1
  d: 2
}

# assignment with type annotation
var x1 = 3
var x2: number = 3

# Can declare let and const but flowtype can't parse them yet
let y = 2

# function
myFunc(a: number, b: number): number
  # return last expression
  a + b

() => 1

setTimeout(() =>
  myFunc(1, 2)
, 1000)

# class
class X<T>
  n: number
  _x: T
  static staticFunc() {}

  foo<U>()
    a

  get prop() {this._x}

  set prop(_x:number)
    @._x = x

class Y extends X<number>
  constructor()
    super()

var y = new Y()

# interface
interface Point
  x: number
  y: number

interface Point3d extends Point
  z: number

# if
if true
  a
else if false
  b
else if false
  c
else
  d

# switch
switch e
  when 1
    a
  when 2
    a
  else
    a

# for
for var i in items
  print(i)
# for of is same with es6, not coffee
for i of items
  print(i)

# module
import x from './x'
export default {}
```

## LICENSE

MIT
