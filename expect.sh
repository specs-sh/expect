set -uo pipefail # Remove when ready for production

expect() {
  local EXPECT_ACTUAL= EXPECT_MATCHER= EXPECT_NOT=

  # Block handling...

  EXPECT_ACTUAL="$1"; shift
  [ "$1" = not ] && { EXPECT_NOT=true; shift; }

  # (( $# == 0 )) && echo TODO ERROR

  EXPECT_MATCHER="${EXPECT_FUNCTION_PREFIX:-expect.}$1"; shift

  while (( $# > 0 )) && ! declare -F "$EXPECT_MATCHER" &>/dev/null; do
    EXPECT_MATCHER+=".$1"; shift
  done

  if declare -F "$EXPECT_MATCHER" &>/dev/null; then
    echo "MATCHER $EXPECT_MATCHER" >&2
    "$EXPECT_MATCHER" "$@"
  else
      echo "ERROR NO MATCHER TODO" >&2
      return 3
  fi
}

expect.inspect() {
  echo -e "$1" | cat -vET
}