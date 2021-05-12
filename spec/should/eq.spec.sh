source spec/helper.sh
source matchers/eq.sh
source should.sh

spec.value.should.eq.value() {
  assert run [ {{ "Hello" }} eq "Hello" ]
  refute run [ {{ "Hello" }} eq "World" ]
  [[ "$STDERR" = *"Expected results to equal"* ]]
  [[ "$STDERR" = *"Actual: 'World"* ]]
  [[ "$STDERR" = *"Expected: 'Hello"* ]]
}

spec.value.should.not.eq.value() {
  assert run [ {{ "Hello" }} not eq "World" ]
  refute run [ {{ "Hello" }} not eq "Hello" ]
  [[ "$STDERR" = *"Expected results not to equal"* ]]
  [[ "$STDERR" = *"Actual: 'Hello"* ]]
  [[ "$STDERR" = *"Expected: 'Hello"* ]]
}