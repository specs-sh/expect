ExpectMatcher.length() {
  (( $# == 0 )) && { echo "Missing required argument for 'length' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")
  if [ "$EXPECT_NOT" = true ] && [ "${#EXPECT_ACTUAL}" = "$1" ]; then
    printf "Expected text value not to have specified length\nText: %s\nLength: %s\n" \
      "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" "${#EXPECT_ACTUAL}" >&2
    return 56
  elif [ "$EXPECT_NOT" != true ] && [ "${#EXPECT_ACTUAL}" != "$1" ]; then
    printf "Expected text value to have specified length\nText: %s\nActual Length: %s\nExpected Length: %s\n" \
      "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" "${#EXPECT_ACTUAL}" "$1" >&2
    return 56
  fi
  return 0
}