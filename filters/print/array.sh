ExpectMatcher.print.ARRAY_NAME() {
  [[ "$( declare -p "$EXPECT_ACTUAL" 2>/dev/null )" != "declare -a "* ]] && return 0 # Not variable (or not an array)
  if [ "$EXPECT_BASH_NAME_REFERENCES" = true ] && ! declare -p __the__expected__array__ &>/dev/null; then
    local -n __the__expected__array__="$EXPECT_ACTUAL"
  else
    eval "local -a __the__expected__array__=(\"\${$EXPECT_ACTUAL[@]}\")"
  fi
  printf '%s=' "$EXPECT_ACTUAL"
  Expect.utils.inspectList "${__the__expected__array__[@]}"
}