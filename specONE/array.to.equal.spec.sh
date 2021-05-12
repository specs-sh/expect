source "${BASH_SOURCE[0]%/*}/helper.sh"

source expect.sh
loadAllMatchers

spec.expect.array.to.equal.values() {
  items=( a b c )
  assert run expect items array to equal a b c
  refute run expect items array to equal c b a
  [[ "$STDERR" = *"Expected array to equal"* ]]
  [[ "$STDERR" = *"Actual: 'a' 'b' 'c'"* ]]
  [[ "$STDERR" = *"Expected: 'c' 'b' 'a'"* ]]
}

spec.expect.array.not.to.equal.values() {
  items=( a b c )
  assert run expect items array not to equal c b a
  refute run expect items array not to equal a b c
  [[ "$STDERR" = *"Expected array not to equal"* ]]
  [[ "$STDERR" = *"Actual: 'a' 'b' 'c'"* ]]
  [[ "$STDERR" = *"Expected: 'a' 'b' 'c'"* ]]
}