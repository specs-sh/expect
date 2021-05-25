ExpectMatcher.join.LIST() {
  (( $# == 0 )) && { echo "Missing required argument for 'join': [separator]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  local __expect__join__newValue=
  local -i __expect__join__itemIndex=0
  
  for (( __expect__join__itemIndex=0; __expect__join__itemIndex < ${#EXPECT_ACTUAL[@]}; __expect__join__itemIndex++ )); do
    if (( __expect__join__itemIndex == ${#EXPECT_ACTUAL[@]} - 1 )); then
      __expect__join__newValue+="${EXPECT_ACTUAL[__expect__join__itemIndex]}"
    else
      __expect__join__newValue+="${EXPECT_ACTUAL[__expect__join__itemIndex]}$1"
    fi
  done

  EXPECT_ACTUAL=("$__expect__join__newValue")
  EXPECT_ACTUAL_TYPE=TEXT

  return 0
}

ExpectMatcher.join.ARRAY_NAME() {
  (( $# == 0 )) && { echo "Missing required argument for 'join': [separator]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  if [ "$EXPECT_BASH_NAME_REFERENCES" = true ]; then
    local -n __expected__array="${EXPECT_ACTUAL[0]}"
  else
    eval "local -a __expected__array=(\"\${$EXPECT_ACTUAL[@]}\")"
  fi

  local __expect__join__newValue=
  local -i __expect__join__itemIndex=0
  
  for (( __expect__join__itemIndex=0; __expect__join__itemIndex < ${#__expected__array[@]}; __expect__join__itemIndex++ )); do
    if (( __expect__join__itemIndex == ${#__expected__array[@]} - 1 )); then
      __expect__join__newValue+="${__expected__array[__expect__join__itemIndex]}"
    else
      __expect__join__newValue+="${__expected__array[__expect__join__itemIndex]}$1"
    fi
  done

  EXPECT_ACTUAL=("$__expect__join__newValue")
  EXPECT_ACTUAL_TYPE=TEXT

  return 0
}