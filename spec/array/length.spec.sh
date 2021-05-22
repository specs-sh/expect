source spec/helper.sh
source matchers/length.sh
source matchers/array.sh

LENGTH_EXITCODE=56

example.array.length.fail() {
  items=( "Hello" "World" )
  e.g. assertions : assertArrayLength 1 items
  e.g. assertThat : assertThat items array has length 1
  e.g. expect     : expect items array to have length 1
  e.g. should     : {{ items }} array should have length 1
  [[ "$STDERR" = *"Expected array to have specified length"* ]]
  [[ "$STDERR" = *'Array: items'* ]]
  [[ "$STDERR" = *'Items: ("Hello" "World")'* ]]
  [[ "$STDERR" = *'Actual Length: 2'* ]]
  [[ "$STDERR" = *'Expected Length: 1'* ]]
  (( EXITCODE == LENGTH_EXITCODE ))
  [ -z "$STDOUT" ]
}

example.array.length.pass() {
  e.g. assertions : assertListLength 2 "Hello" "World"
  e.g. assertThat : assertThat [ "Hello" "World" ] has length 2
  e.g. expect     : expect [ "Hello" "World" ] to have length 2
  e.g. should     : {{ "Hello" "World" }} should have length 2
  (( EXITCODE == 0 ))
  [ -z "$STDOUT" ]
  [ -z "$STDERR" ]
}

runExamples