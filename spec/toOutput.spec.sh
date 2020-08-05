import @expect/matchers/toOutput

@spec.toOutput.noArguments() {
  refute run -- expect { echo 5 } toOutput
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toOutput expects 1 or more arguments, received 0" ]

  refute run -- expect { echo 5 } toOutput toStdout
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toOutput expects 1 or more arguments, received 0" ]

  refute run -- expect { echo 5 } toOutput toSTDOUT
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toOutput expects 1 or more arguments, received 0" ]

  refute run -- expect { echo 5 } toOutput toStderr
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toOutput expects 1 or more arguments, received 0" ]

  refute run -- expect { echo 5 } toOutput toSTDERR
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toOutput expects 1 or more arguments, received 0" ]
}

@spec.toOutput() {
  assert run -- expect { echo 5 } toOutput 5
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run -- expect { echo 5 } toOutput "Wrong value"
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected output to contain text"
  assert stderrContains "Output: '5"
  assert stderrContains "Expected text: 'Wrong value"

  assert run -- expect { echo "Hello, world!" } toOutput "Hello" "world"
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run -- expect { echo "Hello, world!" } toOutput "Hello" "moon"
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected output to contain text"
  assert stderrContains "Output: 'Hello, world!"
  assert stderrContains "Expected text: 'moon"

  refute run -- expect { echo "Hello, world!" } toOutput "Goodnight" "moon"
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected output to contain text"
  assert stderrContains "Output: 'Hello, world!"
  assert stderrContains "Expected text: 'Goodnight"
}

@spec.not.toOutput() {
  refute run -- expect { echo "Hello, world!" } not toOutput "Hello" "world"
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected output not to contain text"
  assert stderrContains "Output: 'Hello, world!"
  assert stderrContains "Unexpected text: 'Hello"

  refute run -- expect { echo "Hello, world!" } not toOutput "Goodnight" "world"
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected output not to contain text"
  assert stderrContains "Output: 'Hello, world!"
  assert stderrContains "Unexpected text: 'world"

  assert run -- expect { echo "Hello, world!" } not toOutput "Goodnight" "moon"
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]
}

@spec.toOutput.toSTDOUT() {
  assert run -- expect { echo 5 } toOutput toStdout 5
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run -- expect { echo 5 } toOutput toStdout "Wrong value"
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected STDOUT to contain text"
  assert stderrContains "STDOUT: '5"
  assert stderrContains "Expected text: 'Wrong value"

  assert run -- expect { echo "Hello, world!" } toOutput toStdout "Hello" "world"
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run -- expect { echo "Hello, world!" } toOutput toStdout "Hello" "moon"
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected STDOUT to contain text"
  assert stderrContains "STDOUT: 'Hello, world!"
  assert stderrContains "Expected text: 'moon"

  refute run -- expect { echo "Hello, world!" } toOutput toStdout "Goodnight" "moon"
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected STDOUT to contain text"
  assert stderrContains "STDOUT: 'Hello, world!"
  assert stderrContains "Expected text: 'Goodnight"
}

error() {
  echo "$@" >&2
}

@spec.toOutput.toSTDERR() {
  assert run -- expect { error 5 } toOutput toStderr 5
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run -- expect { error 5 } toOutput toStderr "Wrong value"
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected STDERR to contain text"
  assert stderrContains "STDERR: '5"
  assert stderrContains "Expected text: 'Wrong value"

  assert run -- expect { error "Hello, world!" } toOutput toStderr "Hello" "world"
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run -- expect { error "Hello, world!" } toOutput toStderr "Hello" "moon"
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected STDERR to contain text"
  assert stderrContains "STDERR: 'Hello, world!"
  assert stderrContains "Expected text: 'moon"

  refute run -- expect { error "Hello, world!" } toOutput toStderr "Goodnight" "moon"
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected STDERR to contain text"
  assert stderrContains "STDERR: 'Hello, world!"
  assert stderrContains "Expected text: 'Goodnight"
}

setAndEchoX() {
  x="$1"
  echo "$x"
}

@spec.singleCurliesRunLocally() {
  local x=5

  expect { setAndEchoX 42 } toOutput "42"

  assert [ "$x" = 42 ] # value was updated
}

@spec.doubleCurliesRunInSubshell() {
  local x=5

  expect {{ setAndEchoX 42 }} toOutput "42"

  assert [ "$x" = 5 ] # value was not updated
}