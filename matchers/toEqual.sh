expect.matcher.toEqual() {
  local negateResults="$1"; shift
  local actualResult="$1";  shift
  local expectedResult="$@"
  if [ "$( echo -e "$actualResult" | cat -A )" = "$( echo -e "$expectedResult" | cat -A )" ]
  then
    [ "$negateResults" = "true" ] && expect._failureMessage "$negateResults" equal "$actualResult" "$@"
  else
    [ "$negateResults" != "true" ] && expect._failureMessage "$negateResults" equal "$actualResult" "$@"
  fi
  return 0
} 