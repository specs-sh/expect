source "${BASH_SOURCE[0]%/*}/helper.sh"

source expect.sh
loadAllMatchers

spec.expect.value.to.equal.value() {
  assert run expect "Hello" to equal "Hello"
  refute run expect "Hello" to equal "World"
  [[ "$STDERR" = *"Expected results to equal"* ]]
  [[ "$STDERR" = *"Actual: 'World"* ]]
  [[ "$STDERR" = *"Expected: 'Hello"* ]]
}

spec.expect.value.not.to.equal.value() {
  assert run expect "Hello" not to equal "World"
  refute run expect "Hello" not to equal "Hello"
  [[ "$STDERR" = *"Expected results not to equal"* ]]
  [[ "$STDERR" = *"Actual: 'Hello"* ]]
  [[ "$STDERR" = *"Expected: 'Hello"* ]]
}
