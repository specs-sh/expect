@pending.toEqual() {
  assert run expect 5 toEqual 5
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run expect 5 toEqual "Wrong value"
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "????" ]
}

@pending.not.toEqual() {
  :
}