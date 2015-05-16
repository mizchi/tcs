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

and many corner bugs of parser.

Advanced tasks

- [ ] if expression
- [ ] switch expression
- [ ] class expression
- [ ] JSX

## Example

```coffee
myFunc(a: number, b: number): number
  a + b

class X
  static x()
    a

  foo() { a }

  get x()
    x

  set y(y:number)
    y

var x = new X()
setTimeout(() =>
  console.log('foo')
, 1000)
```

## LICENSE

MIT
