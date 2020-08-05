import @expect/matchers/toEqual

@spec.toEqual.wrong_number_of_arguments() {
  refute run expect 5 toEqual
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toEqual expects 1 argument (expected result), received 0 []" ]
  
  refute run expect 5 toEqual too many arguments
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toEqual expects 1 argument (expected result), received 3 [too many arguments]" ]
}

@spec.toEqual() {
  assert run expect 5 toEqual 5
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run expect 5 toEqual "Wrong value"
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "Expected results to equal\nActual: '5'\nExpected: 'Wrong value'" ]
}

@pending.toEqual.newlines_and_tabs_etc() {
  :
}

@spec.not.toEqual() {
  assert run expect 5 not toEqual "Wrong value"
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run expect 5 not toEqual 5
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "Expected results not to equal\nActual: '5'\nExpected: '5'" ]
}