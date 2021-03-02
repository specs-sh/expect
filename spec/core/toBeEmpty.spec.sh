# GENERATED - DO NOT EDIT
source matchers/toBeEmpty.sh

@spec.toBeEmpty.wrong_number_of_arguments() {
  refute run [[ expect 5 toBeEmpty arg ]]
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toBeEmpty expects 0 arguments, received 1 [arg]" ]
}

@spec.toBeEmpty() {
  assert run [[ expect "" toBeEmpty ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run [[ expect "foo" toBeEmpty ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result to be empty"
  assert stderrContains "Actual: 'foo'"

  assert run [[ expect { echo "" } toBeEmpty ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run [[ expect { echo "foo" } toBeEmpty ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result to be empty"
  assert stderrContains "Actual: 'foo'"

  assert run [[ expect {{ echo "" }} toBeEmpty ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run [[ expect {{ echo "foo" }} toBeEmpty ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result to be empty"
  assert stderrContains "Actual: 'foo'"
}


@spec.not.toBeEmpty() {
  assert run [[ expect "foo" not toBeEmpty ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run [[ expect "" not toBeEmpty ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result not to be empty"
  assert stderrContains "Actual: ''"

  assert run [[ expect { echo "foo" } not toBeEmpty ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run [[ expect { echo "" } not toBeEmpty ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result not to be empty"
  assert stderrContains "Actual: ''"

  assert run [[ expect {{ echo "foo" }} not toBeEmpty ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run [[ expect {{ echo "" }} not toBeEmpty ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result not to be empty"
  assert stderrContains "Actual: ''"
}

setAndEchoX() {
  x="$1"
}

@spec.singleCurliesRunLocally() {
  local x=5

  expect { setAndEchoX 42 } toBeEmpty

  assert [ "$x" = 42 ] # value was updated

  # Fails if the command fails (even though it does return 'empty')
  run expect { thisCommandDoesNotExist &>/dev/null } toBeEmpty
  assert [ $EXITCODE -eq 1 ]
  [[ $STDERR = *"thisCommandDoesNotExist: command not found"* ]] || { echo "Command did not output expected error text" >&2; return 1; }
}

@spec.doubleCurliesRunInSubshell() {
  local x=5

  expect {{ setAndEchoX 42 }} toBeEmpty

  assert [ "$x" = 5 ] # value was not updated

  # Fails if the command fails (even though it does return 'empty')
  run expect {{ thisCommandDoesNotExist &>/dev/null }} toBeEmpty
  assert [ $EXITCODE -eq 1 ]
  [[ $STDERR = *"thisCommandDoesNotExist: command not found"* ]] || { echo "Command did not output expected error text" >&2; return 1; }
}

@spec.singleBracketsRunLocally() {
  local x=5

  expect [ setAndEchoX 42 ] toBeEmpty

  assert [ "$x" = 42 ] # value was updated

  # Fails if the command fails (even though it does return 'empty')
  run expect [ thisCommandDoesNotExist &>/dev/null ] toBeEmpty
  assert [ $EXITCODE -eq 1 ]
  [[ $STDERR = *"thisCommandDoesNotExist: command not found"* ]] || { echo "Command did not output expected error text" >&2; return 1; }
}

@spec.doubleBracketsRunInSubshell() {
  local x=5

  expect [[ setAndEchoX 42 ]] toBeEmpty

  assert [ "$x" = 5 ] # value was not updated

  # Fails if the command fails (even though it does return 'empty')
  run expect [[ thisCommandDoesNotExist &>/dev/null ]] toBeEmpty
  assert [ $EXITCODE -eq 1 ]
  [[ $STDERR = *"thisCommandDoesNotExist: command not found"* ]] || { echo "Command did not output expected error text" >&2; return 1; }
}