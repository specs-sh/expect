import @expect/matchers/toBeEmpty

@spec.toBeEmpty.wrong_number_of_arguments() {
  refute run -- expect 5 toBeEmpty arg
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toBeEmpty expects 0 arguments, received 1 [arg]" ]
}

@spec.toBeEmpty() {
  assert run -- expect "" toBeEmpty
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run -- expect "foo" toBeEmpty
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "Expected result to be empty\nActual: 'foo'" ]

  assert run -- expect { echo "" } toBeEmpty
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run -- expect { echo "foo" } toBeEmpty
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "Expected result to be empty\nActual: 'foo'" ]

  assert run -- expect {{ echo "" }} toBeEmpty
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run -- expect {{ echo "foo" }} toBeEmpty
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "Expected result to be empty\nActual: 'foo'" ]
}


@spec.not.toBeEmpty() {
  assert run -- expect "foo" not toBeEmpty
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run -- expect "" not toBeEmpty
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "Expected result not to be empty\nActual: ''" ]

  assert run -- expect { echo "foo" } not toBeEmpty
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run -- expect { echo "" } not toBeEmpty
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "Expected result not to be empty\nActual: ''" ]

  assert run -- expect {{ echo "foo" }} not toBeEmpty
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run -- expect {{ echo "" }} not toBeEmpty
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "Expected result not to be empty\nActual: ''" ]
}