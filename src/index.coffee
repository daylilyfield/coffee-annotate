assign = require 'object-assign'

id = (x) -> x
returnBody = (target) -> target.body
error = (message) -> throw new Error message

unboundMethods = {}

annotate = (name, decorator = returnBody) -> (attributes) ->
  makeAnalyzer name, decorator, attributes, @


annotate.noAttr = (name, decorator = returnBody) ->
  makeAnalyzer name, decorator, {}

annotate.class = (name, decorator = id) -> (clazz) ->
  clazz::[k] = v for k, v of unboundMethods
  unboundMethods = {}
  decorated = decorator clazz
  decorated.annotations ?= {}
  decorated.annotations[name] = {} #TODO class attributes
  decorated

makeAnalyzer = (name, decorator, attributes, self) -> (functionOrMethod) ->
  target = prepareTarget functionOrMethod

  annotations = target.body.annotations
  decorated = decorator target, attributes
  unless decorated.annotations?
    decorated.annotations = __target: target.name

  decorated.annotations[name] = attributes

  if annotations?
    decorated.annotations = assign {}, decorated.annotations, annotations

  unless decorated.annotations.__target is ''
    self ?= @
    if self::?
      self::[decorated.annotations.__target] = decorated
    else
      unboundMethods[target.name] = decorated

  decorated


prepareTarget = (functionOrMethod) ->
  if typeof functionOrMethod is 'function'
    name: '', body: functionOrMethod
  else
    extractMethod functionOrMethod


extractMethod = (def) ->
  functions = ([k, v] for k, v of def)
  unless functions.length is 1
    error 'annotations must be applyied to a single key & value object.'
  [name, body] = do functions.pop
  {name, body}


module.exports = annotate
