expect.matcher.toBeEmpty() {
  local negateResults="$1"; shift
  local actualResult="$1";  shift
  [ -z "$actualResult" ] && [ "$negateResults" = "true" ] && { echo "Expected output not to be empty.\nOutput: $actualResult" >&2; exit 1; }
  [ -n "$actualResult" ] && [ "$negateResults" != "true" ] && { echo "Expected output to be empty.\nOutput: $actualResult" >&2; exit 1; }
  return 0
}