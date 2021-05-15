set -uo pipefail # Remove when ready for production
source core/core.sh # Switch to compilation when ready for production

[:() {
  local __brackets__leftHandSide="$1" __brackets__operator="$2" __brackets__rightHandSide="$3" __brackets__matcher=
  case "$__brackets__operator" in
    =) __brackets__matcher=equal ;;
    !=) __brackets__matcher="not equal" ;;
  esac
  [ -z "$__brackets__matcher" ] && { echo "TODO ERROR" >&2; return 44; }
  Expect.assert brackets "$__brackets__rightHandSide" $__brackets__matcher "$__brackets__leftHandSide"
}