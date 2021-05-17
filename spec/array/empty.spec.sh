source spec/helper.sh
source matchers/empty.sh
source matchers/array.sh

EMPTY_MESSAGE="Expected array to have zero elements"
EMPTY_NOT_MESSAGE="Expected array not to zero elements"
EMPTY_EXITCODE=52

example.array.not.defined() {
  :
}

example.array.empty.fail() {
  items=( a b c )
  # e.g. assertions : assertEmptyArray items
  # e.g. assertThat : assertThat items array is empty
  # e.g. expect     : expect items array to be empty
  e.g. should     : {{ items }} array should be empty
  [[ "$STDERR" = *"$EMPTY_MESSAGE"* ]]
  [[ "$STDERR" = *'Actual: ("a" "b" "c")'* ]]
  [[ "$STDERR" = *'Expected: ( )'* ]]
  (( EXITCODE == EMPTY_EXITCODE ))
  [ -z "$STDOUT" ]
}

example.provided.list.empty.fail() {
  :
}

# example.empty.pass() {
#   e.g. assertions : assertEmpty ""
#   e.g. assertThat : assertThat "" is empty
#   e.g. expect     : expect "" to be empty
#   e.g. should     : {{ "" }} should be empty
#   (( EXITCODE == 0 ))
#   [ -z "$STDOUT" ]
#   [ -z "$STDERR" ]
# }

# example.not.empty.fail() {
#   e.g. assertions : assertNotEmpty ""
#   e.g. assertThat : assertThat "" is not empty
#   e.g. expect     : expect "" not to be empty
#   e.g. should     : {{ "" }} should not be empty
#   [[ "$STDERR" = *"$EMPTY_NOT_MESSAGE"* ]]
#   [[ "$STDERR" = *'Actual: ""'* ]]
#   (( EXITCODE == EMPTY_EXITCODE ))
#   [ -z "$STDOUT" ]
# }

# example.not.empty.pass() {
#   e.g. assertions : assertNotEmpty "Hello"
#   e.g. assertThat : assertThat "Hello" is not empty
#   e.g. expect     : expect "Hello" not to be empty
#   e.g. should     : {{ "Hello" }} should not be empty
#   (( EXITCODE == 0 ))
#   [ -z "$STDOUT" ]
#   [ -z "$STDERR" ]
# }

runExamples