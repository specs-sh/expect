source spec/helper.sh
source matchers/contain.sh

CONTAIN_MESSAGE="Expected text value to contain"
CONTAIN_EXITCODE=52

CONTAIN_NOT_MESSAGE="Expected text value not to contain"
CONTAIN_NOT_EXITCODE=53

example.noArguments() {
  e.g. assertThat : assertThat "Hello" contains
  e.g. expect     : expect "Hello" to contain
  e.g. should     : {{ "Hello" }} should contain
  [[ "$STDERR" = *"Missing required argument"* ]]
  (( EXITCODE == 40 ))
  [ -z "$STDOUT" ]
}

example.contain.fail() {
  e.g. assertions : assertContains "World" "Hello"
  e.g. assertThat : assertThat "Hello" contains "World"
  e.g. expect     : expect "Hello" to contain "World"
  e.g. should     : {{ "Hello" }} should contain "World"
  [[ "$STDERR" = *"$CONTAIN_MESSAGE"* ]]
  [[ "$STDERR" = *'Actual: "Hello"'* ]]
  [[ "$STDERR" = *'Expected: "World"'* ]]
  (( EXITCODE == CONTAIN_EXITCODE ))
  [ -z "$STDOUT" ]
}

example.contain.pass() {
  e.g. assertions : assertContains "Hello" "Hello, world!"
  e.g. assertThat : assertThat "Hello, world!" contains "Hello"
  e.g. expect     : expect "Hello, world!" to contain "Hello"
  e.g. should     : {{ "Hello, world!" }} should contain "Hello"
  (( EXITCODE == 0 ))
  [ -z "$STDOUT" ]
  [ -z "$STDERR" ]
}

example.does.not.equal.fail() {
  e.g. assertions : assertNotContains "Hello" "Hello, world!"
  e.g. assertThat : assertThat "Hello, world!" not contain "Hello"
  e.g. expect     : expect "Hello, world!" not to contain "Hello"
  e.g. should     : {{ "Hello, world!" }} should not contain "Hello"
  [[ "$STDERR" = *"$CONTAIN_NOT_MESSAGE"* ]]
  [[ "$STDERR" = *'Actual: "Hello, world!"'* ]]
  [[ "$STDERR" = *'Unexpected: "Hello"'* ]]
  (( EXITCODE == CONTAIN_NOT_EXITCODE ))
  [ -z "$STDOUT" ]
}

example.does.expand.wildcard.pattern.stars.pass() {
  e.g. assertions : assertContains "Hello*" "Hello, world!"
  e.g. assertThat : assertThat "Hello, world!" contains "Hello*"
  e.g. expect     : expect "Hello, world!" to contain "Hello*"
  e.g. should     : {{ "Hello, world!" }} should contain "Hello*"
  (( EXITCODE == 0 ))
  [ -z "$STDERR" ]
  [ -z "$STDOUT" ]
}

example.does.expand.wildcard.pattern.stars.fail() {
  e.g. assertions : assertContains "Hello*World" "Hello, world!"
  e.g. assertThat : assertThat "Hello, world!" contains "Hello*World"
  e.g. expect     : expect "Hello, world!" to contain "Hello*World"
  e.g. should     : {{ "Hello, world!" }} should contain "Hello*World"
  [[ "$STDERR" = *"$CONTAIN_MESSAGE"* ]]
  [[ "$STDERR" = *'Actual: "Hello, world!"'* ]]
  [[ "$STDERR" = *'Expected: "Hello*World"'* ]]
  (( EXITCODE == CONTAIN_EXITCODE ))
  [ -z "$STDOUT" ]
}

# TODO: LIST SHOULD CONTAIN

# TODO: ARRAY SHOULD CONTAIN

runExamples