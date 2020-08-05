import @expect/matchers/toMatch

@spec.toMatch.wrong_number_of_arguments() {
  refute run -- expect "Hello" toMatch
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toMatch expects at least 1 argument (BASH regex patterns), received 0 []" ]
}

@spec.toMatch() {
  assert run -- expect "Hello there 123" toMatch "Hello" 'there[[:space:]][0-9][0-9][0-9]'
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run -- expect "Hello there 123" toMatch "Hello" 'there[[:space:]][0-9][0-9][0-9]' 'foo'
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result to match"
  assert stderrContains "Actual text: 'Hello there 123'"
  assert stderrContains "Pattern: 'foo'"

  assert run -- expect { echo "Hello there 123" } toMatch "Hello" 'there[[:space:]][0-9][0-9][0-9]'
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run -- expect { echo "Hello there 123" } toMatch "Hello" 'there[[:space:]][0-9][0-9][0-9]' 'foo'
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result to match"
  assert stderrContains "Actual text: 'Hello there 123"
  assert stderrContains "Pattern: 'foo'"

  assert run -- expect {{ echo "Hello there 123" }} toMatch "Hello" 'there[[:space:]][0-9][0-9][0-9]'
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run -- expect {{ echo "Hello there 123" }} toMatch "Hello" 'there[[:space:]][0-9][0-9][0-9]' 'foo'
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result to match"
  assert stderrContains "Actual text: 'Hello there 123"
  assert stderrContains "Pattern: 'foo'"
}

@spec.not.toMatch() {
  assert run -- expect "Hello there 123" not toMatch 'foo'
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run -- expect "Hello there 123" not toMatch 'there[[:space:]][0-9][0-9][0-9]'
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result not to match"
  assert stderrContains "Actual text: 'Hello there 123'"
  assert stderrContains "Pattern: 'there[[:space:]][0-9][0-9][0-9]'"

  assert run -- expect { echo "Hello there 123" } not toMatch 'foo'
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run -- expect { echo "Hello there 123" } not toMatch 'there[[:space:]][0-9][0-9][0-9]'
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result not to match"
  assert stderrContains "Actual text: 'Hello there 123"
  assert stderrContains "Pattern: 'there[[:space:]][0-9][0-9][0-9]'"
}