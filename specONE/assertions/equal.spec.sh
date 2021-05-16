source spec/helper.sh
source matchers/equal.sh
source assertions.sh

spec.assertEqual.expected.actual() {
  refute run assertEqual; [[ "$STDERR" = *"assertEqual expected 2 arguments"* ]]
  refute run assertEqual One; [[ "$STDERR" = *"assertEqual expected 2 arguments"* ]]
  refute run assertEqual One Two Three; [[ "$STDERR" = *"assertEqual expected 2 arguments"* ]]

  assert run assertEqual "Hello" "Hello"
  refute run assertEqual "Hello" "World"
  [[ "$STDERR" = *"Expected results to equal"* ]]
  [[ "$STDERR" = *"Actual: 'World"* ]]
  [[ "$STDERR" = *"Expected: 'Hello"* ]]
}

spec.assertEquals.expected.actual() {
  refute run assertEquals; [[ "$STDERR" = *"assertEquals expected 2 arguments"* ]]
  refute run assertEquals One; [[ "$STDERR" = *"assertEquals expected 2 arguments"* ]]
  refute run assertEquals One Two Three; [[ "$STDERR" = *"assertEquals expected 2 arguments"* ]]

  assert run assertEquals "Hello" "Hello"
  refute run assertEquals "Hello" "World"
  [[ "$STDERR" = *"Expected results to equal"* ]]
  [[ "$STDERR" = *"Actual: 'World"* ]]
  [[ "$STDERR" = *"Expected: 'Hello"* ]]
}

spec.assertNotEqual.expected.actual() {
  refute run assertNotEqual; [[ "$STDERR" = *"assertNotEqual expected 2 arguments"* ]]
  refute run assertNotEqual One; [[ "$STDERR" = *"assertNotEqual expected 2 arguments"* ]]
  refute run assertNotEqual One Two Three; [[ "$STDERR" = *"assertNotEqual expected 2 arguments"* ]]

  assert run assertNotEqual "World" "Hello"
  refute run assertNotEqual "Hello" "Hello"
  [[ "$STDERR" = *"Expected results not to equal"* ]]
  [[ "$STDERR" = *"Value: 'Hello"* ]]
}

spec.assertNotEquals.expected.actual() {
  refute run assertNotEquals; [[ "$STDERR" = *"assertNotEquals expected 2 arguments"* ]]
  refute run assertNotEquals One; [[ "$STDERR" = *"assertNotEquals expected 2 arguments"* ]]
  refute run assertNotEquals One Two Three; [[ "$STDERR" = *"assertNotEquals expected 2 arguments"* ]]

  assert run assertNotEquals "World" "Hello"
  refute run assertNotEquals "Hello" "Hello"
  [[ "$STDERR" = *"Expected results not to equal"* ]]
  [[ "$STDERR" = *"Value: 'Hello"* ]]
}
