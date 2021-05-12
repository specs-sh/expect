expect.matcher.to.equal() {
  local __expected__="$1"
  if [ "$EXPECT_NOT" = true ] && [ "$EXPECT_ACTUAL" = "$__expected__" ]; then
    printf "Expected results not to equal:\nActual: %s\nExpected: %s\n" \
      "$(expect.inspect "$__expected__" )" \
      "$(expect.inspect "$EXPECT_ACTUAL" )" >&2
    return 1
  elif [ "$EXPECT_NOT" != true ] && [ "$EXPECT_ACTUAL" != "$__expected__" ]; then
    printf "Expected results to equal:\nActual: %s\nExpected: %s\n" \
      "$( expect.inspect "$__expected__" )" \
      "$( expect.inspect "$EXPECT_ACTUAL" )" >&2
    return 1
  fi
  return 0
}