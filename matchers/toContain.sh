expect.matcher.toContain() {
  [ $# -lt 1 ] && { echo "toContain expects 1 or more arguments, received $# [$*]" >&2; return 1; }

  local actualResultOutput="$( echo -ne "$EXPECT_ACTUAL_RESULT" | cat -A )"

  local expected
  for expected in "$@"
  do
    local expectedResultOutput="$( echo -ne "$expected" | cat -A )"

    if [ -z "$EXPECT_NOT" ]
    then
      if [[ "$EXPECT_ACTUAL_RESULT" != *"$expected"* ]]
      then
        echo -e "Expected result to contain text\nActual text: '$actualResultOutput'\nExpected text: '$expectedResultOutput'" >&2
        exit 1
      fi
    else
      if [[ "$EXPECT_ACTUAL_RESULT" = *"$expected"* ]]
      then
        echo -e "Expected result not to contain text\nActual text: '$actualResultOutput'\nUnexpected text: '$expectedResultOutput'" >&2
        exit 1
      fi
    fi
  done

  return 0
}