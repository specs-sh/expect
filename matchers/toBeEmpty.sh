expect.matcher.toBeEmpty() {
  [ $# -gt 0 ] && { echo "toBeEmpty expects 0 arguments, received $# [$*]" >&2; exit 1; }

  local ___expect___actualResult
  if [ "${#EXPECT_BLOCK[@]}" -gt 0 ]
  then
    expect.execute_block
    ___expect___actualResult="${EXPECT_STDOUT}${EXPECT_STDERR}"
  else
    ___expect___actualResult="$EXPECT_ACTUAL_RESULT"
  fi

  local actualResultOutput="$( echo -ne "$___expect___actualResult" | cat -vet )"

  if [ -z "$EXPECT_NOT" ]
  then
    if [ -n "$___expect___actualResult" ]
    then
      expect.fail "Expected result to be empty\nActual: '$actualResultOutput'"
    fi
  else
    if [ -z "$___expect___actualResult" ]
    then
      expect.fail "Expected result not to be empty\nActual: '$actualResultOutput'"
    fi
  fi

  return 0
}