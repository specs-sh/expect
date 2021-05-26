source spec/helper.sh

source matchers/contain/text.sh

# example.missingArgument.fail() {
#   e.g. assertThat : assertThat Hello equals
#   e.g. assertThat : assertThat Hello eq
#   e.g. assertThat : assertThat Hello =
#   e.g. assertThat : assertThat Hello ==
#   e.g. expect     : expect Hello to equal
#   e.g. expect     : expect Hello to eq
#   e.g. expect     : expect Hello to =
#   e.g. expect     : expect Hello to ==
#   e.g. should     : {{ Hello }} should equal
#   e.g. should     : {{ Hello }} should eq
#   e.g. should     : {{ Hello }} should =
#   e.g. should     : {{ Hello }} should ==
# }

example.fail() {
  expected="Hello, world!"
  actual="Hi"

  e.g. assertions : assertContains "$expected" "$actual"
  e.g. assertThat : assertThat "$actual" contains "$expected"
  e.g. expect     : expect "$actual" to contain "$expected"
  e.g. should     : {{ "$actual" }} should contain "$expected"

  assertStderr 'Actual: "Hi"'
  assertStderr 'Expected: "Hello, world!"'
}

example.pass() {
  expected="Hi"
  actual="Hi, Hello"

  e.g. assertions : assertContains "$expected" "$actual"
  e.g. assertThat : assertThat "$actual" contains "$expected"
  e.g. expect     : expect "$actual" to contain "$expected"
  e.g. should     : {{ "$actual" }} should contain "$expected"
}

example.not.fail() {
  expected="Hi"
  actual="Hi, Hello"

  e.g. assertions : assertNotContains "$expected" "$actual"
  e.g. assertThat : assertThat "$actual" does not contain "$expected"
  e.g. expect     : expect "$actual" not to contain "$expected"
  e.g. should     : {{ "$actual" }} should not contain "$expected"

  assertStderr 'Actual: "Hi, Hello"'
  assertStderr 'Unexpected: "Hi"'
}

example.not.pass() {
  expected="Hi"
  actual="Foo Bar"

  e.g. assertions : assertNotContains "$expected" "$actual"
  e.g. assertThat : assertThat "$actual" does not contain "$expected"
  e.g. expect     : expect "$actual" not to contain "$expected"
  e.g. should     : {{ "$actual" }} should not contain "$expected"
}

runExamples