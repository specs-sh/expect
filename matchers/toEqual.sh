expect.matcher.toEqual() {
  local negateResults="$1"; shift
  local actualResult="$1";  shift
  local expectedResult="$@"
  if [ "$actualResult" = "$expectedResult" ]
  then
    [ "$negateResults" = "true" ] && expect._failureMessage "$negateResults" equal "$actualResult" "$@"
  else
    [ "$negateResults" != "true" ] && expect._failureMessage "$negateResults" equal "$actualResult" "$@"
  fi
  return 0
} 