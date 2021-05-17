source spec/helper.sh
source matchers/length.sh

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

runExamples