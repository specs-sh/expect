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

# example.does.not.have.empty.fail() {
#   e.g. assertions : assertNotLength 5 "Hello"
#   e.g. assertThat : assertThat "Hello" does not be empty 5
#   e.g. expect     : expect "Hello" not to be empty 5
#   e.g. should     : {{ "Hello" }} should not be empty 5
#   [[ "$STDERR" = *"$EMPTY_NOT_MESSAGE"* ]]
#   [[ "$STDERR" = *'Text: "Hello"'* ]]
#   [[ "$STDERR" = *'Length: 5'* ]]
#   (( EXITCODE == EMPTY_EXITCODE ))
#   [ -z "$STDOUT" ]
# }

# example.does.not.have.empty.pass() {
#   e.g. assertions : assertNotLength 2 "Hello"
#   e.g. assertThat : assertThat "Hello" does not be empty 2
#   e.g. expect     : expect "Hello" not to be empty 2
#   e.g. should     : {{ "Hello" }} should not be empty 2
#   (( EXITCODE == 0 ))
#   [ -z "$STDOUT" ]
#   [ -z "$STDERR" ]
# }

runExamples