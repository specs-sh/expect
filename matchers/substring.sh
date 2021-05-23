ExpectMatcher.substring.TEXT() {
  (( $# == 0 )) && { echo "Missing required argument for 'substring' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")
  if [ "$EXPECT_NOT" = true ] && [[ "$EXPECT_ACTUAL" = *"$1"* ]]; then
    printf "Expected text value not to contain substring:\nActual: %s\nUnexpected: %s\n" \
      "$( Expect.utils.inspect "$EXPECT_ACTUAL" )" \
      "$( Expect.utils.inspect "$1" )" >&2
    return 55
  elif [ "$EXPECT_NOT" != true ] && [[ "$EXPECT_ACTUAL" != *"$1"* ]]; then
    printf "Expected text value to contain substring:\nActual: %s\nExpected: %s\n" \
      "$( Expect.utils.inspect "$EXPECT_ACTUAL" )" \
      "$( Expect.utils.inspect "$1" )" >&2
    return 55
  fi
  return 0
}