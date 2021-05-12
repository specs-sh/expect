source spec/helper.sh
source matchers/equal.sh
source brackets.sh

spec.value.should.equal.value() {
  assert run { [: "Hello" = "Hello" ] }
  refute run { [: "Hello" = "World" ] }
  [[ "$STDERR" = *"Expected results to equal"* ]]
  [[ "$STDERR" = *"Actual: 'World"* ]]
  [[ "$STDERR" = *"Expected: 'Hello"* ]]
}

spec.value.should.not.equal.value() {
  assert run { [: "Hello" != "World" ] }
  refute run { [: "Hello" != "Hello" ] }
  [[ "$STDERR" = *"Expected results not to equal"* ]]
  [[ "$STDERR" = *"Actual: 'Hello"* ]]
  [[ "$STDERR" = *"Expected: 'Hello"* ]]
}
