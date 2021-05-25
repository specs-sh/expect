Expect.private.nextMatcher() {
  EXPECT_MATCHER="${EXPECT_MATCHER_PREFIX:-ExpectMatcher}"
  until (( ${#EXPECT_ARGUMENTS[@]} == 0 )) || declare -F "$EXPECT_MATCHER.$EXPECT_ACTUAL_TYPE" &>/dev/null || declare -F "$EXPECT_MATCHER.ANY" &>/dev/null; do
    case "${EXPECT_ARGUMENTS[0]}" in
      not) EXPECT_NOT=true; EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      should) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      be) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      a) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      to) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      is) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      does) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      has) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      have) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      and) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      with) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      *) EXPECT_MATCHER+=".${EXPECT_ARGUMENTS[0]}"; EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
    esac
    if declare -F "${EXPECT_MATCHER%s}.$EXPECT_ACTUAL_TYPE" &>/dev/null || declare -F "${EXPECT_MATCHER%s}.ANY" &>/dev/null; then
      EXPECT_MATCHER="${EXPECT_MATCHER%s}"
    elif declare -F "${EXPECT_MATCHER%ing}.$EXPECT_ACTUAL_TYPE" &>/dev/null || declare -F "${EXPECT_MATCHER%ing}.ANY" &>/dev/null; then
      EXPECT_MATCHER="${EXPECT_MATCHER%ing}"
    fi
  done
  if declare -F "$EXPECT_MATCHER.$EXPECT_ACTUAL_TYPE" &>/dev/null; then
    EXPECT_MATCHER="$EXPECT_MATCHER.$EXPECT_ACTUAL_TYPE" 
  elif declare -F "$EXPECT_MATCHER.ANY" &>/dev/null; then
    EXPECT_MATCHER="$EXPECT_MATCHER.ANY" 
  else
    return 44
  fi
}
