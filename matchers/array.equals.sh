expect.matcher.array.to.equal() {
  if [ "$EXPECT_BASH_NAME_REFERENCES" = true ]; then
    local -n __array__="$EXPECT_ACTUAL"
    local __array__equals=true
    if (( ${#__array__[@]} == $# )); then
      local -i __i__
      local -a __expected__=("$@")
      for (( i=0; i < ${#__array__}; i++ )); do
        if [ "${__array__[i]}" != "${__expected__[i]}" ]; then
          __array__equals=false; break;
        fi
      done
    else
      __array__equals=false
    fi
    if [ "$EXPECT_NOT" = true ] && [ "$__array__equals" = true ]; then
      printf "Expected array not to equal provided values:\nActual: %s\nExpected: %s\n" \
        "$( expect.inspectList "${__array__[@]}" )" \
        "$( expect.inspectList "${__expected__[@]}" )" >&2
      return 1
    elif [ "$EXPECT_NOT" != true ] && [ "$__array__equals" = false ]; then
      printf "Expected array to equal provided values:\nActual: %s\nExpected: %s\n" \
        "$( expect.inspectList "${__array__[@]}" )" \
        "$( expect.inspectList "${__expected__[@]}" )" >&2
      return 1
    fi
  else
    echo "TODO TODO" >&2
  fi
  return 0
}