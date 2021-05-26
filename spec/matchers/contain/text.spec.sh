source spec/helper.sh

source matchers/contain/text.sh

example.assertContains.noArguments() {
  e.g. assertions : assertContains

  assertStderr "assertContains expected 2 arguments: [expected] [actual]"
  assertExitcode 40
}

example.assertContains.oneArgument() {
  e.g. assertions : assertContains "Foo"

  assertStderr "assertContains expected 2 arguments: [expected] [actual]"
  assertExitcode 40
}

example.assertContains.threeArguments() {
  e.g. assertions : assertContains "Foo" "Bar" "Baz"

  assertStderr "assertContains expected 2 arguments: [expected] [actual]"
  assertExitcode 40
}

example.missingArgument.fail() {
  actual="Hi"

  e.g. assertThat : assertThat "$actual" contains
  e.g. expect     : expect "$actual" to contain
  e.g. should     : {{ "$actual" }} should contain
}

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

example.wildcard.fail() {
  expected="*world"
  actual="Hi, Hello"

  e.g. assertions : assertContains "$expected" "$actual"
  e.g. assertThat : assertThat "$actual" does contain "$expected"
  e.g. expect     : expect "$actual" to contain "$expected"
  e.g. should     : {{ "$actual" }} should contain "$expected"

  assertStderr 'Actual: "Hi, Hello"'
  assertStderr 'Expected: "*world"'
}

example.wildcard.pass() {
  expected="*world"
  actual="Hi, Hello world, Foo"

  e.g. assertions : assertContains "$expected" "$actual"
  e.g. assertThat : assertThat "$actual" does contain "$expected"
  e.g. expect     : expect "$actual" to contain "$expected"
  e.g. should     : {{ "$actual" }} should contain "$expected"
}

runExamples