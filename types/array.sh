ExpectMatcher.array.ANY() {
  EXPECT_ACTUAL_TYPE=ARRAY_NAME

  local variableDeclaration=
  if variableDeclaration="$( declare -p "$EXPECT_ACTUAL" 2>/dev/null )"; then
    if [[ "$variableDeclaration" != "declare -a "* ]]; then
      printf "Expected array, but variable %s is not an array.\nVariable %s declaration: %s" \
        "$EXPECT_ACTUAL" "$EXPECT_ACTUAL" "$variableDeclaration" >&2
      return 2
    fi
  else
    printf "Expected array, but no variable declared: %s" "$EXPECT_ACTUAL" >&2
    return 1
  fi
}
