ExpectMatcher.length.TEXT() {
  (( $# == 0 )) && { echo "Missing required argument for 'length' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  local -i __expect__length=0
  local __expect__length__actual=
  (( ${#EXPECT_ACTUAL[@]} > 0 )) && __expect__length__actual="${EXPECT_ACTUAL[0]}"
  __expect__length="${#__expect__length__actual}"

  if [ "$EXPECT_NOT" = true ] && [ "$__expect__length" = "$1" ]; then
    printf "Expected text value not to have specified length\nText: %s\nLength: %s\n" "$( ExpectMatchers.utils.inspect "$__expect__length__actual" )" "$__expect__length" >&2
    return 56
  elif [ "$EXPECT_NOT" != true ] && [ "$__expect__length" != "$1" ]; then
    printf "Expected text value to have specified length\nText: %s\nActual Length: %s\nExpected Length: %s\n" "$( ExpectMatchers.utils.inspect "$__expect__length__actual" )" "$__expect__length" "$1" >&2
    return 56
  fi

  return 0
}

ExpectMatcher.length.LIST() {
  (( $# == 0 )) && { echo "Missing required argument for 'length' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  if [ "$EXPECT_NOT" = true ] && [ "${#EXPECT_ACTUAL[@]}" = "$1" ]; then
    printf "Expected list not to have specified length\nList: (%s)\nLength: %s\n" "$( ExpectMatchers.utils.inspectList "${EXPECT_ACTUAL[@]}" )" "${#EXPECT_ACTUAL[@]}" >&2
    return 56
  elif [ "$EXPECT_NOT" != true ] && [ "${#EXPECT_ACTUAL[@]}" != "$1" ]; then
    printf "Expected list to have specified length\nList: (%s)\nActual Length: %s\nExpected Length: %s\n" "$( ExpectMatchers.utils.inspectList "${EXPECT_ACTUAL[@]}" )" "${#EXPECT_ACTUAL[@]}" "$1" >&2
    return 56
  fi

  return 0
}

ExpectMatcher.length.ARRAY_NAME() {
  (( $# == 0 )) && { echo "Missing required argument for 'length' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  if declare -p "$EXPECT_ACTUAL" 2>&1 | grep "^declare -a " &>/dev/null; then
    if [ "$EXPECT_BASH_NAME_REFERENCES" = true ]; then
      local -n __array__="$EXPECT_ACTUAL"
    else
      eval "local -a __array__=(\"\${$EXPECT_ACTUAL[@]}\")"
    fi
    if [ "$EXPECT_NOT" = true ] && [ "${#__array__[@]}" = "$1" ]; then
      printf "Expected array not to have specified length\nArray: %s\nArray Items: (%s)\nLength: %s\n" "$EXPECT_ACTUAL" "$( ExpectMatchers.utils.inspectList "${__array__[@]}" )" "${#__array__[@]}" >&2
      return 56
    elif [ "$EXPECT_NOT" != true ] && [ "${#__array__[@]}" != "$1" ]; then
      printf "Expected array to have specified length\nArray: %s\nArray Items: (%s)\nActual Length: %s\nExpected Length: %s\n" "$EXPECT_ACTUAL" "$( ExpectMatchers.utils.inspectList "${__array__[@]}" )" "${#__array__[@]}" "$1" >&2
      return 56
    fi
  else
    echo "Expected array '$EXPECT_ACTUAL' is not defined" >&2
    return 44
  fi

  return 0
}
