ExpectMatcher.exist.FILE() {
  if [ "$EXPECT_NOT" = true ] && [ -f "${EXPECT_ACTUAL[0]}" ]; then
    printf "Expected file not to exist\nFile Path: %s\n" "$( Expect.utils.inspect "${EXPECT_ACTUAL[0]}" )" >&2
    return 61
  elif [ "$EXPECT_NOT" != true ] && [ ! -f "${#EXPECT_ACTUAL[0]}" ]; then
    printf "Expected file to exist\nFile Path: %s\n" "$( Expect.utils.inspect "${EXPECT_ACTUAL[0]}" )" >&2
    return 61
  fi

  return 0
}