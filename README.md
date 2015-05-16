# tcs

WIP: heavily under development

coffeescript like language with typecheck. for es6 age.

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

Basic

- [ ] regexp expression
- [ ] type expression

Advanced

- [ ] if expression
- [ ] class expression
- [ ] JSX

and million bugs.

## Example

```coffee
myFunc(a: number, b: number): number
  a + b

class X
  static x()
    a

  foo()
    a

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
