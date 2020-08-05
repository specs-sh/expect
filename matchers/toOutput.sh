expect.matcher.toOutput() {

  [ "${#EXPECT_BLOCK[@]}" -lt 1 ] && { echo "toOutput requires a block" >&2; exit 1; }

  ##
  # ------------------------------------------------------------
  ##

  ##
  # Run block.
  #
  # { No subshell }
  # {{ Subshell }}
  #
  # Available variables:
  # - ___expect___ExitCode
  # - ___expect___STDOUT
  # - ___expect___STDERR
  # - ___expect___OUTPUT
  ##

  local ___expect___Check_STDOUT=""
  local ___expect___Check_STDERR=""

  [ "$1" = "toStdout" ] || [ "$1" = "toSTDOUT" ] && { ___expect___Check_STDOUT=true; shift; }
  [ "$1" = "toStderr" ] || [ "$1" = "toSTDERR" ] && { ___expect___Check_STDERR=true; shift; }

  [ $# -lt 1 ] && { echo "toOutput expects 1 or more arguments, received $#" >&2; exit 1; }

  local ___expect___RunInSubshell=""
  [ "$EXPECT_BLOCK_TYPE" = "{{" ] && ___expect___RunInSubshell=true

  local ___expect___STDOUT_file="$( mktemp )"
  local ___expect___STDERR_file="$( mktemp )"

  local ___expect___RunInSubshell_
  local ___expect___ExitCode
  if [ "$___expect___RunInSubshell" = "true" ]
  then
    ___expect___RunInSubshell_="$( "${EXPECT_BLOCK[@]}" 1>"$___expect___STDOUT_file" 2>"$___expect___STDERR_file" )"
    ___expect___ExitCode=$?
  else
    "${EXPECT_BLOCK[@]}" 1>"$___expect___STDOUT_file" 2>"$___expect___STDERR_file"
    ___expect___ExitCode=$?
  fi

  local ___expect___STDOUT="$( cat "$___expect___STDOUT_file" )"
  local ___expect___STDERR="$( cat "$___expect___STDERR_file" )"
  ___expect___STDOUT="${___expect___STDOUT/%"\n"}"
  ___expect___STDERR="${___expect___STDERR/%"\n"}"
  local ___expect___OUTPUT="${___expect___STDOUT}\n${___expect___STDERR}"

  rm -rf "$___expect___STDOUT_file"
  rm -rf "$___expect___STDERR_file"

  ##
  # ------------------------------------------------------------
  ##

  local ___expect___STDOUT_actual="$( echo -e "$___expect___STDOUT" | cat -A )"
  local ___expect___STDERR_actual="$( echo -e "$___expect___STDERR" | cat -A )"
  local ___expect___OUTPUT_actual="$( echo -e "$___expect___OUTPUT" | cat -A )"

  local ___expect___expected
  for ___expect___expected in "$@"
  do
    local ___expect___ExpectedResult="$( echo -e "$___expect___expected" | cat -A )"
    # STDOUT
    if [ -n "$___expect___Check_STDOUT" ]
    then
      if [ -z "$EXPECT_NOT" ]
      then
        if [[ "$___expect___STDOUT" != *"$___expect___expected"* ]]
        then
          expect.fail "Expected STDOUT to contain text\nSTDOUT: '$___expect___STDOUT_actual'\nExpected text: '$___expect___ExpectedResult'"
        fi
      else
        if [[ "$___expect___STDOUT" = *"$___expect___expected"* ]]
        then
          expect.fail "Expected STDOUT not to contain text\nSTDOUT: '$___expect___STDOUT_actual'\nUnexpected text: '$___expect___ExpectedResult'"
        fi
      fi
    # STDERR:
    elif [ -n "$___expect___Check_STDERR" ]
    then
      if [ -z "$EXPECT_NOT" ]
      then
        if [[ "$___expect___STDERR" != *"$___expect___expected"* ]]
        then
          expect.fail "Expected STDERR to contain text\nSTDERR: '$___expect___STDERR_actual'\nExpected text: '$___expect___ExpectedResult'"
        fi
      else
        if [[ "$___expect___STDERR" = *"$___expect___expected"* ]]
        then
          expect.fail "Expected STDERR not to contain text\nSTDERR: '$___expect___STDERR_actual'\nUnexpected text: '$___expect___ExpectedResult'"
        fi
      fi
    # OUTPUT
    else
      if [ -z "$EXPECT_NOT" ]
      then
        if [[ "$___expect___OUTPUT" != *"$___expect___expected"* ]]
        then
          expect.fail "Expected output to contain text\nOutput: '$___expect___OUTPUT_actual'\nExpected text: '$___expect___ExpectedResult'"
        fi
      else
        if [[ "$___expect___OUTPUT" = *"$___expect___expected"* ]]
        then
          expect.fail "Expected output not to contain text\nOutput: '$___expect___OUTPUT_actual'\nUnexpected text: '$___expect___ExpectedResult'"
        fi
      fi
    fi
  done

  return 0
}