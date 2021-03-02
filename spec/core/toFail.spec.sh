# GENERATED - DO NOT EDIT
source matchers/toFail.sh

thisFails() {
  echo "I am the STDERR! Hello, world!" >&2
  echo "I am the STDOUT! Goodnight, moon!"
  return 1
}

thisPasses() {
  echo "Hello from a passing function!"
  return 0
}

@spec.toFail() {
  refute run [[ expect "Forgot to pass a block" toFail ]]
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toFail requires a block" ]

  refute run [[ expect { thisPasses } toFail ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected to fail, but passed"
  assert stderrContains "Command: thisPasses"
  assert stderrContains "STDOUT: Hello from a passing function!"

  assert run [[ expect { thisFails } toFail ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  assert run [[ expect { thisFails } toFail "Hello" ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  assert run [[ expect { thisFails } toFail "Hello" "world" ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run [[ expect { thisFails } toFail "Hello" "moon" ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected STDERR to contain text"
  assert stderrContains "Command: thisFails"
  assert stderrContains "STDERR: 'I am the STDERR! Hello, world!"
  assert stderrContains "Expected text: 'moon"
}

setAndEchoXAndFail() {
  x="$1"
  echo "$x" >&2
  return 1
}

@spec.singleCurliesRunLocally() {
  local x=5

  expect { setAndEchoXAndFail 42 } toFail "42"

  assert [ "$x" = 42 ] # value was updated

  # Works fine with failing commands!
  run expect { thisCommandDoesNotExist &>/dev/null } toFail ""
  assert [ $EXITCODE -eq 0 ]
}

@spec.doubleCurliesRunInSubshell() {
  local x=5

  expect {{ setAndEchoXAndFail 42 }} toFail "42"

  assert [ "$x" = 5 ] # value was not updated

  # Works fine with failing commands!
  run expect {{ thisCommandDoesNotExist &>/dev/null }} toFail ""
  assert [ $EXITCODE -eq 0 ]
}

@spec.singleBracketsRunLocally() {
  local x=5

  expect [ setAndEchoXAndFail 42 ] toFail "42"

  assert [ "$x" = 42 ] # value was updated

  # Works fine with failing commands!
  run expect [ thisCommandDoesNotExist &>/dev/null ] toFail ""
  assert [ $EXITCODE -eq 0 ]
}

@spec.doubleBracketsRunInSubshell() {
  local x=5

  expect [[ setAndEchoXAndFail 42 ]] toFail "42"

  assert [ "$x" = 5 ] # value was not updated

  # Works fine with failing commands!
  run expect [[ thisCommandDoesNotExist &>/dev/null ]] toFail ""
  assert [ $EXITCODE -eq 0 ]
}