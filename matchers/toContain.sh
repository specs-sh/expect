expect.matcher.toContain() {
  local negateResults="$1"; shift
  local actualResult="$( echo -ne "$1" | cat -A )";  shift
  for expected in "$@"
  do
    local expectedResult="$( echo -ne "$expected" | cat -A )"
    if [[ "$actualResult" = *"$expectedResult"* ]]
    then
      [ "$negateResults" = "true" ] && fail "Expected text not to contain '$expectedResult'\nActual: $actualResult"
    else
      [ "$negateResults" != "true" ] && fail "Expected text to contain '$expectedResult'\nActual: $actualResult"
    fi
  done
  return 0
}