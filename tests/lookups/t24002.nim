discard """
  action: compile # for now just test that it compiles
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
