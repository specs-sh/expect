ExpectMatcher.array() {
  EXPECT_ACTUAL_IS_ARRAY_NAME=true
  EXPECT_ACTUAL_ARRAY_NAME="$EXPECT_ACTUAL"
}
ExpectMatcher.list() { ExpectMatcher.array "$@"; }