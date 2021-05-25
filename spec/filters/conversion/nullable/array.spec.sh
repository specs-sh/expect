source spec/helper.sh

source filters/print/array.sh
source filters/conversion/nullable/array.sh

example.noVariableDeclared() {
  e.g. assertThat : assertThat doesNotExist array? print
  assertEmptyStderr
  assertEmptyStdout
  assertPass
}

example.variableNotAnArray() {
  notAnArray=42
  e.g. assertThat : assertThat notAnArray array? print
  assertStderr "Expected array, but variable notAnArray is not an array"
  assertStderr 'Variable notAnArray declaration: declare -- notAnArray="42"'
  assertEmptyStdout
  assertFail
}

example.emptyArray() {
  items=()
  e.g. assertThat : assertThat items array? print
  assertStdout "items=()"
  assertEmptyStderr
  assertPass
}

example.nonEmptyArray() {
  items=( a b c )
  e.g. assertThat : assertThat items array? print
  assertStdout 'items=("a" "b" "c")'
  assertEmptyStderr
  assertPass
}

runExamples