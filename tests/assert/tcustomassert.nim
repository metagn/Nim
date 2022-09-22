discard """
  output: '''
custom assertion defect
msg: false was false, custom message
second custom assertion defect
msg: false was false, custom message 2
first custom assertion defect
msg: false was false, custom message 3
assertion defect
'''
"""

block:
  type CustomAssertionDefect = object of Defect
  template assertImpl(cond, customMsg): untyped =
    if not cond:
      raise (ref CustomAssertionDefect)(msg: astToStr(cond) & " was false, " & customMsg)
  try:
    assert false, "custom message"
    echo "should not be here"
  except AssertionDefect:
    echo "assertion defect"
  except CustomAssertionDefect as e:
    echo "custom assertion defect"
    echo "msg: ", e.msg
  except:
    echo "unknown exception"

  block:
    type SecondCustomAssertionDefect = object of Defect
    template assertImpl(cond, customMsg): untyped =
      if not cond:
        raise (ref SecondCustomAssertionDefect)(msg: astToStr(cond) & " was false, " & customMsg)
    try:
      assert false, "custom message 2"
      echo "should not be here"
    except AssertionDefect:
      echo "assertion defect"
    except CustomAssertionDefect:
      echo "first custom assertion defect"
    except SecondCustomAssertionDefect as e:
      echo "second custom assertion defect"
      echo "msg: ", e.msg
    except:
      echo "unknown exception"
  
  try:
    assert false, "custom message 3"
    echo "should not be here"
  except AssertionDefect:
    echo "assertion defect"
  except CustomAssertionDefect as e:
    echo "first custom assertion defect"
    echo "msg: ", e.msg
  except:
    echo "unknown exception"

block:
  try:
    assert false
    echo "should not be here"
  except AssertionDefect:
    echo "assertion defect"
  except:
    echo "unknown exception"
