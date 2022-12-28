discard """
  targets: "c cpp js"
"""

import std/[assertions, sequtils]

proc test() =
  block:
    proc ok(_, _, a: int): int =
      doAssert not compiles(_)
      a
    doassert ok(4, 2, 5) == 5

  block:
    proc ok(_: int, _: int, a: int): int = a
    doAssert ok(4, 2, 5) == 5

  block:
    proc ok(_: int, _: float, a: int): int = a
    doAssert ok(1, 2.0, 5) == 5

  block:
    proc ok(_: int, _: float, _: string, a: int): int = a
    doAssert ok(1, 2.6, "5", 5) == 5
    
  block:
    iterator fn(_, _: int, c: int): int = yield c
    doAssert toSeq(fn(1,2,3)) == @[3]

  block:
    template ok(_, _, a: int): int = a
    doAssert ok(4, 2, 5) == 5

  block:
    doAssert not (compiles do:
      template bad(_: int): int = _
      discard bad(3))

  block:
    template ok(_: int, _: int, a: int): int = a
    doAssert ok(4, 2, 5) == 5

  block:
    template ok(_: int, _: float, a: int): int = a
    doAssert ok(1, 2.0, 5) == 5

  block:
    template ok(_: int, _: float, _: string, a: int): int = a
    doAssert ok(1, 2.6, "5", 5) == 5

proc main() =
  var x = 0

  block:
    proc foo(_, _: int) = x += 5

    foo(1, 2)
    doAssert x == 5

  block:
    proc foo(_: int, _: float) = x += 5

    foo(1, 2)
    doAssert x == 10

  block:
    proc foo(_: int, _: float, _: string) = x += 5

    foo(1, 2, "5")
    doAssert x == 15


when not defined(js):
  static: main()
main()

static: test()
test()
