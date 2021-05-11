expect.matcher.toOutput() {
  local ___expect___ShouldCheckSTDOUT=""
  local ___expect___ShouldCheckSTDERR=""

  [ "${#EXPECT_BLOCK[@]}" -lt 1 ] && { echo "toOutput requires a block" >&2; exit 1; }
  [ "$1" = "toStdout" ] || [ "$1" = "toSTDOUT" ] && { ___expect___ShouldCheckSTDOUT=true; shift; }
  [ "$1" = "toStderr" ] || [ "$1" = "toSTDERR" ] && { ___expect___ShouldCheckSTDERR=true; shift; }
  [ $# -lt 1 ] && { echo "toOutput expects 1 or more arguments, received $#" >&2; exit 1; }

  expect.execute_block || return 1

  local EXPECT_STDOUT_actual="$( echo -e "$EXPECT_STDOUT" | cat -vet )"
  local EXPECT_STDERR_actual="$( echo -e "$EXPECT_STDERR" | cat -vet )"
  local OUTPUT_actual="$( echo -e "${EXPECT_STDOUT}${EXPECT_STDERR}" | cat -vet )"

  local expectedOutputItem
  for expectedOutputItem in "$@"
  do
    local ___expect___ExpectedResult="$( echo -e "$expectedOutputItem" | cat -vet )"
    # STDOUT
    if [ -n "$___expect___ShouldCheckSTDOUT" ]
    then
      if [ -z "$EXPECT_NOT" ]
      then
        if [[ "$EXPECT_STDOUT" != *"$expectedOutputItem"* ]]
        then
          expect.fail "Expected STDOUT to contain text\nSTDOUT: '$EXPECT_STDOUT_actual'\nExpected text: '$___expect___ExpectedResult'"
        fi
      else
        if [[ "$EXPECT_STDOUT" = *"$expectedOutputItem"* ]]
        then
          expect.fail "Expected STDOUT not to contain text\nSTDOUT: '$EXPECT_STDOUT_actual'\nUnexpected text: '$___expect___ExpectedResult'"
        fi
      fi
    # STDERR:
    elif [ -n "$___expect___ShouldCheckSTDERR" ]
    then
      if [ -z "$EXPECT_NOT" ]
      then
        if [[ "$EXPECT_STDERR" != *"$expectedOutputItem"* ]]
        then
          expect.fail "Expected STDERR to contain text\nSTDERR: '$EXPECT_STDERR_actual'\nExpected text: '$___expect___ExpectedResult'"
        fi
      else
        if [[ "$EXPECT_STDERR" = *"$expectedOutputItem"* ]]
        then
          expect.fail "Expected STDERR not to contain text\nSTDERR: '$EXPECT_STDERR_actual'\nUnexpected text: '$___expect___ExpectedResult'"
        fi
      fi
    # OUTPUT
    else
      if [ -z "$EXPECT_NOT" ]
      then
        if [[ "${EXPECT_STDOUT}${EXPECT_STDERR}" != *"$expectedOutputItem"* ]]
        then
          expect.fail "Expected output to contain text\nOutput: '$OUTPUT_actual'\nExpected text: '$___expect___ExpectedResult'"
        fi
      else
        if [[ "${EXPECT_STDOUT}${EXPECT_STDERR}" = *"$expectedOutputItem"* ]]
        then
          expect.fail "Expected output not to contain text\nOutput: '$OUTPUT_actual'\nUnexpected text: '$___expect___ExpectedResult'"
        fi
      fi
    fi
  done

  return 0
}