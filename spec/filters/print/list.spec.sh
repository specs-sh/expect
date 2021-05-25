source spec/helper.sh

source filters/print/list.sh
source filters/text/split.sh
source filters/text/uppercase.sh
source filters/collections/join.sh

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