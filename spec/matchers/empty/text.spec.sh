source spec/helper.sh

source matchers/empty/text.sh

example.fail() {
  text="Hello"
  e.g. assertions : assertEmpty "$text"
  e.g. assertThat : assertThat "$text" is empty
  e.g. brackets   : [: -z "$text" ]
  e.g. brackets   : [: ! -n "$text" ]
  e.g. expect     : expect "$text" to be empty
  e.g. should     : {{ "$text" }} should be empty
  assertStderr 'Actual: "Hello"'
}

example.pass() {
  text=""
  e.g. assertions : assertEmpty "$text"
  e.g. assertThat : assertThat "$text" is empty
  e.g. brackets   : [: -z "$text" ]
  e.g. brackets   : [: ! -n "$text" ]
  e.g. expect     : expect "$text" to be empty
  e.g. should     : {{ "$text" }} should be empty
}

example.not.fail() {
  text=""
  e.g. assertions : assertNotEmpty "$text"
  e.g. assertThat : assertThat "$text" is not empty
  e.g. brackets   : [: -n "$text" ]
  e.g. brackets   : [: ! -z "$text" ]
  e.g. expect     : expect "$text" not to be empty
  e.g. should     : {{ "$text" }} should not be empty
}

example.not.pass() {
  text="Hello"
  e.g. assertions : assertNotEmpty "$text"
  e.g. assertThat : assertThat "$text" is not empty
  e.g. brackets   : [: -n "$text" ]
  e.g. brackets   : [: ! -z "$text" ]
  e.g. expect     : expect "$text" not to be empty
  e.g. should     : {{ "$text" }} should not be empty
}

runExamples