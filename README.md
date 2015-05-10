# tcs

WIP: heavily under development

coffeescript for es6 age

## Features

- compile to flowtype code with type annotation

## Example

```coffee
class X
  static x()
    a
  foo()
    a
  get x()
    x
  set y(y:number)
    y

func(a, b)
  a

func(a: number, b: number): number
  a + b
```

## LICENSE

MIT
