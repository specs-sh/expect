ExpectMatcher.empty() {
  if [ "$EXPECT_NOT" = true ] && [ -z "$EXPECT_ACTUAL" ]; then
    printf "Expected text not to have zero-length\nActual: %s\n" \
      "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" >&2
    return 52
  elif [ "$EXPECT_NOT" != true ] && [ -n "$EXPECT_ACTUAL" ]; then
    printf "Expected text to have zero-length\nActual: %s\nExpected: \"\"\n" \
      "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" >&2
    return 52
  fi
  return 0
}