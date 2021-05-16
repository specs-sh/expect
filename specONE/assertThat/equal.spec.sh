source spec/helper.sh
source matchers/equal.sh
source assertThat.sh

spec.assertThat.value.equal.value() {
  assert run assertThat "Hello" equals "Hello"
  refute run assertThat "Hello" equals "World"
  [[ "$STDERR" = *"Expected results to equal"* ]]
  [[ "$STDERR" = *"Actual: 'Hello"* ]]
  [[ "$STDERR" = *"Expected: 'World"* ]]
}

spec.assertThat.value.not.equal.value() {
  assert run assertThat "Hello" not equals "World"
  refute run assertThat "Hello" not equals "Hello"
  [[ "$STDERR" = *"Expected results not to equal"* ]]
  [[ "$STDERR" = *"Value: 'Hello"* ]]
}
