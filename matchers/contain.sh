ExpectMatcher.contain.TEXT() {
  (( $# == 0 )) && { echo "Missing required argument for 'contain' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")
  if [ "$EXPECT_NOT" = true ] && [[ "$EXPECT_ACTUAL" = *$1* ]]; then
    printf "Expected text value not to contain subtext:\nActual: %s\nUnexpected: %s\n" \
      "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" \
      "$( ExpectMatchers.utils.inspect "$1" )" >&2
    return 51
  elif [ "$EXPECT_NOT" != true ] && [[ "$EXPECT_ACTUAL" != *$1* ]]; then
    printf "Expected text value to contain subtext:\nActual: %s\nExpected: %s\n" \
      "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" \
      "$( ExpectMatchers.utils.inspect "$1" )" >&2
    return 51
  fi
  return 0
}