expect.matcher.toFail() {
  [ "${#EXPECT_BLOCK[@]}" -lt 1 ] && { echo "toFail requires a block" >&2; exit 1; }

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
  local ___expect___OUTPUT="${___expect___STDOUT}\n${___expect___STDERR}"
  local ___expect___STDOUT_actual="$( echo -e "$___expect___STDOUT" | cat -A )"
  local ___expect___STDERR_actual="$( echo -e "$___expect___STDERR" | cat -A )"
  local ___expect___OUTPUT_actual="$( echo -e "$___expect___OUTPUT" | cat -A )"

  rm -rf "$___expect___STDOUT_file"
  rm -rf "$___expect___STDERR_file"

  if [ -z "$EXPECT_NOT" ]
  then
    if [ $___expect___ExitCode -eq 0 ]
    then
      echo "Expected to fail, but passed\nCommand: ${EXPECT_BLOCK[@]}\nSTDOUT: $___expect___STDOUT\nSTDERR: $___expect___STDERR" >&2
      exit 1
    fi
  else
    if [ $___expect___ExitCode -ne 0 ]
    then
      echo "Expected to pass, but failed\nCommand: ${EXPECT_BLOCK[@]}\nSTDOUT: $___expect___STDOUT\nSTDERR: $___expect___STDERR" >&2
      exit 1
    fi
  fi

  local ___expect___expected
  for ___expect___expected in "$@"
  do
    local ___expect___ExpectedResult="$( echo -e "$___expect___expected" | cat -A )"
    if [ -z "$EXPECT_NOT" ]
    then
      if [[ "$___expect___STDERR" != *"$___expect___expected"* ]]
      then
        echo -e "Expected STDERR to contain text\nCommand: ${EXPECT_BLOCK[@]}\nSTDERR: '$___expect___STDERR_actual'\nExpected text: '$___expect___ExpectedResult'" >&2
        exit 1
      fi
    else
      if [[ "$___expect___STDERR" = *"$___expect___expected"* ]]
      then
        echo -e "Expected STDERR not to contain text\nCommand: ${EXPECT_BLOCK[@]}\nSTDERR: '$___expect___STDERR_actual'\nUnexpected text: '$___expect___ExpectedResult'" >&2
        exit 1
      fi
    fi
  done

  return 0
}