set -uo pipefail # Remove when ready for production
source core/utils.sh # Switch to compilation when ready for production

Expect.core.assert() {
  local EXPECT_TYPE="${1:-expect}" EXPECT_ACTUAL= EXPECT_MATCHER= EXPECT_NOT= EXPECT_BASH_ASSOCIATIVE_ARRAYS= EXPECT_BASH_NAME_REFERENCES=
  local -a EXPECT_ARGUMENTS=()

  shift

  # Block handling...

  EXPECT_ACTUAL="$1"; shift
  [ "$1" = not ] && { EXPECT_NOT=true; shift; }

  # (( $# == 0 )) && echo TODO ERROR

  (( ${BASH_VERSINFO[0]} >= 4 )) && EXPECT_BASH_ASSOCIATIVE_ARRAYS=true
  (( ${BASH_VERSINFO[0]} >= 5 )) || { (( ${BASH_VERSINFO[0]} == 4 )) && (( ${BASH_VERSINFO[1]} >= 3 )); } && EXPECT_BASH_NAME_REFERENCES=true

  EXPECT_ARGUMENTS=("$@")
  EXPECT_MATCHER="${EXPECT_FUNCTION_PREFIX:-ExpectMatcher}"
  while (( $# > 0 )) && ! declare -F "$EXPECT_MATCHER" &>/dev/null; do
    case "$1" in
      not) EXPECT_NOT=true; shift ;;
      should) shift ;;
      be) shift ;;
      to) shift ;;
      *) EXPECT_MATCHER+=".$1"; shift ;;
    esac
  done

  # TODO support .and fluent

  if declare -F "$EXPECT_MATCHER" &>/dev/null; then
    "$EXPECT_MATCHER" "$@"
  else
      echo "No matcher found for arguments: ${EXPECT_ARGUMENTS[*]}" >&2
      return 44
  fi
}