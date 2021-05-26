source spec/helper.sh

source matchers/contain/list.sh

example.missingArgument.fail() {
  actual=("Hello" "World")

  e.g. assertThat : assertThat [ "${actual[@]}" ] contains
  e.g. expect     : expect [ "${actual[@]}" ] to contain
  e.g. should     : :[ "${actual[@]}" ] should contain
}

example.fail() {
  actual=("Hello" "World")
  expected="Hi"

  e.g. assertThat : assertThat [ "${actual[@]}" ] contains "$expected"
  e.g. expect     : expect [ "${actual[@]}" ] to contain "$expected"
  e.g. should     : :[ "${actual[@]}" ] should contain "$expected"

  assertStderr 'Actual: ("Hello" "World")'
  assertStderr 'Expected: "Hi"'
}

example.pass() {
  actual=("Hello" "World")
  expected="Hello"

  e.g. assertThat : assertThat [ "${actual[@]}" ] contains "$expected"
  e.g. expect     : expect [ "${actual[@]}" ] to contain "$expected"
  e.g. should     : :[ "${actual[@]}" ] should contain "$expected"
}

example.not.fail() {
  actual=("Hello" "World")
  expected="Hello"

  e.g. assertThat : assertThat [ "${actual[@]}" ] does not contain "$expected"
  e.g. expect     : expect [ "${actual[@]}" ] not to contain "$expected"
  e.g. should     : :[ "${actual[@]}" ] should not contain "$expected"

  assertStderr 'Actual: ("Hello" "World")'
  assertStderr 'Unexpected: "Hello"'
}

example.not.pass() {
  actual=("Hello" "World")
  expected="Foo"

  e.g. assertThat : assertThat [ "${actual[@]}" ] does not contain "$expected"
  e.g. expect     : expect [ "${actual[@]}" ] not to contain "$expected"
  e.g. should     : :[ "${actual[@]}" ] should not contain "$expected"
}

example.wildcard.fail() {
  actual=("Hello" "World")
  expected="*world"

  e.g. assertThat : assertThat [ "${actual[@]}" ] contains "$expected"
  e.g. expect     : expect [ "${actual[@]}" ] to contain "$expected"
  e.g. should     : :[ "${actual[@]}" ] should contain "$expected"

  assertStderr 'Actual: ("Hello" "World")'
  assertStderr 'Expected: "*world"'
}

example.wildcard.pass() {
  actual=("Hello" "foo world")
  expected="*world"

  e.g. assertThat : assertThat [ "${actual[@]}" ] contains "$expected"
  e.g. expect     : expect [ "${actual[@]}" ] to contain "$expected"
  e.g. should     : :[ "${actual[@]}" ] should contain "$expected"
}

runExamples