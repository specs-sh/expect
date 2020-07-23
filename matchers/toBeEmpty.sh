import @expect/fail

expect.matcher.toBeEmpty() {
  local negateResults="$1"; shift
  local actualResult="$1";  shift
  [ -z "$actualResult" ] && [ "$negateResults" = "true" ] && fail "Expected output not to be empty.\nOutput: $actualResult"
  [ -n "$actualResult" ] && [ "$negateResults" != "true" ] && fail "Expected output to be empty.\nOutput: $actualResult"
  return 0
}