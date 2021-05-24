ExpectMatcher.equal.LIST() {
  (( ${#EXPECT_ACTUAL[@]} == 0 )) && { echo "Missing required value for 'equal' matcher, none specified" &>2; return 40; }
  EXPECT_ARGUMENTS=() # We take everything on the right side

  local __expected__list__index=0
  local __expected__list__actualEqualsExpected=true
  
  if (( $# == ${#EXPECT_ACTUAL[@]} )); then
    local -a __expected__list__expected=("$@")
    for (( __expected__list__index=0 ; __expected__list__index < $# ; __expected__list__index++ )); do
      if [ "${__expected__list__expected[__expected__list__index]}" != "${EXPECT_ACTUAL[__expected__list__index]}" ]; then
        __expected__list__actualEqualsExpected=
        break
      fi
    done
  else
    __expected__list__actualEqualsExpected=
  fi

  if [ "${EXPECT_NOT:-}" = true ] && [ "$__expected__list__actualEqualsExpected" = true ]; then
    printf "Expected list not to equal provided values:\nActual: (%s)\nExpected: (%s)\n" "$( Expect.utils.inspectList "${EXPECT_ACTUAL[@]}" )" "$( Expect.utils.inspectList "$@" )" >&2
    return 50
  elif [ "${EXPECT_NOT:-}" != true ] && [ "$__expected__list__actualEqualsExpected" != true ]; then
    printf "Expected list to equal provided values:\nActual: (%s)\nExpected: (%s)\n" "$( Expect.utils.inspectList "${EXPECT_ACTUAL[@]}" )" "$( Expect.utils.inspectList "$@" )" >&2
    return 50
  fi

  return 0
}
ExpectMatcher.eq.LIST() { ExpectMatcher.equal.LIST "$@"; }
ExpectMatcher.=.LIST() { ExpectMatcher.equal.LIST "$@"; }
ExpectMatcher.==.LIST() { ExpectMatcher.equal.LIST "$@"; }