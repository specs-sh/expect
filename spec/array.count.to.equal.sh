source "${BASH_SOURCE[0]%/*}/helper.sh"

source expect.sh
loadAllMatchers

spec.expect.array.count.to.equal.value() {
  return 1
  # assert run expect "Hello" to equal "Hello"
  # refute run expect "Hello" to equal "World"
  # [[ "$STDERR" = *"Expected results to equal"* ]]
  # [[ "$STDERR" = *"Actual: 'World"* ]]
  # [[ "$STDERR" = *"Expected: 'Hello"* ]]
}

spec.expect.array.count.not.to.equal.value() {
  return 1
  # assert run expect "Hello" not to equal "World"
  # refute run expect "Hello" not to equal "Hello"
  # [[ "$STDERR" = *"Expected results not to equal"* ]]
  # [[ "$STDERR" = *"Actual: 'Hello"* ]]
  # [[ "$STDERR" = *"Expected: 'Hello"* ]]
}
