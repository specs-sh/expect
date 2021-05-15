ExpectMatcher.exitcode() { EXPECT_ACTUAL="$EXPECT_COMMAND_EXITCODE"; }
ExpectMatcher.stdout() { EXPECT_ACTUAL="$EXPECT_COMMAND_STDOUT"; }
ExpectMatcher.stderr() { EXPECT_ACTUAL="$EXPECT_COMMAND_STDERR"; }
ExpectMatcher.output() { EXPECT_ACTUAL="$EXPECT_COMMAND_STDOUT$EXPECT_COMMAND_STDERR"; }
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