expect.matcher.toFail() {
  [ "${#EXPECT_BLOCK[@]}" -lt 1 ] && { echo "toFail requires a block" >&2; exit 1; }

  expect.execute_block allowFailure

  if [ -z "$EXPECT_NOT" ]
  then
    if [ $EXPECT_EXITCODE -eq 0 ]
    then
      expect.fail "Expected to fail, but passed\nCommand: ${EXPECT_BLOCK[@]}\nSTDOUT: $EXPECT_STDOUT\nSTDERR: $EXPECT_STDERR"
    fi
  else
    if [ $EXPECT_EXITCODE -ne 0 ]
    then
      expect.fail "Expected to pass, but failed\nCommand: ${EXPECT_BLOCK[@]}\nSTDOUT: $EXPECT_STDOUT\nSTDERR: $EXPECT_STDERR"
    fi
  fi

  local actualResultOutput="$( echo -ne "$EXPECT_STDERR" | cat -vet )"

  local expectedOutputItem
  for expectedOutputItem in "$@"
  do
    local expectedResultOutput="$( echo -ne "$expectedOutputItem" | cat -vet )"
    if [ -z "$EXPECT_NOT" ]
    then
      if [[ "$EXPECT_STDERR" != *"$expectedOutputItem"* ]]
      then
        expect.fail "Expected STDERR to contain text\nCommand: ${EXPECT_BLOCK[@]}\nSTDERR: '$actualResultOutput'\nExpected text: '$expectedResultOutput'"
      fi
    else
      if [[ "$EXPECT_STDERR" = *"$expectedOutputItem"* ]]
      then
        expect.fail "Expected STDERR not to contain text\nCommand: ${EXPECT_BLOCK[@]}\nSTDERR: '$actualResultOutput'\nUnexpected text: '$expectedResultOutput'"
      fi
    fi
  done

  return 0
}