ExpectMatcher.split.TEXT() {
  (( $# == 0 )) && { echo "Missing required argument for 'split': [separator]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  local __expect__split__separator="$1"
  local __expect__split__separatorLength="${#__expect__split__separator}"

  if (( ${#EXPECT_ACTUAL[@]} > 0 )); then

    local __expect__text="${EXPECT_ACTUAL[0]}"
    EXPECT_ACTUAL=()

    # Add elements between instances of the separator
    local -i __expect__i=0
    local -i __expect__lastMatch=0
    while (( __expect__i < ${#__expect__text} - __expect__split__separatorLength + 1 )); do
      if [ "${__expect__text:__expect__i:__expect__split__separatorLength}" = "$__expect__split__separator" ]; then
        EXPECT_ACTUAL+=("${__expect__text:__expect__lastMatch:__expect__i-__expect__lastMatch}")
        (( __expect__lastMatch = __expect__i + __expect__split__separatorLength ))
        (( __expect__i = __expect__lastMatch + 1 ))
      else
        (( __expect__i = __expect__i + 1 ))
      fi
    done

    # Add the last bit
    if (( $__expect__lastMatch != ${#__expect__text} - 1 )); then
      EXPECT_ACTUAL+=("${__expect__text:__expect__lastMatch:${#__expect__text}-__expect__lastMatch}")
    fi
  else
    EXPECT_ACTUAL=("")
  fi

  EXPECT_ACTUAL_TYPE=LIST

  return 0
}