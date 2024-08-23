discard """
  action: compile # for now just test that it compiles
  nimout: '''
t24002.nim(26, 27) template/generic instantiation of `unrecognizedFieldWarning` from here
t24002.nim(23, 15) Warning: ambiguous identifier: 'value' -- use one of the following:
  t24002.value: proc (self: Result[value.T, value.E]): T{.inline, noSideEffect.}
  t24002.value: proc (self: var Result[value.T, value.E]): var T: not void{.inline, noSideEffect.}
this expression will have the invalid type 'None' for typeof [AmbiguousTypeof]
'''
"""

# issue #24002

type Result[T, E] = object

func value*[T, E](self: Result[T, E]): T {.inline.} =
  discard

func value*[T: not void, E](self: var Result[T, E]): var T {.inline.} =
  discard

template unrecognizedFieldWarning =
  echo typeof value

proc readValue*(value: var int) =
  unrecognizedFieldWarning()

var foo: int
readValue(foo)
