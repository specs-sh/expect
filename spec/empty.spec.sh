source spec/helper.sh
source matchers/empty.sh
source matchers/array.sh

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

example.provided.list.empty.fail() {
  e.g. assertThat : assertThat [ a b c ] is empty
  e.g. expect     : expect [ a b c ] to be empty
  e.g. should     : {{ a b c }} should be empty
  e.g. should     : :[ a b c ] should be empty
  [[ "$STDERR" = *"Expected list to have zero elements"* ]]
  [[ "$STDERR" = *'Actual: ("a" "b" "c")'* ]]
  [[ "$STDERR" = *'Expected: ( )'* ]]
  (( EXITCODE == EMPTY_EXITCODE ))
  echo "STDOUT: $STDOUT"
  [ -z "$STDOUT" ]
}

example.array.not.defined() {
  # items=( a b c ) # <--- not defined
  e.g. assertions : assertEmptyArray items
  e.g. assertThat : assertThat items array is empty
  e.g. expect     : expect items array to be empty
  e.g. should     : {{ items }} array should be empty
  [[ "$STDERR" = *"Expected array 'items' is not defined"* ]]
  (( EXITCODE == 44 ))
  [ -z "$STDOUT" ]
}

example.array.empty.fail() {
  items=( a b c )
  e.g. assertions : assertEmptyArray items
  e.g. assertThat : assertThat items array is empty
  e.g. expect     : expect items array to be empty
  e.g. should     : {{ items }} array should be empty
  [[ "$STDERR" = *"Expected array to have zero elements"* ]]
  [[ "$STDERR" = *'Actual: ("a" "b" "c")'* ]]
  [[ "$STDERR" = *'Expected: ( )'* ]]
  (( EXITCODE == EMPTY_EXITCODE ))
  [ -z "$STDOUT" ]
}

example.array.empty.pass() {
  items=()
  e.g. assertions : assertEmptyArray items
  e.g. assertThat : assertThat items array is empty
  e.g. expect     : expect items array to be empty
  e.g. should     : {{ items }} array should be empty
  (( EXITCODE == 0 ))
  [ -z "$STDOUT" ]
  [ -z "$STDERR" ]
}

runExamples