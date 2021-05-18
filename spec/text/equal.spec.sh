source spec/helper.sh
source matchers/equal.sh

EQUAL_EXITCODE=50

spec.assertEquals.noArguments() {
  source assertions.sh
  refute run -p assertEqual
  [[ "$STDERR" = *"assertEqual expected 2 arguments: [expected] [actual]"* ]]
  (( EXITCODE == 40 ))
  [ -z "$STDOUT" ]

  STDERR= STDOUT= EXITCODE=
  refute run -p assertEqual oneArgument
  [[ "$STDERR" = *"assertEqual expected 2 arguments: [expected] [actual]"* ]]
  (( EXITCODE == 40 ))
  [ -z "$STDOUT" ]

  STDERR= STDOUT= EXITCODE=
  refute run -p assertEqual threeArguments
  [[ "$STDERR" = *"assertEqual expected 2 arguments: [expected] [actual]"* ]]
  (( EXITCODE == 40 ))
  [ -z "$STDOUT" ]
}

example.noArguments() {
  e.g. assertThat : assertThat "Hello" equals
  e.g. expect     : expect "Hello" to equal
  e.g. should     : {{ "Hello" }} should equal
  [[ "$STDERR" = *"Missing required argument"* ]]
  (( EXITCODE == 40 ))
  [ -z "$STDOUT" ]
}

example.equal.pass() {
  e.g. assertions : assertEqual "Hello" "Hello"
  e.g. assertThat : assertThat "Hello" equals "Hello"
  e.g. brackets   : [: "Hello" = "Hello" ]
  e.g. expect     : expect "Hello" to equal "Hello"
  e.g. should     : {{ "Hello" }} should equal "Hello"
  (( EXITCODE == 0 ))
  [ -z "$STDOUT" ]
  [ -z "$STDERR" ]
}

example.equal.fail() {
  e.g. assertions : assertEqual "World" "Hello"
  e.g. assertThat : assertThat "Hello" equals "World"
  e.g. brackets   : [: "Hello" = "World" ]
  e.g. expect     : expect "Hello" to equal "World"
  e.g. should     : {{ "Hello" }} should equal "World"
  [[ "$STDERR" = *"Expected values to equal"* ]]
  [[ "$STDERR" = *'Actual: "Hello"'* ]]
  [[ "$STDERR" = *'Expected: "World"'* ]]
  (( EXITCODE == EQUAL_EXITCODE ))
  [ -z "$STDOUT" ]
}

example.equal.fail.equal_sign() {
  e.g. assertThat : assertThat "Hello" = "World"
  e.g. expect     : expect "Hello" = "World"
  e.g. should     : {{ "Hello" }} should = "World"
  [[ "$STDERR" = *"Expected values to equal"* ]]
  [[ "$STDERR" = *'Actual: "Hello"'* ]]
  [[ "$STDERR" = *'Expected: "World"'* ]]
  (( EXITCODE == EQUAL_EXITCODE ))
  [ -z "$STDOUT" ]
}

example.equal.fail.double_equal_sign() {
  e.g. assertThat : assertThat "Hello" == "World"
  e.g. expect     : expect "Hello" == "World"
  e.g. should     : {{ "Hello" }} should == "World"
  [[ "$STDERR" = *"Expected values to equal"* ]]
  [[ "$STDERR" = *'Actual: "Hello"'* ]]
  [[ "$STDERR" = *'Expected: "World"'* ]]
  (( EXITCODE == EQUAL_EXITCODE ))
  [ -z "$STDOUT" ]
}


example.does.not.equal.fail() {
  e.g. assertions : assertNotEqual "Hello" "Hello"
  e.g. assertThat : assertThat "Hello" does not equal "Hello"
  e.g. brackets   : [: "Hello" != "Hello" ]
  e.g. expect     : expect "Hello" not to equal "Hello"
  e.g. should     : {{ "Hello" }} should not equal "Hello"
  [[ "$STDERR" = *"Expected values not to equal"* ]]
  [[ "$STDERR" = *'Value: "Hello"'* ]]
  (( EXITCODE == EQUAL_EXITCODE ))
  [ -z "$STDOUT" ]
}
example.equal.command.fail() {
  e.g. assertions : assertEqual "World" "$( echo Hello )"
  e.g. assertThat : assertThat { echo "Hello" } equals "World"
  e.g. brackets   : [: "$( echo Hello )" = "World" ]
  e.g. expect     : expect { echo "Hello" } to equal "World"
  e.g. should     : {: echo "Hello" } should equal "World"
  [[ "$STDERR" = *"Expected values to equal"* ]]
  [[ "$STDERR" = *'Actual: "Hello"'* ]]
  [[ "$STDERR" = *'Expected: "World"'* ]]
  (( EXITCODE == EQUAL_EXITCODE ))
  [ -z "$STDOUT" ]
}

runExamples