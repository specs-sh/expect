source spec/helper.sh

source matchers/empty/list.sh

example.fail() {
  text="Hello"
  e.g. assertThat : assertThat [ $text ] is empty
  e.g. expect     : expect [ $text ] to be empty
  e.g. should     : :[ $text ] should be empty
  assertStderr 'Actual: ("Hello")'
}

example.pass() {
  text=""
  e.g. assertThat : assertThat [ $text ] is empty
  e.g. expect     : expect [ $text ] to be empty
  e.g. should     : :[ $text ] should be empty
}

example.not.fail() {
  text=""
  e.g. assertThat : assertThat [ $text ] is not empty
  e.g. expect     : expect [ $text ] not to be empty
  e.g. should     : :[ $text ] should not be empty
}

example.not.pass() {
  text="Hello"
  e.g. assertThat : assertThat [ $text ] is not empty
  e.g. expect     : expect [ $text ] not to be empty
  e.g. should     : :[ $text ] should not be empty
}

runExamples