ExpectMatcher.uppercase.TEXT() {
  if [ "$EXPECT_BASH_UPPERLOWER" = true ]; then
    EXPECT_ACTUAL=("${EXPECT_ACTUAL[0]^^}")
  else
    EXPECT_ACTUAL=("$( echo "${EXPECT_ACTUAL[0]}" | tr '[:lower:]' '[:upper:]' )")
  fi
  return 0
}