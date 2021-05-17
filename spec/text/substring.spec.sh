source spec/helper.sh
source matchers/substring.sh

SUBSTRING_MESSAGE="Expected text value to contain substring"
SUBSTRING_EXITCODE=54

SUBSTRING_NOT_MESSAGE="Expected text value not to contain substring"
SUBSTRING_NOT_EXITCODE=55

example.noArguments() {
  e.g. assertThat : assertThat "Hello" has substring
  e.g. expect     : expect "Hello" to have substring
  e.g. should     : {{ "Hello" }} should have substring
  [[ "$STDERR" = *"Missing required argument"* ]]
  (( EXITCODE == 40 ))    
  [ -z "$STDOUT" ]
}

example.substring.fail() {
  e.g. assertions : assertSubstring "World" "Hello"
  e.g. assertThat : assertThat "Hello" has substring "World"
  e.g. expect     : expect "Hello" to have substring "World"
  e.g. should     : {{ "Hello" }} should have substring "World"
  [[ "$STDERR" = *"$SUBSTRING_MESSAGE"* ]]
  [[ "$STDERR" = *'Actual: "Hello"'* ]]
  [[ "$STDERR" = *'Expected: "World"'* ]]
  (( EXITCODE == SUBSTRING_EXITCODE ))
  [ -z "$STDOUT" ]
}

example.substring.pass() {
  e.g. assertions : assertSubstring "Hello" "Hello, world!"
  e.g. assertThat : assertThat "Hello, world!" has substring "Hello"
  e.g. expect     : expect "Hello, world!" to have substring "Hello"
  e.g. should     : {{ "Hello, world!" }} should have substring "Hello"
  (( EXITCODE == 0 ))
  [ -z "$STDOUT" ]
  [ -z "$STDERR" ]
}

example.does.not.equal.fail() {
  e.g. assertions : assertNotSubstring "Hello" "Hello, world!"
  e.g. assertThat : assertThat "Hello, world!" not have substring "Hello"
  e.g. expect     : expect "Hello, world!" not to have substring "Hello"
  e.g. should     : {{ "Hello, world!" }} should not have substring "Hello"
  [[ "$STDERR" = *"$SUBSTRING_NOT_MESSAGE"* ]]
  [[ "$STDERR" = *'Actual: "Hello, world!"'* ]]
  [[ "$STDERR" = *'Unexpected: "Hello"'* ]]
  (( EXITCODE == SUBSTRING_NOT_EXITCODE ))
  [ -z "$STDOUT" ]
}

example.does.not.expand.wildcard.pattern.stars() {
  e.g. assertions : assertSubstring "Hello*" "Hello, world!"
  e.g. assertThat : assertThat "Hello, world!" have substring "Hello*"
  e.g. expect     : expect "Hello, world!" to have substring "Hello*"
  e.g. should     : {{ "Hello, world!" }} should have substring "Hello*"
  [[ "$STDERR" = *"$SUBSTRING_MESSAGE"* ]]
  [[ "$STDERR" = *'Actual: "Hello, world!"'* ]]
  [[ "$STDERR" = *'Expected: "Hello*"'* ]]
  (( EXITCODE == SUBSTRING_EXITCODE ))
  [ -z "$STDOUT" ]
}

runExamples