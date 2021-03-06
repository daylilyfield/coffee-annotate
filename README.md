coffee-annotate
===============

coffee-annotate supports to annotate coffee-script methods (and functions).  

How to Install
--------------

```bash
npm i -S coffee-annotate
```

How to Use
----------

### Inheritance Usage

coffee-annotate stores annotation informations into the method property named `annotations`.

```coffeescript
annotate = require 'coffee-annotate'

class A

  @foo: annotate 'foo'

class B extends A

  @foo(key: 'value') \
  doStuff: ->
    # do something

b = new B

console.log b.doStuff.annotations.foo # print {key: 'value'}
```

of course, you can decorate the method.

```coffeescript
annotate = require 'coffee-annotate'

class A

  @log: annotate 'log', (target, annotations) -> (args...) ->
    console.log "enter #{target.name} "
    result = target.body.apply @, args
    console.log "exit #{target.name}"
    result

class B extends A

  @log() \
  doStuff: ->
    # do something

b = new B

b.doStuff() # print 'enter doStuff' and 'exit doStuff'
```

### Non-Inheritance Usage

i know you don't like to use inheritance to apply annotations to methods. coffee-annotate doesn't need to use annotations inherited from parent class.

```coffeescript
x = annotate.class.noAttr 'x'
y = annotate 'y'
z = annotate 'z'

x class A

 y(key: 'y') \
 z(key: 'z') \
 doStuff: ->
   # do something

a = new A

console.log a.annotations.x? # print true
console.log a.doStuff.annotations.y # print {key: 'y'}
console.log a.doStuff.annotations.z # print {key: 'z'}
```

### Just Function

if you don't annotate methods but functions, sure you can.

```coffeescript
annotate = require 'coffee-annotate'

$foo = annotate 'foo'

doStuff = $foo(key: 'value') ->
  # do something

console.log doStuff.annotations.foo # print {key: 'value'}
```

### Without Attributes

if your annotation don't need to accept any attributes, you can write annotations with `annotate.noAttr` function.

```coffeescript
annotate = require 'coffee-annotate'

class A

  @foo: annotate.noAttr 'foo'

class B extends A

  @foo \
  doStuff: ->
    # do something

b = new B

console.log b.doStuff.annotations.foo # print {key: 'value'}
```

API
---

### annotate(name, decorator)

- name: String

  `name` is the key of `annotations` property.

- decorator: ({name: String, body: Function}, attributes: Any): Function

  `decorator` for the actual method or function. it must return a function even
  if you don't need to decorate the function. this parameter is optional.

  `name` property is the annotated function's name. and `body` property is the 
  function which is annotated. `attributes` parameter is annotation's
  arguments, so it could be any type.

### annotate.noAttr(name, decorator)

same as `annotate` but the annotation can't accept any attributes. 

### annotate.class(name, decorator)

- name: String

  `name` is key of `annotations` property for constructor function aka class. 

- decorator: (clazz: Function), attributes: Any): Function

  `decorator` for the actual class. it must return a constructor function even 
  if you don't need to decorate the constructor function. this parameter is
  optional.

  `clazz` property is the annotationed constructor function. `attributes`
  parameter is annotation's arguments, so it could be any type.

### annotate.class.noAttr(name, decorator)

same as `annotate.class` but the annotation can't accept any attributes.


How to Test
-----------

```bash
npm test
```

How to Build
------------

```bash
npm build
```

License
-------

The MIT License (MIT)

Copyright (c) 2015 daylilyfield

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
