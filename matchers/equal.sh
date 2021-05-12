ExpectMatcher.equal() {
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")
  local __expected__="${1//\\n/$'\n'}" # Allow use of "\n" in expected string (translated into real newline)
  if [ "$EXPECT_NOT" = true ] && [ "$EXPECT_ACTUAL" = "$__expected__" ]; then
    printf "Expected results not to equal:\nValue: %s\n" \
      "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" >&2
    return 11
  elif [ "$EXPECT_NOT" != true ] && [ "$EXPECT_ACTUAL" != "$__expected__" ]; then
    printf "Expected results to equal:\nActual: %s\nExpected: %s\n" \
      "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" \
      "$( ExpectMatchers.utils.inspect "$__expected__" )" >&2
    return 11
  fi
  return 0
}
ExpectMatcher.eq() { ExpectMatcher.equal "$@"; }
ExpectMatcher.=() { ExpectMatcher.equal "$@"; }
ExpectMatcher.==() { ExpectMatcher.equal "$@"; }