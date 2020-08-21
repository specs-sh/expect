expect.matcher.toContain() {
  [ "${#EXPECT_BLOCK[@]}" -eq 0 ] && [ $# -eq 0 ] && { echo "toContain expects 1 or more arguments, received $# [$*]" >&2; exit 1; }

  local ___expect___actualResult
  if [ "${#EXPECT_BLOCK[@]}" -gt 0 ]
  then
    expect.execute_block
    ___expect___actualResult="${EXPECT_STDOUT}${EXPECT_STDERR}"
  else
    ___expect___actualResult="$EXPECT_ACTUAL_RESULT"
  fi

  local actualResultOutput="$( echo -ne "$___expect___actualResult" | cat -vet )"

  local expected
  for expected in "$@"
  do
    local expectedResultOutput="$( echo -ne "$expected" | cat -vet )"

    if [ -z "$EXPECT_NOT" ]
    then
      if [[ "$___expect___actualResult" != *"$expected"* ]]
      then
        expect.fail "Expected result to contain text\nActual text: '$actualResultOutput'\nExpected text: '$expectedResultOutput'"
      fi
    else
      if [[ "$___expect___actualResult" = *"$expected"* ]]
      then
        expect.fail "Expected result not to contain text\nActual text: '$actualResultOutput'\nUnexpected text: '$expectedResultOutput'"
      fi
    fi
  done

  return 0
}