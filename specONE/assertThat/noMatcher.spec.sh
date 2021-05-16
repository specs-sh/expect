source spec/helper.sh
source assertThat.sh

spec.assertThat.message.if.no.matcher.found() {
  refute run assertThat "Hello" to noExistingMatcher "Hello"
  [[ "$STDERR" = *"No matcher found for arguments: to noExistingMatcher Hello"* ]]
  (( EXITCODE == 44 ))
}
