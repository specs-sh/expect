expect.matcher.toEqual() {
  [ $# -ne 1 ] && { echo "toEqual expects 1 argument (expected result), received $# [$*]" >&2; return 1; }
  local expectedResult="$1"
  # test CAT -A
  if [ -z "$EXPECT_NOT" ]
  then
    if [ "$EXPECT_ACTUAL_RESULT" != "$expectedResult" ]
    then
      echo "Expected results to equal\nActual: '$EXPECT_ACTUAL_RESULT'\nExpected: '$expectedResult'" >&2
      return 1
    fi
  else
    if [ "$EXPECT_ACTUAL_RESULT" = "$expectedResult" ]
    then
      echo "Expected results not to equal\nActual: '$EXPECT_ACTUAL_RESULT'\nExpected: '$expectedResult'" >&2
      return 1
    fi
  fi
  # [ "$1" = "$EXPECT_ACTUAL_RESULT" ]
}