expect.matcher.toOutput() {
  local ___expect___toOutput_Check_STDOUT=""
  local ___expect___toOutput_Check_STDERR=""

  [ "$1" = "toStdout" ] || [ "$1" = "toSTDOUT" ] && { ___expect___toOutput_Check_STDOUT=true; shift; }
  [ "$1" = "toStderr" ] || [ "$1" = "toSTDERR" ] && { ___expect___toOutput_Check_STDERR=true; shift; }

  [ $# -lt 1 ] && { echo "toOutput expects 1 or more arguments, received $#" >&2; exit 1; }

  local ___expect___toOutput_RunInSubshell=""
  [ "$EXPECT_BLOCK_TYPE" = "{{" ] && ___expect___toOutput_RunInSubshell=true

  local ___expect___toOutput_STDOUT_file="$( mktemp )"
  local ___expect___toOutput_STDERR_file="$( mktemp )"

  local ___expect___toOutput_RunInSubshell_
  local ___expect___toOutput_ExitCode
  if [ "$___expect___toOutput_RunInSubshell" = "true" ]
  then
    ___expect___toOutput_RunInSubshell_="$( "${EXPECT_BLOCK[@]}" 1>"$___expect___toOutput_STDOUT_file" 2>"$___expect___toOutput_STDERR_file" )"
    ___expect___toOutput_ExitCode=$?
  else
    "${EXPECT_BLOCK[@]}" 1>"$___expect___toOutput_STDOUT_file" 2>"$___expect___toOutput_STDERR_file"
    ___expect___toOutput_ExitCode=$?
  fi

  local ___expect___toOutput_STDOUT="$( cat "$___expect___toOutput_STDOUT_file" )"
  local ___expect___toOutput_STDERR="$( cat "$___expect___toOutput_STDERR_file" )"
  local ___expect___toOutput_OUTPUT="${___expect___toOutput_STDOUT}\n${___expect___toOutput_STDERR}"
  local ___expect___toOutput_STDOUT_actual="$( echo -e "$___expect___toOutput_STDOUT" | cat -A )"
  local ___expect___toOutput_STDERR_actual="$( echo -e "$___expect___toOutput_STDERR" | cat -A )"
  local ___expect___toOutput_OUTPUT_actual="$( echo -e "$___expect___toOutput_OUTPUT" | cat -A )"

  rm -rf "$___expect___toOutput_STDOUT_file"
  rm -rf "$___expect___toOutput_STDERR_file"

  local ___expect___toOutput_expected
  for ___expect___toOutput_expected in "$@"
  do
    local ___expect___toOutput_ExpectedResult="$( echo -e "$___expect___toOutput_expected" | cat -A )"
    # STDOUT
    if [ -n "$___expect___toOutput_Check_STDOUT" ]
    then
      if [ -z "$EXPECT_NOT" ]
      then
        if [[ "$___expect___toOutput_STDOUT" != *"$___expect___toOutput_expected"* ]]
        then
          echo "Expected STDOUT to contain text\nSTDOUT: '$___expect___toOutput_STDOUT_actual'\nExpected text: '$___expect___toOutput_ExpectedResult'" >&2
          return 1
        fi
      else
        if [[ "$___expect___toOutput_STDOUT" = *"$___expect___toOutput_expected"* ]]
        then
          echo "Expected STDOUT not to contain text\nSTDOUT: '$___expect___toOutput_STDOUT_actual'\nUnexpected text: '$___expect___toOutput_ExpectedResult'" >&2
          return 1
        fi
      fi
    # STDERR:
    elif [ -n "$___expect___toOutput_Check_STDERR" ]
    then
      if [ -z "$EXPECT_NOT" ]
      then
        if [[ "$___expect___toOutput_STDERR" != *"$___expect___toOutput_expected"* ]]
        then
          echo -e "Expected STDERR to contain text\nSTDERR: '$___expect___toOutput_STDERR_actual'\nExpected text: '$___expect___toOutput_ExpectedResult'" >&2
          exit 1
        fi
      else
        if [[ "$___expect___toOutput_STDERR" = *"$___expect___toOutput_expected"* ]]
        then
          echo -e "Expected STDERR not to contain text\nSTDERR: '$___expect___toOutput_STDERR_actual'\nUnexpected text: '$___expect___toOutput_ExpectedResult'" >&2
          exit 1
        fi
      fi
    # OUTPUT
    else
      if [ -z "$EXPECT_NOT" ]
      then
        if [[ "$___expect___toOutput_OUTPUT" != *"$___expect___toOutput_expected"* ]]
        then
          echo -e "Expected output to contain text\nOutput: '$___expect___toOutput_OUTPUT_actual'\nExpected text: '$___expect___toOutput_ExpectedResult'" >&2
          exit 1
        fi
      else
        if [[ "$___expect___toOutput_OUTPUT" = *"$___expect___toOutput_expected"* ]]
        then
          echo -e "Expected output not to contain text\nOutput: '$___expect___toOutput_OUTPUT_actual'\nUnexpected text: '$___expect___toOutput_ExpectedResult'" >&2
          exit 1
        fi
      fi
    fi
  done

  return 0
}