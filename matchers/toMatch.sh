expect.matcher.toMatch() {
  local negateResults="$1"; shift
  local actualResult="$1";  shift
  for expected in "$@"
  do
    if [[ "$actualResult" =~ $expected ]]
    then
      [ "$negateResults" = "true" ] && fail "Expected text not to match $expected\nActual: $actualResult"
    else
      [ "$negateResults" != "true" ] && fail "Expected text to match $expected\nActual: $actualResult"
    fi
  done
  return 0
}