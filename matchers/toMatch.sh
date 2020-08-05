expect.matcher.toMatch() {
  [ $# -lt 1 ] && { echo "toMatch expects at least 1 argument (BASH regex patterns), received $# [$*]" >&2; exit 1; }

  local actualResultOutput="$( echo -ne "$EXPECT_ACTUAL_RESULT" | cat -A )"

  local pattern
  for pattern in "$@"
  do
    if [ -z "$EXPECT_NOT" ]
    then
      if [[ ! "$EXPECT_ACTUAL_RESULT" =~ $pattern ]]
      then
        echo -e "Expected result to match\nActual text: '$actualResultOutput'\nPattern: '$pattern'" >&2
        exit 1
      fi
    else
      if [[ "$EXPECT_ACTUAL_RESULT" =~ $pattern ]]
      then
        echo -e "Expected result not to match\nActual text: '$actualResultOutput'\nPattern: '$pattern'" >&2
        exit 1
      fi
    fi
  done

  return 0
}