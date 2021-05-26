source spec/helper.sh

source types/array.sh
source matchers/contain/array.sh

# example.missingArgument.fail() {
#   items=("Hello" "World")

#   e.g. assertThat : assertThat items array contains
#   e.g. expect     : expect items array to contain
#   e.g. should     : {{ items }} array should contain
# }

xexample.noArray.fail() {
  :
}

example.fail() {
  items=("Hello" "World")
  expected="Hi"

  e.g. assertThat : assertThat items array contains "$expected"
  e.g. expect     : expect items array to contain "$expected"
  e.g. should     : {{ items }} array should contain "$expected"

  assertStderr 'Actual: ("Hello" "World")'
  assertStderr 'Expected: "Hi"'
}

example.pass() {
  items=("Hello" "World")
  expected="Hello"

  e.g. assertThat : assertThat items array contains "$expected"
  e.g. expect     : expect items array to contain "$expected"
  e.g. should     : {{ items }} array should contain "$expected"
}

example.not.fail() {
  items=("Hello" "World")
  expected="Hello"

  e.g. assertThat : assertThat items array does not contain "$expected"
  e.g. expect     : expect items array not to contain "$expected"
  e.g. should     : {{ items }} array should not contain "$expected"

  assertStderr 'Actual: ("Hello" "World")'
  assertStderr 'Unexpected: "Hello"'
}

example.not.pass() {
  items=("Hello" "World")
  expected="Foo"

  e.g. assertThat : assertThat items array does not contain "$expected"
  e.g. expect     : expect items array not to contain "$expected"
  e.g. should     : {{ items }} array should not contain "$expected"
}

example.wildcard.fail() {
  items=("Hello" "World")
  expected="*world"

  e.g. assertThat : assertThat items array contains "$expected"
  e.g. expect     : expect items array to contain "$expected"
  e.g. should     : {{ items }} array should contain "$expected"

  assertStderr 'Actual: ("Hello" "World")'
  assertStderr 'Expected: "*world"'
}

example.wildcard.pass() {
  items=("Hello" "foo world")
  expected="*world"

  e.g. assertThat : assertThat items array contains "$expected"
  e.g. expect     : expect items array to contain "$expected"
  e.g. should     : {{ items }} array should contain "$expected"
}

runExamples