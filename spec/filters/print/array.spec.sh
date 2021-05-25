source spec/helper.sh

source types/array.sh
source types/nullable/array.sh
source filters/print/array.sh

example.arrayDoesNotExist.nullable() {
  # items=( Hello World ) # <--- not defined
  e.g. assertThat : assertThat items array? print
  e.g. expect     : expect items array? print
  e.g. should     : {{ items }} array? print
  assertEmptyStdout
  assertEmptyStderr
  assertPass
}

example.emptyArray() {
  items=()
  e.g. assertThat : assertThat items array print
  e.g. expect     : expect items array print
  e.g. should     : {{ items }} array print
  assertStdout 'items=()'
}

example.nonEmptyArray() {
  items=( Hello World )
  e.g. assertThat : assertThat items array print
  e.g. expect     : expect items array print
  e.g. should     : {{ items }} array print
  assertStdout 'items=("Hello" "World")'
}

runExamples