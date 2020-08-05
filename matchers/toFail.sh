expect.matcher.toFail() {
  local ___expect___toFail_RunInSubshell=""
  [ "$EXPECT_BLOCK_TYPE" = "{{" ] && ___expect___toFail_RunInSubshell=true

  local ___expect___toFail_STDOUT_file="$( mktemp )"
  local ___expect___toFail_STDERR_file="$( mktemp )"

  local ___expect___toFail_RunInSubshell_
  local ___expect___toFail_ExitCode
  if [ "$___expect___toFail_RunInSubshell" = "true" ]
  then
    ___expect___toFail_RunInSubshell_="$( "${EXPECT_BLOCK[@]}" 1>"$___expect___toFail_STDOUT_file" 2>"$___expect___toFail_STDERR_file" )"
    ___expect___toFail_ExitCode=$?
  else
    "${EXPECT_BLOCK[@]}" 1>"$___expect___toFail_STDOUT_file" 2>"$___expect___toFail_STDERR_file"
    ___expect___toFail_ExitCode=$?
  fi

  local ___expect___toFail_STDOUT="$( cat "$___expect___toFail_STDOUT_file" )"
  local ___expect___toFail_STDERR="$( cat "$___expect___toFail_STDERR_file" )"
  local ___expect___toFail_OUTPUT="${___expect___toFail_STDOUT}\n${___expect___toFail_STDERR}"
  local ___expect___toFail_STDOUT_actual="$( echo -e "$___expect___toFail_STDOUT" | cat -A )"
  local ___expect___toFail_STDERR_actual="$( echo -e "$___expect___toFail_STDERR" | cat -A )"
  local ___expect___toFail_OUTPUT_actual="$( echo -e "$___expect___toFail_OUTPUT" | cat -A )"

  rm -rf "$___expect___toFail_STDOUT_file"
  rm -rf "$___expect___toFail_STDERR_file"

  if [ -z "$EXPECT_NOT" ]
  then
    if [ $___expect___toFail_ExitCode -eq 0 ]
    then
      echo "Expected to fail, but passed\nCommand: ${EXPECT_BLOCK[@]}\nSTDOUT: $___expect___toFail_STDOUT\nSTDERR: $___expect___toFail_STDERR" >&2
      exit 1
    fi
  else
    if [ $___expect___toFail_ExitCode -ne 0 ]
    then
      echo "Expected to pass, but failed\nCommand: ${EXPECT_BLOCK[@]}\nSTDOUT: $___expect___toFail_STDOUT\nSTDERR: $___expect___toFail_STDERR" >&2
      exit 1
    fi
  fi

  local ___expect___toFail_expected
  for ___expect___toFail_expected in "$@"
  do
    local ___expect___toFail_ExpectedResult="$( echo -e "$___expect___toFail_expected" | cat -A )"
    if [ -z "$EXPECT_NOT" ]
    then
      if [[ "$___expect___toFail_STDERR" != *"$___expect___toFail_expected"* ]]
      then
        echo -e "Expected STDERR to contain text\nCommand: ${EXPECT_BLOCK[@]}\nSTDERR: '$___expect___toFail_STDERR_actual'\nExpected text: '$___expect___toFail_ExpectedResult'" >&2
        exit 1
      fi
    else
      if [[ "$___expect___toFail_STDERR" = *"$___expect___toFail_expected"* ]]
      then
        echo -e "Expected STDERR not to contain text\nCommand: ${EXPECT_BLOCK[@]}\nSTDERR: '$___expect___toFail_STDERR_actual'\nUnexpected text: '$___expect___toFail_ExpectedResult'" >&2
        exit 1
      fi
    fi
  done
}