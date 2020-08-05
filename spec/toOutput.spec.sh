import @expect/matchers/toOutput

@spec.toOutput.noArguments() {
  refute run expect { echo 5 } toOutput
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toOutput expects 1 or more arguments, received 0" ]

  refute run expect { echo 5 } toOutput toStdout
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toOutput expects 1 or more arguments, received 0" ]

  refute run expect { echo 5 } toOutput toSTDOUT
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toOutput expects 1 or more arguments, received 0" ]

  refute run expect { echo 5 } toOutput toStderr
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toOutput expects 1 or more arguments, received 0" ]

  refute run expect { echo 5 } toOutput toSTDERR
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toOutput expects 1 or more arguments, received 0" ]
}

@spec.toOutput() {
  assert run expect { echo 5 } toOutput 5
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run expect { echo 5 } toOutput "Wrong value"
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "Expected output to contain text\nOutput: '5$\n$'\nExpected text: 'Wrong value$'" ]

  # check multiple values (like toContain)
}

@pending.not.toOutput() {
  :
}

@pending.singleCurliesRunLocally() {
  local x=5

  expect { x=42 && echo "$x" } toOutput "42"

  assert [ "$x" = 42 ] # value was updated
}

@pending.doubleCurliesRunInSubshell() {
  local x=5

  expect {{ x=42 && echo "$x" }} toOutput "42"

  assert [ "$x" = 5 ] # value was not updated
}