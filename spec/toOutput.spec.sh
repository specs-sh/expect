import @expect/matchers/toOutput

@pending.toOutput() {
  assert run expect { echo 5 } toOutput 5
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run expect { echo 5 } toOutput "Wrong value"
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "????" ]
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