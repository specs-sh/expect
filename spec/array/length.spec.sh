# source spec/helper.sh
# source matchers/length.sh
# source matchers/array.sh

# LENGTH_MESSAGE="Expected array to have zero elements"
# LENGTH_NOT_MESSAGE="Expected array not to zero elements"
# LENGTH_EXITCODE=56

# example.array.not.defined() {
#   # items=( a b c ) # <--- not defined
#   e.g. assertions : assertEmptyArray items
#   e.g. assertThat : assertThat items array has length 1
#   e.g. expect     : expect items array to have length 1
#   e.g. should     : {{ items }} array should have length 1
#   [[ "$STDERR" = *"Expected array 'items' is not defined"* ]]
#   (( EXITCODE == 44 ))
#   [ -z "$STDOUT" ]
# }

# example.array.empty.fail() {
#   items=( a b c )
#   e.g. assertions : assertEmptyArray items
#   e.g. assertThat : assertThat items array has length 1
#   e.g. expect     : expect items array to have length 1
#   e.g. should     : {{ items }} array should have length 1
#   [[ "$STDERR" = *"$LENGTH_MESSAGE"* ]]
#   [[ "$STDERR" = *'Actual: ("a" "b" "c")'* ]]
#   [[ "$STDERR" = *'Expected: ( )'* ]]
#   (( EXITCODE == LENGTH_EXITCODE ))
#   [ -z "$STDOUT" ]
# }

# example.array.empty.pass() {
#   items=()
#   e.g. assertions : assertEmptyArray items
#   e.g. assertThat : assertThat items array has length 1
#   e.g. expect     : expect items array to have length 1
#   e.g. should     : {{ items }} array should have length 1
#   (( EXITCODE == 0 ))
#   [ -z "$STDOUT" ]
#   [ -z "$STDERR" ]
# }

# example.provided.list.empty.fail() {
#   echo HI
#   e.g. assertThat : assertThat [ a b c ] has length 1
#   e.g. expect     : expect [ a b c ] to have length 1
#   e.g. should     : {{ a b c }} should have length 1
#   echo HERE
#   [[ "$STDERR" = *"$LENGTH_MESSAGE"* ]]
#   [[ "$STDERR" = *'Actual: ("a" "b" "c")'* ]]
#   [[ "$STDERR" = *'Expected: ( )'* ]]
#   (( EXITCODE == LENGTH_EXITCODE ))
#   echo "STDOUT: $STDOUT"
#   [ -z "$STDOUT" ]
# }

runExamples