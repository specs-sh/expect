source spec/helper.sh
source should.sh

spec.expect.message.if.no.matcher.found() {
  refute run [ {{ "Hello" }} should noExistingMatcher "Hello" ]
  [[ "$STDERR" = *"No matcher found for arguments: should noExistingMatcher Hello"* ]]
  (( EXITCODE == 3 ))
}
