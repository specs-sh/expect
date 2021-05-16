source spec/helper.sh
source should.sh

spec.should.message.if.no.matcher.found() {
  refute run [ {{ "Hello" }} should noExistingMatcher "Hello" ]
  [[ "$STDERR" = *"No matcher found for arguments: should noExistingMatcher Hello"* ]]
  (( EXITCODE == 44 ))
}
