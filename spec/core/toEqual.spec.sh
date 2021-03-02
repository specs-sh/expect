# GENERATED - DO NOT EDIT
source matchers/toEqual.sh

@spec.toEqual.wrong_number_of_arguments() {
  refute run [[ expect 5 toEqual ]]
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toEqual expects 1 argument (expected result), received 0 []" ]
  
  refute run [[ expect 5 toEqual too many arguments ]]
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toEqual expects 1 argument (expected result), received 3 [too many arguments]" ]
}

@spec.toEqual() {
  assert run [[ expect 5 toEqual 5 ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run [[ expect 5 toEqual "Wrong value" ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result to equal"
  assert stderrContains "Actual: '5'"
  assert stderrContains "Expected: 'Wrong value'"

  assert run [[ expect { echo 5 } toEqual 5 ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run [[ expect { echo 5 } toEqual "Wrong value" ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result to equal"
  assert stderrContains "Actual: '5'"
  assert stderrContains "Expected: 'Wrong value'"

  assert run [[ expect {{ echo 5 }} toEqual 5 ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run [[ expect {{ echo 5 }} toEqual "Wrong value" ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result to equal"
  assert stderrContains "Actual: '5'"
  assert stderrContains "Expected: 'Wrong value'"
}

@pending.toEqual.returnOne() {
  EXPECT_FAIL="return 1"
  set -e

  expect 5 toEqual 5

  # This should make the test fail when run (set @pending to @spec)
  # Example of using EXPECTATION_FAILED to support set -e style testing frameworks
  expect 5 toEqual "Wrong value"

  set +e
}

@spec.toEqual.newlines_and_tabs_etc() {
  refute run [[ expect 5 toEqual "Hello\tI\thave\ttabs" ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result to equal"
  assert stderrContains "Actual: '5'"
  assert stderrContains "Expected: 'Hello^II^Ihave^Itabs'"
}

@spec.not.toEqual() {
  assert run [[ expect 5 not toEqual "Wrong value" ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run [[ expect 5 not toEqual 5 ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result not to equal"
  assert stderrContains "Actual: '5'"
  assert stderrContains "Expected: '5'"

  assert run [[ expect { echo 5 } not toEqual "Wrong value" ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run [[ expect { echo 5 } not toEqual 5 ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result not to equal"
  assert stderrContains "Actual: '5'"
  assert stderrContains "Expected: '5'"

  assert run [[ expect {{ echo 5 }} not toEqual "Wrong value" ]]
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run [[ expect {{ echo 5 }} not toEqual 5 ]]
  assert [ -z "$STDOUT" ]
  assert stderrContains "Expected result not to equal"
  assert stderrContains "Actual: '5'"
  assert stderrContains "Expected: '5'"
}

setAndEchoX() {
  x="$1"
  echo "$x"
}

@spec.singleCurliesRunLocally() {
  local x=5

  expect { setAndEchoX 42 } toEqual "42"

  assert [ "$x" = 42 ] # value was updated
}

@spec.doubleCurliesRunInSubshell() {
  local x=5

  expect {{ setAndEchoX 42 }} toEqual "42"

  assert [ "$x" = 5 ] # value was not updated
}

@spec.singleBracketsRunLocally() {
  local x=5

  expect [ setAndEchoX 42 ] toEqual "42"

  assert [ "$x" = 42 ] # value was updated
}

@spec.doubleBracketsRunInSubshell() {
  local x=5

  expect [[ setAndEchoX 42 ]] toEqual "42"

  assert [ "$x" = 5 ] # value was not updated
}