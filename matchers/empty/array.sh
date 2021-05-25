ExpectMatcher.empty.ARRAY_NAME() {
  if [ "$EXPECT_BASH_NAME_REFERENCES" = true ] && ! declare -p __the__expected__array__ &>/dev/null; then
    local -n __the__expected__array__="$EXPECT_ACTUAL"
  else
    eval "local -a __the__expected__array__=(\"\${$EXPECT_ACTUAL[@]}\")"
  fi

  if [ "$EXPECT_NOT" != true ] && (( ${#__the__expected__array__[@]} > 0 )); then
    printf "Expected array to be empty (no array elements)\nActual: %s=%s\n" "$EXPECT_ACTUAL" "$( Expect.utils.inspectList "${__the__expected__array__[@]}" )" >&2
    return 51
  elif [ "$EXPECT_NOT" = true ] && (( ${#__the__expected__array__[@]} == 0 )); then
    printf "Expected array not to be empty (no array elements)\nActual: %s=()\n" "$EXPECT_ACTUAL" >&2
    return 51
  fi

  return 0
}