source spec/helper.sh
source matchers/contain.sh
source matchers/split.sh
source matchers/array.sh
source matchers/join.sh

CONTAIN_MESSAGE="Expected text value to contain"
CONTAIN_NOT_MESSAGE="Expected text value not to contain"
CONTAIN_EXITCODE=51

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
  e.g. assertThat : assertThat "Hello, world!" containing "Hello"
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
  (( EXITCODE == CONTAIN_EXITCODE ))
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

example.list.contains.fail() {
  e.g. assertions : assertListContains "Hello*orld" "Hello" "World"
  e.g. assertThat : assertThat [ "Hello" "World" ] contains "Hello*orld"
  e.g. expect     : expect [ "Hello" "World" ] to contain "Hello*orld"
  e.g. should     : :[ "Hello" "World" ] should contain "Hello*orld"
  assertStderr "Expected list to contain item with subtext" 'List: ("Hello" "World")' 'Expected: "Hello*orld"'
  assertEmptyStdout
  assertExitcode 51
}

example.list.contains.pass() {
  e.g. assertions : assertListContains "Hello*orld" "Hello" "Hello, world!" "World"
  e.g. assertThat : assertThat [ "Hello" "Hello, world!" "World" ] does contain "Hello*orld"
  e.g. expect     : expect [ "Hello" "Hello, world!" "World" ] to contain "Hello*orld"
  e.g. should     : :[ "Hello" "Hello, world!" "World" ] should contain "Hello*orld"
  assertEmptyStdout
  assertEmptyStderr
  assertExitcode 0
}

example.list.contains.not.fail() {
  e.g. assertions : assertNotListContains "Hello*orld" "Hello" "Hello, world!" "World"
  e.g. assertThat : assertThat [ "Hello" "Hello, world!" "World" ] does not contain "Hello*orld"
  e.g. expect     : expect [ "Hello" "Hello, world!" "World" ] not to contain "Hello*orld"
  e.g. should     : :[ "Hello" "Hello, world!" "World" ] should not contain "Hello*orld"
  assertStderr "Expected list not to contain item with subtext" 'List: ("Hello" "Hello, world!" "World")' 'Unexpected: "Hello*orld"'
  assertEmptyStdout
  assertExitcode 51
}

example.array.contains.fail() {
  greetings=( "Hello" "World" )

  e.g. assertions : assertArrayContains "Hello*orld" greetings
  e.g. assertThat : assertThat greetings array contains "Hello*orld"
  e.g. expect     : expect greetings array to contain "Hello*orld"
  e.g. should     : {{ greetings }} array should contain "Hello*orld"
  assertStderr "Expected array to contain item with subtext" "Array variable: greetings" 'Elements: ("Hello" "World")' 'Expected: "Hello*orld"'
  assertEmptyStdout
  assertExitcode 51
}

# This same example *fails* with include because contain does wildcard matching
example.list.contain.pass.compare.to.include() {
  e.g. assertions : assertListContains "Hel*" "Hello" "World"
  e.g. assertThat : assertThat [ "Hello" "World" ] contains "Hel*"
  e.g. expect     : expect [ "Hello" "World" ] to contain "Hel*"
  e.g. should     : :[ "Hello" "World" ] should contain "Hel*"
  assertEmptyStdout
  assertEmptyStderr
  assertExitcode 0
}

example.text.split.to.list.fail.again() {
  e.g. assertThat : assertThat "Hi Hello, world! " split " " contains "Hel*"
  e.g. expect     : expect "Hi Hello, world! " split " " to contain "Hel*"
  e.g. should     : {{ "Hi Hello, world! " }} split " " to contain "Hel*"
  assertEmptyStdout
  assertEmptyStderr
  assertExitcode 0
}

example.list.join.fail() {
  e.g. assertThat : assertThat [ a b c ] join ":" contains "a:b:Z"
  e.g. expect     : expect [ a b c ] join ":" to contain "a:b:Z"
  e.g. should     : :[ a b c ] join ":" should contain "a:b:Z"
  assertStderr "Expected text value to contain subtext" 'Actual: "a:b:c"' 'Expected: "a:b:Z"'
}

example.array.join.fail() {
  items=( x y z )
  e.g. assertThat : assertThat items array join ":" contains "a:b:Z"
  e.g. expect     : expect items array join ":" to contain "a:b:Z"
  e.g. should     : {{ items }} array join ":" should contain "a:b:Z"
  assertStderr "Expected text value to contain subtext" 'Actual: "x:y:z"' 'Expected: "a:b:Z"'
}

runExamples