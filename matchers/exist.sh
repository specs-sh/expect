ExpectMatcher.exist.FILE() {
  if [ "$EXPECT_NOT" = true ] && [ -f "${EXPECT_ACTUAL[0]}" ]; then
    printf "Expected file not to exist\nFile Path: %s\n" "$( Expect.utils.inspect "${EXPECT_ACTUAL[0]}" )" >&2
    return 61
  elif [ "$EXPECT_NOT" != true ] && [ ! -f "${EXPECT_ACTUAL[0]}" ]; then
    printf "Expected file to exist\nFile Path: %s\n" "$( Expect.utils.inspect "${EXPECT_ACTUAL[0]}" )" >&2
    return 61
  fi

  return 0
}

ExpectMatcher.exist.PATH() {
  if [ "$EXPECT_NOT" = true ] && [ -e "${EXPECT_ACTUAL[0]}" ]; then
    printf "Expected path not to exist\nPath: %s\n" "$( Expect.utils.inspect "${EXPECT_ACTUAL[0]}" )" >&2
    return 61
  elif [ "$EXPECT_NOT" != true ] && [ ! -e "${EXPECT_ACTUAL[0]}" ]; then
    printf "Expected path to exist\nPath: %s\n" "$( Expect.utils.inspect "${EXPECT_ACTUAL[0]}" )" >&2
    return 61
  fi

  return 0
}

ExpectMatcher.exist.DIRECTORY() {
  if [ "$EXPECT_NOT" = true ] && [ -d "${EXPECT_ACTUAL[0]}" ]; then
    printf "Expected directory not to exist\nDirectory Path: %s\n" "$( Expect.utils.inspect "${EXPECT_ACTUAL[0]}" )" >&2
    return 61
  elif [ "$EXPECT_NOT" != true ] && [ ! -d "${EXPECT_ACTUAL[0]}" ]; then
    printf "Expected directory to exist\nDirectory Path: %s\n" "$( Expect.utils.inspect "${EXPECT_ACTUAL[0]}" )" >&2
    return 61
  fi

  return 0
}