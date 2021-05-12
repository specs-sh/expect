ExpectMatcher.exitcode() { EXPECT_ACTUAL="$EXPECT_COMMAND_EXITCODE"; return 0; }
ExpectMatcher.stdout() { EXPECT_ACTUAL="$EXPECT_COMMAND_STDOUT"; return 0; }
ExpectMatcher.stderr() { EXPECT_ACTUAL="$EXPECT_COMMAND_STDERR"; return 0; }
ExpectMatcher.output() { EXPECT_ACTUAL="$EXPECT_COMMAND_STDOUT$EXPECT_COMMAND_STDERR"; return 0; }
ExpectMatcher.fail() {
  if [ "$EXPECT_NOT" = true ] && [ "$EXPECT_COMMAND_EXITCODE" != "0" ]; then
    printf "Expected command not to fail:\nCommand: %s\nExit code: %s\n" "${EXPECT_COMMAND[*]}" "$EXPECT_COMMAND_EXITCODE" >&2
    return 61
  elif [ "$EXPECT_NOT" != true ] && [ "$EXPECT_COMMAND_EXITCODE" = "0" ]; then
    printf "Expected command to fail, but passed:\nCommand: %s\n" "${EXPECT_COMMAND[*]}" >&2
    return 61
  fi
  return 0
}
ExpectMatcher.pass() {
  if [ "$EXPECT_NOT" = true ] && [ "$EXPECT_COMMAND_EXITCODE" = "0" ]; then
    printf "Expected command not to pass:\nCommand: %s\n" "${EXPECT_COMMAND[*]}" >&2
    return 61
  elif [ "$EXPECT_NOT" != true ] && [ "$EXPECT_COMMAND_EXITCODE" != "0" ]; then
    printf "Expected command to pass:\nCommand: %s\nExit code: %s\n" "${EXPECT_COMMAND[*]}" "$EXPECT_COMMAND_EXITCODE" >&2
    return 61
  fi
  return 0
}
ExpectMatcher.ok() { ExpectMatcher.pass "$@"; }
ExpectMatcher.succeed() { ExpectMatcher.pass "$@"; }