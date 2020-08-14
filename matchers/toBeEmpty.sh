expect.matcher.toBeEmpty() {
  [ $# -gt 0 ] && { echo "toBeEmpty expects 0 arguments, received $# [$*]" >&2; exit 1; }

  if [ "${#EXPECT_BLOCK[@]}" -gt 0 ]
  then
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

    rm -rf "$___expect___STDOUT_file"
    rm -rf "$___expect___STDERR_file"
  fi

  ##
  # ------------------------------------------------------------
  ##

  local actualResult
  
  if [ "${#EXPECT_BLOCK[@]}" -gt 0 ]
  then
    actualResult="${___expect___OUTPUT/%"\n"}"
  else
    actualResult="$EXPECT_ACTUAL_RESULT"
  fi

  local actualResultOutput="$( echo -ne "$actualResult" | cat -vet )"

  if [ -z "$EXPECT_NOT" ]
  then
    if [ -n "$actualResult" ]
    then
      expect.fail "Expected result to be empty\nActual: '$actualResultOutput'"
    fi
  else
    if [ -z "$actualResult" ]
    then
      expect.fail "Expected result not to be empty\nActual: '$actualResultOutput'"
    fi
  fi

  return 0
}