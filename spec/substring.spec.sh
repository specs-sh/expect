source spec/helper.sh
source matchers/substring.sh
source matchers/first.sh
source matchers/last.sh

SUBSTRING_MESSAGE="Expected text value to contain substring"
SUBSTRING_NOT_MESSAGE="Expected text value not to contain substring"
SUBSTRING_EXITCODE=55

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
  (( EXITCODE == SUBSTRING_EXITCODE ))
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

example.first.item.in.list.fail() {
  e.g. assertThat : assertThat [ "Hello" "World" ] first has substring "World"
  e.g. expect     : expect [ "Hello" "World" ] first to have substring "World"
  e.g. should     : :[ "Hello" "World" ] first should have substring "World"
  [[ "$STDERR" = *"$SUBSTRING_MESSAGE"* ]]
  [[ "$STDERR" = *'Actual: "Hello"'* ]]
  [[ "$STDERR" = *'Expected: "World"'* ]]
  (( EXITCODE == SUBSTRING_EXITCODE ))
  [ -z "$STDOUT" ]
}

example.last.item.in.list.fail() {
  e.g. assertThat : assertThat [ "Hello" "World" "abc" ] last has substring "World"
  e.g. expect     : expect [ "Hello" "World" "abc" ] last to have substring "World"
  e.g. should     : :[ "Hello" "World" "abc" ] last should have substring "World"
  [[ "$STDERR" = *"$SUBSTRING_MESSAGE"* ]]
  [[ "$STDERR" = *'Actual: "abc"'* ]]
  [[ "$STDERR" = *'Expected: "World"'* ]]
  (( EXITCODE == SUBSTRING_EXITCODE ))
  [ -z "$STDOUT" ]
}

example.last.item.in.list.pass() {
  e.g. assertThat : assertThat [ "Hello" "World" ] last has substring "World"
  e.g. expect     : expect [ "Hello" "World" ] last to have substring "World"
  e.g. should     : :[ "Hello" "World" ] last should have substring "World"
  assertExitcode 0
  assertEmptyStderr
  assertEmptyStdout
}

example.first.item.in.list.pass() {
  e.g. assertThat : assertThat [ "Hello" "World" ] first has substring "llo"
  e.g. expect     : expect [ "Hello" "World" ] first to have substring "llo"
  e.g. should     : :[ "Hello" "World" ] first should have substring "llo"
  assertExitcode 0
  assertEmptyStderr
  assertEmptyStdout
}

example.first.item.in.array.fail() {
  items=( "Hello" "World" )
  e.g. assertThat : assertThat items array first has substring "World"
  e.g. expect     : expect items array first to have substring "World"
  e.g. should     : {{ items }} array first should have substring "World"
  [[ "$STDERR" = *"$SUBSTRING_MESSAGE"* ]]
  [[ "$STDERR" = *'Actual: "Hello"'* ]]
  [[ "$STDERR" = *'Expected: "World"'* ]]
  (( EXITCODE == SUBSTRING_EXITCODE ))
  [ -z "$STDOUT" ]
}

example.first.item.in.array.pass() {
  items=( "Hello" "World" )
  e.g. assertThat : assertThat items array first has substring "llo"
  e.g. expect     : expect items array first to have substring "llo"
  e.g. should     : {{ items }} array first should have substring "llo"
  assertExitcode 0
  assertEmptyStderr
  assertEmptyStdout
}

example.last.item.in.array.fail() {
  items=( "Hello" "World" "abc" )
  e.g. assertThat : assertThat items array last has substring "orld"
  e.g. expect     : expect items array last to have substring "orld"
  e.g. should     : {{ items }} array last should have substring "orld"
  [[ "$STDERR" = *"$SUBSTRING_MESSAGE"* ]]
  [[ "$STDERR" = *'Actual: "abc"'* ]]
  [[ "$STDERR" = *'Expected: "orld"'* ]]
  (( EXITCODE == SUBSTRING_EXITCODE ))
  [ -z "$STDOUT" ]
}

example.last.item.in.array.pass() {
  items=( "Hello" "World" )
  e.g. assertThat : assertThat items array last has substring "orld"
  e.g. expect     : expect items array last to have substring "orld"
  e.g. should     : {{ items }} array last should have substring "orld"
  assertExitcode 0
  assertEmptyStderr
  assertEmptyStdout
}

runExamples