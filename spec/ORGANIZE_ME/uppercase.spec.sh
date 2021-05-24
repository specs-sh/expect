source spec/helper.sh

source matchers/equal.sh
source matchers/uppercase.sh

example.ok() {
  e.g. assertThat : assertThat "Hello" uppercase = "hello"
  e.g. expect     : expect "Hello" uppercase to equal "hello"
  e.g. should     : {{ "Hello" }} uppercase should equal "hello"
  assertStderr 'Actual: "HELLO"'
}

runExamples