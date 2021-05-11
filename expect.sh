set -uo pipefail # Remove when ready for production

expect() {
  local EXPECT_ACTUAL= EXPECT_MATCHER= EXPECT_NOT= \
    EXPECT_BASH_ASSOCIATIVE_ARRAYS= EXPECT_BASH_NAME_REFERENCES=

  # Block handling...

  EXPECT_ACTUAL="$1"; shift
  [ "$1" = not ] && { EXPECT_NOT=true; shift; }

  # (( $# == 0 )) && echo TODO ERROR

  EXPECT_MATCHER="${EXPECT_FUNCTION_PREFIX:-expect.matcher.}$1"; shift

  (( ${BASH_VERSINFO[0]} >= 4 )) && EXPECT_BASH_ASSOCIATIVE_ARRAYS=true
  (( ${BASH_VERSINFO[0]} >= 5 )) || { (( ${BASH_VERSINFO[0]} == 4 )) && (( ${BASH_VERSINFO[1]} >= 3 )); } && EXPECT_BASH_NAME_REFERENCES=true

  while (( $# > 0 )) && ! declare -F "$EXPECT_MATCHER" &>/dev/null; do
    if [ "$1" = not ]; then
      EXPECT_NOT=true; shift
    else
      EXPECT_MATCHER+=".$1"; shift
    fi
  done

  # TODO support .and fluent

  if declare -F "$EXPECT_MATCHER" &>/dev/null; then
    "$EXPECT_MATCHER" "$@"
  else
      echo "ERROR NO MATCHER TODO" >&2
      return 3
  fi
}

expect.inspect() {
  printf "'%s'" "$( echo -ne "$1" | cat -vET )"
}

expect.inspectList() {
  while (( $# > 0 )); do
    expect.inspect "$1"
    shift
    (( $# > 0 )) && printf ' '
  done
}