@spec.toMatch.wrong_number_of_arguments() {
  refute run [[ expect "Hello" toMatch ]]
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toMatch expects at least 1 argument (BASH regex patterns), received 0 []" ]
}

@spec.toMatch() {
  assert run [[ expect "Hello there 123" toMatch "Hello" 'there[[:space:]][0-9][0-9][0-9]' ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run [[ expect "Hello there 123" toMatch "Hello" 'there[[:space:]][0-9][0-9][0-9]' 'foo' ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result to match"
  assert stderrContains "Actual text: 'Hello there 123'"
  assert stderrContains "Pattern: 'foo'"

  assert run [[ expect { echo "Hello there 123" } toMatch "Hello" 'there[[:space:]][0-9][0-9][0-9]' ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run [[ expect { echo "Hello there 123" } toMatch "Hello" 'there[[:space:]][0-9][0-9][0-9]' 'foo' ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result to match"
  assert stderrContains "Actual text: 'Hello there 123"
  assert stderrContains "Pattern: 'foo'"

  assert run [[ expect {{ echo "Hello there 123" }} toMatch "Hello" 'there[[:space:]][0-9][0-9][0-9]' ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run [[ expect {{ echo "Hello there 123" }} toMatch "Hello" 'there[[:space:]][0-9][0-9][0-9]' 'foo' ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result to match"
  assert stderrContains "Actual text: 'Hello there 123"
  assert stderrContains "Pattern: 'foo'"
}

@spec.not.toMatch() {
  assert run [[ expect "Hello there 123" not toMatch 'foo' ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run [[ expect "Hello there 123" not toMatch 'there[[:space:]][0-9][0-9][0-9]' ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result not to match"
  assert stderrContains "Actual text: 'Hello there 123'"
  assert stderrContains "Pattern: 'there[[:space:]][0-9][0-9][0-9]'"

  assert run [[ expect { echo "Hello there 123" } not toMatch 'foo' ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run [[ expect { echo "Hello there 123" } not toMatch 'there[[:space:]][0-9][0-9][0-9]' ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result not to match"
  assert stderrContains "Actual text: 'Hello there 123"
  assert stderrContains "Pattern: 'there[[:space:]][0-9][0-9][0-9]'"
}

setAndEchoX() {
  x="$1"
  echo "$x"
}

@spec.singleCurliesRunLocally() {
  local x=5

  expect { setAndEchoX 42 } toMatch "42"

  assert [ "$x" = 42 ] # value was updated

  # Fails if the command fails (even though it does return 'empty')
  run expect { thisCommandDoesNotExist &>/dev/null } toMatch ""
  assert [ $EXITCODE -eq 1 ]
  [[ $STDERR = *"thisCommandDoesNotExist: command not found"* ]] || { echo "Command did not output expected error text" >&2; return 1; }
}

@spec.doubleCurliesRunInSubshell() {
  local x=5

  expect {{ setAndEchoX 42 }} toMatch "42"

  assert [ "$x" = 5 ] # value was not updated

  # Fails if the command fails (even though it does return 'empty')
  run expect {{ thisCommandDoesNotExist &>/dev/null }} toMatch ""
  assert [ $EXITCODE -eq 1 ]
  [[ $STDERR = *"thisCommandDoesNotExist: command not found"* ]] || { echo "Command did not output expected error text" >&2; return 1; }
}

@spec.singleBracketsRunLocally() {
  local x=5

  expect [ setAndEchoX 42 ] toMatch "42"

  assert [ "$x" = 42 ] # value was updated

  # Fails if the command fails (even though it does return 'empty')
  run expect [ thisCommandDoesNotExist &>/dev/null ] toMatch ""
  assert [ $EXITCODE -eq 1 ]
  [[ $STDERR = *"thisCommandDoesNotExist: command not found"* ]] || { echo "Command did not output expected error text" >&2; return 1; }
}

@spec.doubleBracketsRunInSubshell() {
  local x=5

  expect [[ setAndEchoX 42 ]] toMatch "42"

  assert [ "$x" = 5 ] # value was not updated

  # Fails if the command fails (even though it does return 'empty')
  run expect [[ thisCommandDoesNotExist &>/dev/null ]] toMatch ""
  assert [ $EXITCODE -eq 1 ]
  [[ $STDERR = *"thisCommandDoesNotExist: command not found"* ]] || { echo "Command did not output expected error text" >&2; return 1; }
}