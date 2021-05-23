source spec/helper.sh
source matchers/include.sh
source matchers/array.sh

example.noArguments() {
  e.g. assertThat : assertThat [ "Hello" ] includes
  e.g. expect     : expect [ "Hello" ] to include
  e.g. should     : :[ "Hello" ] should include
  [[ "$STDERR" = *"Missing required argument"* ]]
  (( EXITCODE == 40 ))
  [ -z "$STDOUT" ]
}

example.list.include.fail() {
  e.g. assertions : assertListIncludes "Hel*" "Hello" "World"
  e.g. assertThat : assertThat [ "Hello" "World" ] includes "Hel*"
  e.g. expect     : expect [ "Hello" "World" ] to include "Hel*"
  e.g. should     : :[ "Hello" "World" ] should include "Hel*"
  assertStderr "Expected list to include item" 'List: ("Hello" "World")' 'Expected: "Hel*"'
  assertEmptyStdout
  assertExitcode 52
}

example.list.empty.include.fail() {
  e.g. assertions : assertListIncludes "Hel*"
  e.g. assertThat : assertThat [ ] includes "Hel*"
  e.g. expect     : expect [ ] to include "Hel*"
  e.g. should     : :[ ] should include "Hel*"
  assertStderr "Expected list to include item" 'List: ()' 'Expected: "Hel*"'
  assertEmptyStdout
  assertExitcode 52
}

example.list.include.pass() {
  e.g. assertions : assertListIncludes "Hel*" "Hello" "Hel*" "World"
  e.g. assertThat : assertThat [ "Hello" "Hel*" "World" ] includes "Hel*"
  e.g. expect     : expect [ "Hello" "Hel*" "World" ] to include "Hel*"
  e.g. should     : :[ "Hello" "Hel*" "World" ] should include "Hel*"
  assertEmptyStdout
  assertEmptyStderr
  assertExitcode 0
}

example.list.not.include.fail() {
  e.g. assertions : assertNotListIncludes "Hello" "Hello" "World"
  e.g. assertThat : assertThat [ "Hello" "World" ] does not include "Hello"
  e.g. expect     : expect [ "Hello" "World" ] not to include "Hello"
  e.g. should     : :[ "Hello" "World" ] should not include "Hello"
  assertStderr "Expected list not to include item" 'List: ("Hello" "World")' 'Unexpected: "Hello"'
  assertEmptyStdout
  assertExitcode 52
}

example.list.not.include.pass() {
  e.g. assertions : assertNotListIncludes "Foo" "Hello" "World"
  e.g. assertThat : assertThat [ "Hello" "World" ] does not include "Foo"
  e.g. expect     : expect [ "Hello" "World" ] not to include "Foo"
  e.g. should     : :[ "Hello" "World" ] should not include "Foo"
  assertEmptyStdout
  assertEmptyStderr
  assertExitcode 0
}

example.list.not.empty.include.pass() {
  e.g. assertions : assertNotListIncludes "Foo"
  e.g. assertThat : assertThat [  ] does not include "Foo"
  e.g. expect     : expect [ ] not to include "Foo"
  e.g. should     : :[ ] should not include "Foo"
  assertEmptyStdout
  assertEmptyStderr
  assertExitcode 0
}

example.array.include.fail() {
  items=("Hello" "World")
  e.g. assertions : assertArrayIncludes "Hel*" items
  e.g. assertThat : assertThat items array includes "Hel*"
  e.g. expect     : expect items array to include "Hel*"
  e.g. should     : {{ items }} array should include "Hel*"
  assertStderr "Expected array to include element" "Array variable: items" 'Elements: ("Hello" "World")' 'Expected: "Hel*"'
  assertEmptyStdout
  assertExitcode 52
}

example.array.include.fail() {
  items=()
  e.g. assertions : assertArrayIncludes "Hel*" items
  e.g. assertThat : assertThat items array includes "Hel*"
  e.g. expect     : expect items array to include "Hel*"
  e.g. should     : {{ items }} array should include "Hel*"
  assertStderr "Expected array to include element" "Array variable: items" 'Elements: ()' 'Expected: "Hel*"'
  assertEmptyStdout
  assertExitcode 52
}

example.array.include.pass() {
  items=("Hel*" "World")
  e.g. assertions : assertArrayIncludes "Hel*" items
  e.g. assertThat : assertThat items array includes "Hel*"
  e.g. expect     : expect items array to include "Hel*"
  e.g. should     : {{ items }} array should include "Hel*"
  assertEmptyStdout
  assertEmptyStderr
  assertExitcode 0
}

example.array.not.include.fail() {
  items=("Hello" "World")
  e.g. assertions : assertNotArrayIncludes "Hello" items
  e.g. assertThat : assertThat items array does not include "Hello"
  e.g. expect     : expect items array not to include "Hello"
  e.g. should     : {{ items }} array should not include "Hello"
  assertStderr "Expected array not to include element" "Array variable: items" 'Elements: ("Hello" "World")' 'Unexpected: "Hello"'
  assertEmptyStdout
  assertExitcode 52
}

example.array.not.include.pass() {
  items=("Foo" "World")
  e.g. assertions : assertNotArrayIncludes "Hello" items
  e.g. assertThat : assertThat items array does not include "Hello"
  e.g. expect     : expect items array not to include "Hello"
  e.g. should     : {{ items }} array should not include "Hello"
  assertEmptyStdout
  assertEmptyStderr
  assertExitcode 0
}

example.array.empty.not.include.pass() {
  items=()
  e.g. assertions : assertNotArrayIncludes "Hello" items
  e.g. assertThat : assertThat items array does not include "Hello"
  e.g. expect     : expect items array not to include "Hello"
  e.g. should     : {{ items }} array should not include "Hello"
  assertEmptyStdout
  assertEmptyStderr
  assertExitcode 0
}

runExamples