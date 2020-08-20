import @expect/matchers/toContain

@spec.toContain.wrong_number_of_arguments() {
  refute run -- expect "Hi" toContain
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toContain expects 1 or more arguments, received 0 []" ]
}

@spec.toContain() {
  assert run -- expect "Hello, world!" toContain "Hello" "world"
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run -- expect "Goodnight, moon!" toContain "Hello" "world"
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result to contain text"
  assert stderrContains "Actual text: 'Goodnight, moon!'"
  assert stderrContains "Expected text: 'Hello'"

  refute run -- expect "Goodnight, moon!" toContain "Goodnight" "world"
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result to contain text"
  assert stderrContains "Actual text: 'Goodnight, moon!'"
  assert stderrContains "Expected text: 'world'"

  assert run -- expect { echo "Hi There" } toContain Hi There
  refute run -- expect { echo "Hi There" } not toContain Hi There

  assert run -- expect { echo "Hi There" } not toContain Foo Bar
  refute run -- expect { echo "Hi There" } toContain Foo Bar

  assert run -- expect {{ echo "Hi There" }} toContain Hi There
  refute run -- expect {{ echo "Hi There" }} not toContain Hi There

  assert run -- expect {{ echo "Hi There" }} not toContain Foo Bar
  refute run -- expect {{ echo "Hi There" }} toContain Foo Bar
}

@spec.toContain.newlines_and_tabs_etc() {
  refute run -- expect "Hello\tworld" toContain "Goodnight\nmoon"
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result to contain text"
  assert stderrContains "Actual text: 'Hello^Iworld'"
  assert stderrContains "Expected text: 'Goodnight"
}

@spec.not.toContain() {
  assert run -- expect "Hello, world!" not toContain "Goodnight" "moon"
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run -- expect "Hello, world!" not toContain "Goodnight" "world"
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result not to contain text"
  assert stderrContains "Actual text: 'Hello, world!'"
  assert stderrContains "Unexpected text: 'world'"
}

setAndEchoX() {
  x="$1"
  echo "$x"
}

@spec.singleCurliesRunLocally() {
  local x=5

  expect { setAndEchoX 42 } toContain "42"

  assert [ "$x" = 42 ] # value was updated
}

@spec.doubleCurliesRunInSubshell() {
  local x=5

  expect {{ setAndEchoX 42 }} toContain "42"

  assert [ "$x" = 5 ] # value was not updated
}

@spec.singleBracketsRunLocally() {
  local x=5

  expect [ setAndEchoX 42 ] toContain "42"

  assert [ "$x" = 42 ] # value was updated
}

@spec.doubleBracketsRunInSubshell() {
  local x=5

  expect [[ setAndEchoX 42 ]] toContain "42"

  assert [ "$x" = 5 ] # value was not updated
}