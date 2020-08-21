expect.matcher.toEqual() {
  [ "${#EXPECT_BLOCK[@]}" -eq 0 ] && [ $# -ne 1 ] && { echo "toEqual expects 1 argument (expected result), received $# [$*]" >&2; exit 1; }

  if [ "${#EXPECT_BLOCK[@]}" -gt 0 ]
  then
    expect.execute_block
    local actualResult="${EXPECT_STDOUT}${EXPECT_STDERR}"
  else
    local actualResult="$EXPECT_ACTUAL_RESULT"
  fi

  local actualResultOutput="$( echo -ne "$actualResult" | cat -vet )"
  local expectedResultOutput="$( echo -ne "$1" | cat -vet )"

  if [ -z "$EXPECT_NOT" ]
  then
    if [ "$actualResultOutput" != "$expectedResultOutput" ]
    then
      expect.fail "Expected result to equal\nActual: '$actualResultOutput'\nExpected: '$expectedResultOutput'"
    fi
  else
    if [ "$actualResultOutput" = "$expectedResultOutput" ]
    then
      expect.fail "Expected result not to equal\nActual: '$actualResultOutput'\nExpected: '$expectedResultOutput'"
    fi
  fi

  return 0
}