ExpectMatcher.empty() {
  if [ "$EXPECT_ACTUAL_IS_ARRAY_NAME" = true ]; then
    if declare -p "$EXPECT_ACTUAL" 2>&1 | grep "^declare -a " &>/dev/null; then
      if [ "$EXPECT_BASH_NAME_REFERENCES" = true ]; then
        local -n __array__="$EXPECT_ACTUAL"
        if [ "$EXPECT_NOT" = true ] && (( ${#__array__[@]} == 0 )); then
          printf "Expected array not to have zero elements\nActual: ( )%s\n"
          return 52
        elif [ "$EXPECT_NOT" != true ] && (( ${#__array__[@]} > 0 )); then
          printf "Expected array to have zero elements\nActual: (%s)\nExpected: ( )\n" "$( ExpectMatchers.utils.inspectList "${__array__[@]}" )" >&2
          return 52
        fi
      else
        local -i __arrayLength__=
        eval "__arrayLength__=\"\${#$EXPECT_ACTUAL}\""
        if [ "$EXPECT_NOT" = true ] && (( __arrayLength__ == 0 )); then
          printf "Expected array not to have zero elements\nActual: ( )%s\n"
          return 52
        elif [ "$EXPECT_NOT" != true ] && (( __arrayLength__ > 0 )); then
          eval "printf \"Expected array to have zero elements\nActual: (%s)\nExpected: ( )\n\" \"\$( ExpectMatchers.utils.inspectList \"\${$EXPECT_ACTUAL[@]}\" )\"" >&2
          return 52
        fi
      fi
    else
      echo "Expected array '$EXPECT_ACTUAL' is not defined" >&2
      return 44
    fi
  else
    if [ "$EXPECT_NOT" = true ] && [ -z "$EXPECT_ACTUAL" ]; then
      printf "Expected text not to have zero-length\nActual: %s\n" "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" >&2
      return 52
    elif [ "$EXPECT_NOT" != true ] && [ -n "$EXPECT_ACTUAL" ]; then
      printf "Expected text to have zero-length\nActual: %s\nExpected: \"\"\n" "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" >&2
      return 52
    fi
  fi
  return 0
}