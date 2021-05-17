source spec/helper.sh
source matchers/empty.sh

EMPTY_MESSAGE="Expected text to have zero-length"
EMPTY_NOT_MESSAGE="Expected text not to have zero-length"
EMPTY_EXITCODE=52

example.empty.fail() {
  e.g. assertions : assertEmpty "Hello"
  e.g. assertThat : assertThat "Hello" is empty
  e.g. expect     : expect "Hello" to be empty
  e.g. should     : {{ "Hello" }} should be empty
  [[ "$STDERR" = *"$EMPTY_MESSAGE"* ]]
  [[ "$STDERR" = *'Actual: "Hello"'* ]]
  [[ "$STDERR" = *'Expected: ""'* ]]
  (( EXITCODE == EMPTY_EXITCODE ))
  [ -z "$STDOUT" ]
}

example.empty.pass() {
  e.g. assertions : assertEmpty ""
  e.g. assertThat : assertThat "" is empty
  e.g. expect     : expect "" to be empty
  e.g. should     : {{ "" }} should be empty
  (( EXITCODE == 0 ))
  [ -z "$STDOUT" ]
  [ -z "$STDERR" ]
}

example.not.empty.fail() {
  e.g. assertions : assertNotEmpty ""
  e.g. assertThat : assertThat "" is not empty
  e.g. expect     : expect "" not to be empty
  e.g. should     : {{ "" }} should not be empty
  [[ "$STDERR" = *"$EMPTY_NOT_MESSAGE"* ]]
  [[ "$STDERR" = *'Actual: ""'* ]]
  (( EXITCODE == EMPTY_EXITCODE ))
  [ -z "$STDOUT" ]
}

example.not.empty.pass() {
  e.g. assertions : assertNotEmpty "Hello"
  e.g. assertThat : assertThat "Hello" is not empty
  e.g. expect     : expect "Hello" not to be empty
  e.g. should     : {{ "Hello" }} should not be empty
  (( EXITCODE == 0 ))
  [ -z "$STDOUT" ]
  [ -z "$STDERR" ]
}

runExamples