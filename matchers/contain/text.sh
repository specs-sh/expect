ExpectMatcher.contain.TEXT() {
  (( $# == 0 )) && { echo "Missing required text argument for 'contain' matcher: [expected text]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  if [ "$EXPECT_NOT" = true ] && [[ "$EXPECT_ACTUAL" = *$1* ]]; then
    printf "Expected text value not to contain subtext\nActual: %s\nUnexpected: %s\n" "$( Expect.utils.inspect "$EXPECT_ACTUAL" )" "$( Expect.utils.inspect "$1" )" >&2
    return 52
  elif [ "$EXPECT_NOT" != true ] && [[ "$EXPECT_ACTUAL" != *$1* ]]; then
    printf "Expected text value to contain subtext\nActual: %s\nExpected: %s\n" "$( Expect.utils.inspect "$EXPECT_ACTUAL" )" "$( Expect.utils.inspect "$1" )" >&2
    return 52
  fi

  return 0
}