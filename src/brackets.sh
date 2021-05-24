[:() {
  local -r BRACKETS_VERSION=2.0.0
  (( $# == 1 )) && [ "$1" = --version ] && { echo "Brackets version $BRACKETS_VERSION"; return 0; }

  local BRACKETS_NOT=
  [ "${1:-}" = '!' ] && { BRACKETS_NOT=not; shift; }

  case "${1:-}" in
    -e) Expect.assert "$2" path $BRACKETS_NOT exists ;;
    -f) Expect.assert "$2" file $BRACKETS_NOT exists ;;
    -d) Expect.assert "$2" directory $BRACKETS_NOT exists ;;
    *)
      case "${2:-}" in
        =) Expect.assert "$1" equal "${3:-}" ;;
        !=) Expect.assert "$1" not equal "${3:-}" ;;
        *) echo "Unsupported brackets arguments: [ $* ]" >&2; return 30 ;;
      esac
      ;;
  esac
}

[[:() {
  local -r BRACKETS_VERSION=2.0.0
  (( $# == 1 )) && [ "$1" = --version ] && { echo "Brackets version $BRACKETS_VERSION"; return 0; }
  local __brackets__leftHandSide="$1" __brackets__operator="$2" __brackets__rightHandSide="$3" __brackets__matcher=
  case "$__brackets__operator" in
    =) __brackets__matcher=containPattern ;;
    !=) __brackets__matcher="not containPattern" ;;
  esac
  [ -z "$__brackets__matcher" ] && { echo "TODO ERROR" >&2; return 44; }
  Expect.assert "$__brackets__leftHandSide" $__brackets__matcher "$__brackets__rightHandSide"
}