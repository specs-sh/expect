source spec/helper.sh
source matchers/length.sh
source matchers/array.sh

LENGTH_MESSAGE="Expected text value to have specified length"
LENGTH_NOT_MESSAGE="Expected text value not to have specified length"
LENGTH_EXITCODE=56

example.noArguments() {
  e.g. assertThat : assertThat "Hello" has length
  e.g. expect     : expect "Hello" to have length
  e.g. should     : {{ "Hello" }} should have length
  [[ "$STDERR" = *"Missing required argument"* ]]
  (( EXITCODE == 40 ))    
  [ -z "$STDOUT" ]
}

example.length.fail() {
  e.g. assertions : assertLength 2 "Hello"
  e.g. assertThat : assertThat "Hello" has length 2
  e.g. expect     : expect "Hello" to have length 2
  e.g. should     : {{ "Hello" }} should have length 2
  [[ "$STDERR" = *"$LENGTH_MESSAGE"* ]]
  [[ "$STDERR" = *'Text: "Hello"'* ]]
  [[ "$STDERR" = *'Actual Length: 5'* ]]
  [[ "$STDERR" = *'Expected Length: 2'* ]]
  (( EXITCODE == LENGTH_EXITCODE ))
  [ -z "$STDOUT" ]
}

example.length.pass() {
  e.g. assertions : assertLength 5 "Hello"
  e.g. assertThat : assertThat "Hello" has length 5
  e.g. expect     : expect "Hello" to have length 5
  e.g. should     : {{ "Hello" }} should have length 5
  (( EXITCODE == 0 ))
  [ -z "$STDOUT" ]
  [ -z "$STDERR" ]
}

example.does.not.have.length.fail() {
  e.g. assertions : assertNotLength 5 "Hello"
  e.g. assertThat : assertThat "Hello" does not have length 5
  e.g. expect     : expect "Hello" not to have length 5
  e.g. should     : {{ "Hello" }} should not have length 5
  [[ "$STDERR" = *"$LENGTH_NOT_MESSAGE"* ]]
  [[ "$STDERR" = *'Text: "Hello"'* ]]
  [[ "$STDERR" = *'Length: 5'* ]]
  (( EXITCODE == LENGTH_EXITCODE ))
  [ -z "$STDOUT" ]
}

example.does.not.have.length.pass() {
  e.g. assertions : assertNotLength 2 "Hello"
  e.g. assertThat : assertThat "Hello" does not have length 2
  e.g. expect     : expect "Hello" not to have length 2
  e.g. should     : {{ "Hello" }} should not have length 2
  (( EXITCODE == 0 ))
  [ -z "$STDOUT" ]
  [ -z "$STDERR" ]
}

example.list.length.fail() {
  e.g. assertions : assertListLength 1 "Hello" "World"
  e.g. assertThat : assertThat [ "Hello" "World" ] has length 1
  e.g. expect     : expect [ "Hello" "World" ] to have length 1
  e.g. should     : {{ "Hello" "World" }} should have length 1
  [[ "$STDERR" = *"Expected list to have specified length"* ]]
  [[ "$STDERR" = *'List: ("Hello" "World")'* ]]
  [[ "$STDERR" = *'Actual Length: 2'* ]]
  [[ "$STDERR" = *'Expected Length: 1'* ]]
  (( EXITCODE == LENGTH_EXITCODE ))
  [ -z "$STDOUT" ]
}

example.list.length.pass() {
  e.g. assertions : assertListLength 2 "Hello" "World"
  e.g. assertThat : assertThat [ "Hello" "World" ] has length 2
  e.g. expect     : expect [ "Hello" "World" ] to have length 2
  e.g. should     : {{ "Hello" "World" }} should have length 2
  (( EXITCODE == 0 ))
  [ -z "$STDOUT" ]
  [ -z "$STDERR" ]
}

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