expect.matcher.toEqual() {
  local negateResults="$1"; shift
  local actualResult="$1"; shift
  local expectedResult="$1"
  actualResult="$( echo -e "$actualResult" | cat -A )"
  expectedResult="$( echo -e "$expectedResult" | cat -A )"
  if [ "$actualResult" = "$expectedResult" ]
  then
    [ "$negateResults" = "true" ] && expect._failureMessage "$negateResults" equal "'$actualResult'" "'$expectedResult'"
  else
    [ "$negateResults" != "true" ] && expect._failureMessage "$negateResults" equal "'$actualResult'" "'$expectedResult'"
  fi
  return 0
} 