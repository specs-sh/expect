ExpectMatcher.empty() {
  if [ "$EXPECT_ACTUAL_IS_ARRAY_NAME" = true ]; then
    # CHECK IT EXISTS
    if [ "$EXPECT_BASH_NAME_REFERENCES" = true ]; then
      local -n __array__="$EXPECT_ACTUAL"
      if [ "$EXPECT_NOT" = true ] && (( ${#__array__[@]} == 0 )); then
        printf "Expected array not to have zero elements\nActual: %s\n" \
          "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" >&2
        return 52
      elif [ "$EXPECT_NOT" != true ] && (( ${#__array__[@]} > 0 )); then
        printf "Expected array to have zero elements\nActual: (%s)\nExpected: ( )\n" \
          "$( ExpectMatchers.utils.inspectList "${__array__[@]}" )" >&2
        return 52
      fi
    else
      :
    fi
  else
    if [ "$EXPECT_NOT" = true ] && [ -z "$EXPECT_ACTUAL" ]; then
      printf "Expected text not to have zero-length\nActual: %s\n" \
        "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" >&2
      return 52
    elif [ "$EXPECT_NOT" != true ] && [ -n "$EXPECT_ACTUAL" ]; then
      printf "Expected text to have zero-length\nActual: %s\nExpected: \"\"\n" \
        "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" >&2
      return 52
    fi
  fi
  return 0
}