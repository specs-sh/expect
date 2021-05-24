ExpectMatcher.equal.TEXT() {
  (( ${#EXPECT_ACTUAL[@]} == 0 )) && { echo "Missing required value for 'equal' matcher, none specified" &>2; return 40; }
  (( $# == 0 )) && { echo "Missing required argument for 'equal' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  if [ "${EXPECT_NOT:-}" = true ] && [ "${EXPECT_ACTUAL[0]}" = "$1" ]; then
    printf "Expected text not to equal provided value\nText: %s\n" "$( Expect.utils.inspect "${EXPECT_ACTUAL[0]}" )" >&2
    return 50
  elif [ "${EXPECT_NOT:-}" != true ] && [ "${EXPECT_ACTUAL[0]}" != "$1" ]; then
    printf "Expected text to equal provided value\nActual: %s\nExpected: %s\n" "$( Expect.utils.inspect "${EXPECT_ACTUAL[0]}" )" "$( Expect.utils.inspect "$1" )" >&2
    return 50
  fi

  return 0
}
ExpectMatcher.eq.TEXT() { ExpectMatcher.equal.TEXT "$@"; }
ExpectMatcher.=.TEXT() { ExpectMatcher.equal.TEXT "$@"; }
ExpectMatcher.==.TEXT() { ExpectMatcher.equal.TEXT "$@"; }