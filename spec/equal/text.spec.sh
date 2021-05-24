source spec/helper.sh

source matchers/equal/text.sh

example.fail() {
  e.g. assertions : assertEqual World Hello
  e.g. assertThat : assertThat Hello equals World
  e.g. brackets   : [: "Hello" = "World" ]
  e.g. expect     : expect Hello to equal World
  e.g. should     : {{ Hello }} should equal World
  assertStderr 'Actual: "Hello"'
  assertStderr 'Expected: "World"'
}

example.pass() {
  e.g. assertions : assertEqual Hello Hello
  e.g. assertThat : assertThat Hello equals Hello
  e.g. brackets   : [: "Hello" = "Hello" ]
  e.g. expect     : expect Hello to equal Hello
  e.g. should     : {{ Hello }} should equal Hello
}

example.not.fail() {
  e.g. assertions : assertNotEqual Hello Hello
  e.g. assertThat : assertThat Hello does not equal Hello
  e.g. brackets   : [: "Hello" != "Hello" ]
  e.g. expect     : expect Hello not to equal Hello
  e.g. should     : {{ Hello }} should not equal Hello
  assertStderr 'Text: "Hello"'
}

# xexample.not.pass() {
#   :
# }

runExamples