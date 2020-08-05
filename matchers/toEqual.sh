expect.matcher.toEqual() {
  [ $# -ne 1 ] && { echo "toEqual expects 1 argument (expected result), received $# [$*]" >&2; exit 1; }

  local actualResultOutput="$( echo -ne "$EXPECT_ACTUAL_RESULT" | cat -A )"
  local expectedResultOutput="$( echo -ne "$1" | cat -A )"

  if [ -z "$EXPECT_NOT" ]
  then
    if [ "$EXPECT_ACTUAL_RESULT" != "$1" ]
    then
      echo "Expected result to equal\nActual: '$actualResultOutput'\nExpected: '$expectedResultOutput'" >&2
      exit 1
    fi
  else
    if [ "$EXPECT_ACTUAL_RESULT" = "$1" ]
    then
      echo "Expected result not to equal\nActual: '$actualResultOutput'\nExpected: '$expectedResultOutput'" >&2
      exit 1
    fi
  fi

  return 0
}