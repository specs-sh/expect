source spec/helper.sh
source matchers/eq.sh
source should.sh

spec.expect.value.to.eq.value() {
  assert run [ {{ "Hello" }} should eq "Hello" ]
  refute run [ {{ "Hello" }} should eq "World" ]
  [[ "$STDERR" = *"Expected results to equal"* ]]
  [[ "$STDERR" = *"Actual: 'World"* ]]
  [[ "$STDERR" = *"Expected: 'Hello"* ]]
}

spec.expect.value.not.to.eq.value() {
  assert run [ {{ "Hello" }} should not eq "World" ]
  refute run [ {{ "Hello" }} should not eq "Hello" ]
  [[ "$STDERR" = *"Expected results not to equal"* ]]
  [[ "$STDERR" = *"Actual: 'Hello"* ]]
  [[ "$STDERR" = *"Expected: 'Hello"* ]]
}
