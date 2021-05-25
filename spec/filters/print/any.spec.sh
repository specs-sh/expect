source spec/helper.sh

source filters/print/any.sh
source filters/text/uppercase.sh

example.print() {
  e.g. assertThat : assertThat "Hello, world!" print
  e.g. expect     : expect "Hello, world!" print
  e.g. should     : {{ "Hello, world!" }} print
  assertStdout "Hello, world!"
}

example.print.alteredValue() {
  e.g. assertThat : assertThat "Hello, world!" uppercase print
  e.g. expect     : expect "Hello, world!" uppercase print
  e.g. should     : {{ "Hello, world!" }} uppercase print
  assertStdout "HELLO, WORLD!"
}

runExamples