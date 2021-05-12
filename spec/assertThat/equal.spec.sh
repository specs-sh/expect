source spec/helper.sh
source matchers/equal.sh
source assertThat.sh

spec.assertThat.value.equal.value() {
  assert run assertThat "Hello" equal "Hello"
  refute run assertThat "Hello" equal "World"
  [[ "$STDERR" = *"Expected results to equal"* ]]
  [[ "$STDERR" = *"Actual: 'World"* ]]
  [[ "$STDERR" = *"Expected: 'Hello"* ]]
}


spec.assertThat.value.not.equal.value() {
  assert run assertThat "Hello" not equal "World"
  refute run assertThat "Hello" not equal "Hello"
  [[ "$STDERR" = *"Expected results not to equal"* ]]
  [[ "$STDERR" = *"Actual: 'Hello"* ]]
  [[ "$STDERR" = *"Expected: 'Hello"* ]]
}
