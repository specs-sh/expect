ExpectMatcher.contain.ARRAY_NAME() {
  (( $# == 0 )) && { echo "Missing required argument for array 'contain' matcher: [expected text]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  if [ "$EXPECT_BASH_NAME_REFERENCES" = true ] && ! declare -p __the__expected__array__ &>/dev/null; then
    local -n __the__expected__array__="$EXPECT_ACTUAL"
  else
    eval "local -a __the__expected__array__=(\"\${$EXPECT_ACTUAL[@]}\")"
  fi

  local expectedPatternFound=
  local actualItem=
  for actualItem in "${__the__expected__array__[@]}"; do
    if [ "$EXPECT_NOT" = true ] && [[ "$actualItem" = *$1* ]]; then
      printf "Expected array not to contain item with subtext\nArray: %s\nActual: %s\nUnexpected: %s\n" "${EXPECT_ACTUAL[0]}" "$( Expect.utils.inspectList "${__the__expected__array__[@]}" )" "$( Expect.utils.inspect "$1" )" >&2
      return 51
    elif [[ "$actualItem" = *$1* ]]; then
      expectedPatternFound=true
      break
    fi
  done

  if [ "$EXPECT_NOT" != true ] && [ "$expectedPatternFound" != true ]; then
    printf "Expected array to contain item with subtext\nArray: %s\nActual: %s\nExpected: %s\n" "${EXPECT_ACTUAL[0]}" "$( Expect.utils.inspectList "${__the__expected__array__[@]}" )" "$( Expect.utils.inspect "$1" )" >&2
    return 51
  fi

  return 0
}
