ExpectMatcher.equal.LIST() {
  (( ${#EXPECT_ACTUAL[@]} == 0 )) && { echo "Missing required list value(s) for list 'equal' matcher, none specified" &>2; return 40; }

  # The list equal matcher reads *everything* to the right hand side (unlike most matchers)
  # This means that no matchers can come *after* this (when using multiple assertions in one line)
  EXPECT_ARGUMENTS=()

  local actualEqualsExpected=true
  
  if (( $# == ${#EXPECT_ACTUAL[@]} )); then
    local -i index=0
    local -a expectedList=("$@")
    for (( index=0 ; index < $# ; index++ )); do
      if [ "${expectedList[index]}" != "${EXPECT_ACTUAL[index]}" ]; then
        actualEqualsExpected=
        break
      fi
    done
  else
    actualEqualsExpected=
  fi

  if [ "${EXPECT_NOT:-}" != true ] && [ "$actualEqualsExpected" != true ]; then
    printf "Expected list value(s) to equal provided value(s)\nActual: (%s)\nExpected: (%s)\n" "$( Expect.utils.inspectList "${EXPECT_ACTUAL[@]}" )" "$( Expect.utils.inspectList "$@" )" >&2
    return 50
  elif [ "${EXPECT_NOT:-}" = true ] && [ "$actualEqualsExpected" = true ]; then
    printf "Expected list value(s) not to equal provided value(s)\nActual: (%s)\nExpected: (%s)\n" "$( Expect.utils.inspectList "${EXPECT_ACTUAL[@]}" )" "$( Expect.utils.inspectList "$@" )" >&2
    return 50
  fi

  return 0
}
ExpectMatcher.eq.LIST() { ExpectMatcher.equal.LIST "$@"; }
ExpectMatcher.=.LIST() { ExpectMatcher.equal.LIST "$@"; }
ExpectMatcher.==.LIST() { ExpectMatcher.equal.LIST "$@"; }
ExpectMatcher.!=.LIST() { EXPECT_NOT=true ExpectMatcher.equal.LIST "$@"; }