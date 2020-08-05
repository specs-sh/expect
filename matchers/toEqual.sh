expect.matcher.toEqual() {
  [ $# -ne 1 ] && { echo "toEqual expects 1 argument (expected result), received $# [$*]" >&2; return 1; }

  local actualResult="$( echo -e "$EXPECT_ACTUAL_RESULT" | cat -A )"

  local expectedResult="$( echo -e "$1" | cat -A )"

  if [ -z "$EXPECT_NOT" ]
  then
    if [ "$actualResult" != "$expectedResult" ]
    then
      echo "Expected result to equal\nActual: '$EXPECT_ACTUAL_RESULT'\nExpected: '$expectedResult'" >&2
      return 1
    fi
  else
    if [ "$actualResult" = "$expectedResult" ]
    then
      echo "Expected result not to equal\nActual: '$EXPECT_ACTUAL_RESULT'\nExpected: '$expectedResult'" >&2
      return 1
    fi
  fi

  return 0
}