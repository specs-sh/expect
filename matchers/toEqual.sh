expect.matcher.toEqual() {
  local negateResults="$1"; shift
  local actualResult="$1";  shift
  local expectedResult="$@"
  actualResult="$( echo "$actualResult" | cat -A )"
  expectedResult="$( echo "$*" | cat -A )"
  if [ "$actualResult" = "$expectedResult" ]
  then
    [ "$negateResults" = "true" ] && expect._failureMessage "$negateResults" equal "'$actualResult'" "'$expectedResult'"
  else
    [ "$negateResults" != "true" ] && expect._failureMessage "$negateResults" equal "'$actualResult'" "'$expectedResult'"
  fi
  return 0
} 