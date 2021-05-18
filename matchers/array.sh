ExpectMatcher.array() {
  EXPECT_ACTUAL_TYPE=ARRAY_NAME
}
ExpectMatcher.list() { ExpectMatcher.array "$@"; }