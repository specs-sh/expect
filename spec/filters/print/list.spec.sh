source spec/helper.sh

include filters/print/list
include filters/text/split filters/text/uppercase
include filters/collections/join

example.print() {
  e.g. assertThat : assertThat [ Hello World ] print
  e.g. expect     : expect [ Hello World ] print
  e.g. should     : :[ Hello World ] print
  assertStdout '("Hello" "World")'
}

example.print.alteredValue() {
  e.g. assertThat : assertThat [ Hello World ] join " " uppercase split " " print
  e.g. expect     : expect [ Hello World ] join " " uppercase split " " print
  e.g. should     : :[ Hello World ] join " " uppercase split " " print
  assertStdout '("HELLO" "WORLD")'
}

runExamples