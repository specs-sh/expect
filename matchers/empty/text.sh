ExpectMatcher.empty.TEXT() {
  if [ "$EXPECT_NOT" != true ] && [ -n "${EXPECT_ACTUAL[*]}" ]; then
    printf "Expected text to be empty (zero-length)\nActual: %s\nExpected: \"\"\n" "$( Expect.utils.inspect "${EXPECT_ACTUAL[*]}" )" >&2
    return 51
  elif [ "$EXPECT_NOT" = true ] && [ -z "${EXPECT_ACTUAL[*]}" ]; then
    printf "Expected text not to be empty (zero-length)\nActual: %s\n" "$( Expect.utils.inspect "${EXPECT_ACTUAL[*]}" )" >&2
    return 51
  fi
  
  return 0
}