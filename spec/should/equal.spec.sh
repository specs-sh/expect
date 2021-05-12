source spec/helper.sh
source matchers/equal.sh
source should.sh

spec.value.should.equal.value() {
  assert run [ {{ "Hello" }} should equal "Hello" ]
  refute run [ {{ "Hello" }} should equal "World" ]
  [[ "$STDERR" = *"Expected results to equal"* ]]
  [[ "$STDERR" = *"Actual: 'World"* ]]
  [[ "$STDERR" = *"Expected: 'Hello"* ]]
}

spec.value.should.not.equal.value() {
  assert run [ {{ "Hello" }} should not equal "World" ]
  refute run [ {{ "Hello" }} should not equal "Hello" ]
  [[ "$STDERR" = *"Expected results not to equal"* ]]
  [[ "$STDERR" = *"Actual: 'Hello"* ]]
  [[ "$STDERR" = *"Expected: 'Hello"* ]]
}
