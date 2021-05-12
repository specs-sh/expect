source spec/helper.sh
source matchers/eq.sh
source assertThat.sh

spec.assertThat.value.eq.value() {
  assert run assertThat "Hello" eq "Hello"
  refute run assertThat "Hello" eq "World"
  [[ "$STDERR" = *"Expected results to equal"* ]]
  [[ "$STDERR" = *"Actual: 'World"* ]]
  [[ "$STDERR" = *"Expected: 'Hello"* ]]
}


spec.assertThat.value.not.eq.value() {
  assert run assertThat "Hello" not eq "World"
  refute run assertThat "Hello" not eq "Hello"
  [[ "$STDERR" = *"Expected results not to equal"* ]]
  [[ "$STDERR" = *"Actual: 'Hello"* ]]
  [[ "$STDERR" = *"Expected: 'Hello"* ]]
}
