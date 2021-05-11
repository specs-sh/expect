expect.to.equal() {
  local expected="$1"
  if [ "$EXPECT_NOT" = true ]; then
    if [ "$EXPECT_ACTUAL" = "$expected" ]; then
      printf "Expected results not to equal:\nActual: '%s'\nExpected: '%s'\n" \
        "$( echo -e "$expected" | cat -vET )" \
        "$( echo -e "$EXPECT_ACTUAL" | cat -vET )" >&2
      return 1
    fi
  else
    if [ "$EXPECT_ACTUAL" != "$expected" ]; then
      printf "Expected results to equal:\nActual: '%s'\nExpected: '%s'\n" \
        "$( echo -e "$expected" | cat -vET )" \
        "$( echo -e "$EXPECT_ACTUAL" | cat -vET )" >&2
      return 1
    fi
  fi
  return 0
}