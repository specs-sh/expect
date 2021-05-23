ExpectMatcher.include.LIST() {
  (( $# == 0 )) && { echo "Missing required argument for 'contain' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  local __expected__found=
  local __expected__item=
  for __expected__item in "${EXPECT_ACTUAL[@]}"; do
    if [ "$EXPECT_NOT" = true ] && [ "$__expected__item" = "$1" ]; then
      printf "Expected list not to include item\nList: (%s)\nMatching item: %s\nUnexpected: %s\n" "$( Expect.utils.inspectList "${EXPECT_ACTUAL[@]}" )" "$( Expect.utils.inspect "$__expected__item" )" "$( Expect.utils.inspect "$1" )" >&2
      return 51
    elif [ "$__expected__item" = "$1" ]; then
      __expected__found=true
      break
    fi
  done

  if [ "$EXPECT_NOT" != true ] && [ "$__expected__found" != true ]; then
    printf "Expected list to include item\nList: (%s)\nExpected: %s\n" "$( Expect.utils.inspectList "${EXPECT_ACTUAL[@]}" )" "$( Expect.utils.inspect "$1" )" >&2
    return 51
  fi

  return 0
}

ExpectMatcher.include.ARRAY_NAME() {
  (( $# == 0 )) && { echo "Missing required argument for 'contain' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  if [ "$EXPECT_BASH_NAME_REFERENCES" = true ]; then
    local -n __expected__array="${EXPECT_ACTUAL[0]}"
  else
    eval "local -a __expected__array=(\"\${$EXPECT_ACTUAL[@]}\")"
  fi

  local __expected__found=
  local __expected__item=
  for __expected__item in "${__expected__array[@]}"; do
    if [ "$EXPECT_NOT" = true ] && [ "$__expected__item" = "$1" ]; then
      printf "Expected array not to include element\nArray variable: %s\nElements: (%s)\nMatching item: %s\nUnexpected: %s\n" "${EXPECT_ACTUAL[0]}" "$( Expect.utils.inspectList "${__expected__array[@]}" )" "$( Expect.utils.inspect "$__expected__item" )" "$( Expect.utils.inspect "$1" )" >&2
      return 51
    elif [ "$__expected__item" = "$1" ]; then
      __expected__found=true
      break
    fi
  done

  if [ "$EXPECT_NOT" != true ] && [ "$__expected__found" != true ]; then
    printf "Expected array to include element\nArray variable: %s\nElements: (%s)\nExpected: %s\n" "${EXPECT_ACTUAL[0]}" "$( Expect.utils.inspectList "${__expected__array[@]}" )" "$( Expect.utils.inspect "$1" )" >&2
    return 51
  fi

  return 0
}