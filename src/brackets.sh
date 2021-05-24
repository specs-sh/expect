[:() {
  local -r BRACKETS_VERSION=2.0.0
  (( $# == 1 )) && [ "$1" = --version ] && { echo "Brackets version $BRACKETS_VERSION"; return 0; }
  local __brackets__leftHandSide="$1" __brackets__operator="$2" __brackets__rightHandSide="$3" __brackets__matcher=
  case "$__brackets__operator" in
    =) __brackets__matcher=equal ;;
    !=) __brackets__matcher="not equal" ;;
  esac
  [ -z "$__brackets__matcher" ] && { echo "TODO ERROR" >&2; return 44; }
  Expect.assert "$__brackets__leftHandSide" $__brackets__matcher "$__brackets__rightHandSide"
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