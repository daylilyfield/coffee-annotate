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

and if you don't annotate methods but functions, sure you can.

```coffeescript
annotate = require 'coffee-annotate'

$foo = annotate 'foo'

doStuff = $foo(key: 'value') ->
  # do something

console.log doStuff.annotations.foo # print {key: 'value'}
```

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

  `name` property is the annotation's name. and `body` property is the function
  which is annotated. `attributes` parameter is annotation's arguments, so it
  could be any type.

### annotate.noAttr(name, decorator)

same as `annotate` but annotation can't accept any attributes. 

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
