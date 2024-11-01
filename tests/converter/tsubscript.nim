# issue #22970

converter toString(a: seq[byte]): string {.inline.} = cast[ptr string](a.addr)[]

var query = @[byte 1,2,3]
query[0..1] = @[byte 8,8]
doAssert $query == "@[8, 8, 3]"

template inspect(x: typed) =
  doAssert x is seq[byte]
  doAssert x[0] is byte
  doAssert x[0] isnot char

inspect(query)
