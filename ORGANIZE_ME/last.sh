ExpectMatcher.last.LIST() {
  if (( ${#EXPECT_ACTUAL[@]} > 0 )); then
    EXPECT_ACTUAL=("${EXPECT_ACTUAL[${#EXPECT_ACTUAL[@]}-1]}")
  else
    EXPECT_ACTUAL=()
  fi
  EXPECT_ACTUAL_TYPE=TEXT
  return 0
}

ExpectMatcher.last.ARRAY_NAME() {
  if (( ${#EXPECT_ACTUAL[@]} > 0 )); then
    if [ "$EXPECT_BASH_NAME_REFERENCES" = true ]; then
      local -n __expected__array__="${EXPECT_ACTUAL[0]}"
    else
      eval "local -a __expected__array__=(\"\${$EXPECT_ACTUAL[@]}\")"
    fi
    if (( ${#__expected__array__[@]} > 0 )); then
      EXPECT_ACTUAL=("${__expected__array__[${#__expected__array__[@]}-1]}")
    else
      EXPECT_ACTUAL=()
    fi
  else
    EXPECT_ACTUAL=()
  fi
  EXPECT_ACTUAL_TYPE=TEXT
  return 0
}
