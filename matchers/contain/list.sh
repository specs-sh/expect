ExpectMatcher.contain.LIST() {
  (( $# == 0 )) && { echo "Missing required argument for list 'contain' matcher: [expected text]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  local expectedPatternFound=
  local actualItem=
  for actualItem in "${EXPECT_ACTUAL[@]}"; do
    if [ "$EXPECT_NOT" = true ] && [[ "$actualItem" = *$1* ]]; then
      printf "Expected list not to contain item with subtext\nActual: %s\nMatching item: %s\nUnexpected: %s\n" "$( Expect.utils.inspectList "${EXPECT_ACTUAL[@]}" )" "$( Expect.utils.inspect "$actualItem" )" "$( Expect.utils.inspect "$1" )" >&2
      return 52
    elif [[ "$actualItem" = *$1* ]]; then
      expectedPatternFound=true
      break
    fi
  done

  if [ "$EXPECT_NOT" != true ] && [ "$expectedPatternFound" != true ]; then
    printf "Expected list to contain item with subtext\nActual: %s\nExpected: %s\n" "$( Expect.utils.inspectList "${EXPECT_ACTUAL[@]}" )" "$( Expect.utils.inspect "$1" )" >&2
    return 52
  fi

  return 0
}