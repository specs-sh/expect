ExpectMatcher.empty.LIST() {
  if [ "$EXPECT_NOT" != true ] && (( ${#EXPECT_ACTUAL[@]} > 0 )); then
    printf "Expected list to be empty (zero-length)\nActual: %s\n" "$( Expect.utils.inspectList "${EXPECT_ACTUAL[@]}" )" >&2
    return 51
  elif [ "$EXPECT_NOT" = true ] && (( ${#EXPECT_ACTUAL[@]} == 0 )); then
    printf "Expected list not to be empty (zero-length)\n" >&2
    return 51
  fi

  return 0
}