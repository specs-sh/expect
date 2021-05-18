source spec/helper.sh
source matchers/empty.sh
source matchers/array.sh

EMPTY_MESSAGE="Expected array to have zero elements"
EMPTY_NOT_MESSAGE="Expected array not to zero elements"
EMPTY_EXITCODE=52

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
  [[ "$STDERR" = *"$EMPTY_MESSAGE"* ]]
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

example.provided.list.empty.fail() {
  echo HI
  e.g. assertThat : assertThat [ a b c ] is empty
  e.g. expect     : expect [ a b c ] to be empty
  e.g. should     : {{ a b c }} should be empty
  echo HERE
  [[ "$STDERR" = *"$EMPTY_MESSAGE"* ]]
  [[ "$STDERR" = *'Actual: ("a" "b" "c")'* ]]
  [[ "$STDERR" = *'Expected: ( )'* ]]
  (( EXITCODE == EMPTY_EXITCODE ))
  echo "STDOUT: $STDOUT"
  [ -z "$STDOUT" ]
}

runExamples