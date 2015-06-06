annotate = require '../src'

describe 'coffee-annotate', ->

  it 'should read an annotation on method', ->

    found = no

    class A

      @x = annotate 'x', (t) -> found = yes; t.body

    class B extends A

      @x(k: 'v') \
      y: -> 'y'

    b = new B

    expect(b.y()).toBe 'y'
    expect(b.y.annotations.x).toBeDefined
    expect(b.y.annotations.x.k).toBe 'v'
    expect(found).toBe yes

  
  it 'should read annotations on method', ->

    foundx = no
    foundy = no

    class A

      @x = annotate 'x', (t) -> foundx = yes; t.body
      @y = annotate 'y', (t) -> foundy = yes; t.body

    class B extends A

      @x(kx: 'vx') \
      @y(ky: 'vy') \
      z: -> 'z'

    b = new B

    expect(b.z()).toBe 'z'
    expect(b.z.annotations.x).toBeDefined
    expect(b.z.annotations.x.kx).toBe 'vx'
    expect(foundx).toBe yes

    expect(b.z.annotations.y).toBeDefined
    expect(b.z.annotations.y.ky).toBe 'vy'
    expect(foundy).toBe yes


  it 'should decorate the method', ->

    class A

      @x = annotate 'x', (t, as) -> (args...) ->
        r = t.body.apply @, args
        'x' + as.k + r

    class B extends A

      @x(k: 'v') \
      y: -> 'y'

    b = new B

    expect(b.y()).toBe 'xvy'


  it 'should read an annotation on function', ->

    found = yes

    x = annotate 'x', (t) -> found = yes; t.body

    z = x(k: 'v') -> 'z'

    expect(z()).toBe 'z'
    expect(z.annotations.x).toBeDefined
    expect(z.annotations.x.k).toBe 'v'
    expect(found).toBe yes

