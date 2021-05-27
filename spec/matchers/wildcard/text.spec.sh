source spec/helper.sh

include matchers/wildcard/text

example.assertWildcard.wrongNumberOfArguments() {
  e.g. assertions : assertWildcard
  e.g. assertions : assertWildcard "Foo"
  e.g. assertions : assertWildcard "Foo" "Bar" "Baz"

  assertStderr "assertWildcard expected 2 arguments: [expected] [actual]"
  assertExitcode 40
}

example.missingArgument.fail() {
  actual="Hi"

  e.g. assertThat : assertThat "$actual" has wildcards
  e.g. expect     : expect "$actual" has wildcards
  e.g. should     : {{ "$actual" }} should have wildcards
}

example.fail() {
  expected="*world" # specifies 'world' must be at the end
  actual="Hello world Foo"

  e.g. assertions : assertWildcard "$expected" "$actual"
  e.g. assertThat : assertThat "$actual" has wildcards "$expected"
  e.g. expect     : expect "$actual" has wildcards "$expected"
  e.g. should     : {{ "$actual" }} should have wildcards "$expected"

  assertStderr 'Actual: "Hello world Foo"'
  assertStderr 'Expected: "*world"'
}

example.pass() {
  expected="*world" # specifies 'world' must be at the end
  actual="Hello world"

  e.g. assertions : assertWildcard "$expected" "$actual"
  e.g. assertThat : assertThat "$actual" has wildcards "$expected"
  e.g. expect     : expect "$actual" has wildcards "$expected"
  e.g. should     : {{ "$actual" }} should have wildcards "$expected"
}

example.not.fail() {
  expected="*world" # specifies 'world' must be at the end
  actual="Hello world"

  e.g. assertions : assertNotWildcard "$expected" "$actual"
  e.g. assertThat : assertThat "$actual" does not have wildcards "$expected"
  e.g. expect     : expect "$actual" not to have wildcards "$expected"
  e.g. should     : {{ "$actual" }} should not have wildcards "$expected"

  assertStderr 'Actual: "Hello world"'
  assertStderr 'Unexpected: "*world"'
}

example.not.pass() {
  expected="*world" # specifies 'world' must be at the end
  actual="Hello world Foo"

  e.g. assertions : assertNotWildcard "$expected" "$actual"
  e.g. assertThat : assertThat "$actual" does not have wildcards "$expected"
  e.g. expect     : expect "$actual" not to have wildcards "$expected"
  e.g. should     : {{ "$actual" }} should not have wildcards "$expected"
}

runExamples