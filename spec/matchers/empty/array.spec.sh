source spec/helper.sh

include types/array
include matchers/empty/array

example.fail() {
  words=("Hello")
  e.g. assertThat : assertThat words array is empty
  e.g. expect     : expect words array to be empty
  e.g. should     : :[ words ] array should be empty
  assertStderr 'Actual: words=("Hello")'
}

example.pass() {
  words=()
  e.g. assertThat : assertThat words array is empty
  e.g. expect     : expect words array to be empty
  e.g. should     : :[ words ] array should be empty
}

example.not.fail() {
  words=()
  e.g. assertThat : assertThat words array is not empty
  e.g. expect     : expect words array not to be empty
  e.g. should     : :[ words ] array should not be empty
  assertStderr 'Actual: words=()'
}

# example.not.pass() {
#   text="Hello"
#   e.g. assertThat : assertThat words array is not empty
#   e.g. expect     : expect words array not to be empty
#   e.g. should     : :[ words ] array should not be empty
# }

runExamples