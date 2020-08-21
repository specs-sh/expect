expect.matcher.toMatch() {
  [ "${#EXPECT_BLOCK[@]}" -eq 0 ] && [ $# -eq 0 ] && { echo "toMatch expects at least 1 argument (BASH regex patterns), received $# [$*]" >&2; exit 1; }

  local actualResult
  if [ "${#EXPECT_BLOCK[@]}" -gt 0 ]
  then
    expect.execute_block
    actualResult="${EXPECT_STDOUT}${EXPECT_STDERR/%"\n"}"
  else
    actualResult="$EXPECT_ACTUAL_RESULT"
  fi

  local actualResultOutput="$( echo -ne "$actualResult" | cat -vet )"

  local pattern
  for pattern in "$@"
  do
    # echo "DOES [$actualResult] =~ [$pattern]"
    if [ -z "$EXPECT_NOT" ]
    then
      if [[ ! "$actualResult" =~ $pattern ]]
      then
        expect.fail "Expected result to match\nActual text: '$actualResultOutput'\nPattern: '$pattern'"
      fi
    else
      if [[ "$actualResult" =~ $pattern ]]
      then
        expect.fail "Expected result not to match\nActual text: '$actualResultOutput'\nPattern: '$pattern'"
      fi
    fi
  done

  return 0
}