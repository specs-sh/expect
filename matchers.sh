# TODO get rid of this, it only adds an additional layer of wtf
expect._failureMessage() {
  local negateResults="$1"
  local matcherDescription="$2"
  local actualResult="$3"
  local expectedResult="$4"
  local toOrNotTo=" to "
  local butDidOrDidNot=", but did not"
  if [ "$negateResults" = "true" ]
  then
    toOrNotTo=" not to "
    butDidOrDidNot=", but did"
  fi
  echo "Expected${toOrNotTo}${matcherDescription}${butDidOrDidNot}.\nActual: $actualResult\nExpected: $expectedResult" >&2
  exit 1
}

expect.matcher._toFail() {
  local negateResults="$1"; shift
  local errorMatcher="$1"; shift
  local stderr
  stderr="$( "$@" 2>&1 >/dev/null )"
  local exitcode=$?
  if [ $exitcode -eq 0 ]
  then
    [ "$negateResults" != "true" ] && fail "Expected code block to fail, but it passed ($exitcode): $*.\nSTDERR: $stderr\nExpected STDERR: $errorMatcher"
  else
    if [ -n "$errorMatcher" ]
    then
      if [[ "$stderr" = *"$errorMatcher"* ]]
      then
        [ "$negateResults" = "true" ] && fail "Expected code block error not to match provided text but it matched.\nCode: $*\nSTDERR: $stderr\nMatch text: $errorMatcher"
      else
        [ "$negateResults" != "true" ] && fail "Expected code block to fail with matching text provided but it did not match.\nCode: $*\nSTDERR: $stderr\nExpected error text: $errorMatcher"
      fi
    else
      [ "$negateResults" = "true" ] && fail "Expected code block to run successfully, but failed.\nCode: $*\nSTDERR: $stderr"
    fi
  fi
  return 0
}