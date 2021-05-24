source spec/helper.sh

source matchers/equal.sh
source matchers/lowercase.sh

example.ok() {
  e.g. assertThat : assertThat "Hello" lowercase = "HELLO"
  e.g. expect     : expect "Hello" lowercase to equal "HELLO"
  e.g. should     : {{ "Hello" }} lowercase should equal "HELLO"
  assertStderr 'Actual: "hello"'
}

runExamples