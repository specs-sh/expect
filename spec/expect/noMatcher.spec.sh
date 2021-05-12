source spec/helper.sh
source expect.sh

spec.expect.message.if.no.matcher.found() {
  refute run expect "Hello" to noExistingMatcher "Hello"
  [[ "$STDERR" = *"No matcher found for arguments: to noExistingMatcher Hello"* ]]
  (( EXITCODE == 3 ))
}
