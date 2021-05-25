ExpectMatcher.equal.ARRAY_NAME() {
  # The list equal matcher reads *everything* to the right hand side (unlike most matchers)
  # This means that no matchers can come *after* this (when using multiple assertions in one line)
  EXPECT_ARGUMENTS=()

  # Use name for expected array which is very very very unlikely to collide with real array name.
  # To be doubly certain, we do not use a name reference if a variable with this name already exists
  # otherwise a circular reference will be created resulting in the error:
  # > "nameref variable self references not allowed"
  if [ "$EXPECT_BASH_NAME_REFERENCES" = true ] && ! declare -p __the__expected__array__ &>/dev/null; then
    local -n __the__expected__array__="$EXPECT_ACTUAL"
  else
    eval "local -a __the__expected__array__=(\"\${$EXPECT_ACTUAL[@]}\")"
  fi

  local actualEqualsExpected=true
  
  if (( $# == ${#__the__expected__array__[@]} )); then
    local -i index=0
    local -a expectedList=("$@")
    for (( index=0 ; index < $# ; index++ )); do
      if [ "${expectedList[index]}" != "${__the__expected__array__[index]}" ]; then
        actualEqualsExpected=
        break
      fi
    done
  else
    actualEqualsExpected=
  fi

  if [ "${EXPECT_NOT:-}" != true ] && [ "$actualEqualsExpected" != true ]; then
    printf "Expected array elements(s) to equal provided value(s)\nArray: %s\nActual Elements: %s\nExpected Values: %s\n" "$EXPECT_ACTUAL" "$( Expect.utils.inspectList "${__the__expected__array__[@]}" )" "$( Expect.utils.inspectList "$@" )" >&2
    return 50
  elif [ "${EXPECT_NOT:-}" = true ] && [ "$actualEqualsExpected" = true ]; then
    printf "Expected array elements(s) not to equal provided value(s)\nArray: %s\nValues: %s\n" "$EXPECT_ACTUAL" "$( Expect.utils.inspectList "${__the__expected__array__[@]}" )" >&2
    return 50
  fi

  return 0
}
ExpectMatcher.eq.ARRAY_NAME() { ExpectMatcher.equal.ARRAY_NAME "$@"; }
ExpectMatcher.=.ARRAY_NAME() { ExpectMatcher.equal.ARRAY_NAME "$@"; }
ExpectMatcher.==.ARRAY_NAME() { ExpectMatcher.equal.ARRAY_NAME "$@"; }
ExpectMatcher.!=.ARRAY_NAME() { EXPECT_NOT=true ExpectMatcher.equal.ARRAY_NAME "$@"; }