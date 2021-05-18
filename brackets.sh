# GENERATED
# DO NOT EDIT
# GENERATED

# In Development: use set -eEuo pipefail
set -eEuo pipefail

# Source Expect SDK
source expect-sdk.sh

# brackets Version 2.0.0

[:() {
  local __brackets__leftHandSide="$1" __brackets__operator="$2" __brackets__rightHandSide="$3" __brackets__matcher=
  case "$__brackets__operator" in
    =) __brackets__matcher=equal ;;
    !=) __brackets__matcher="not equal" ;;
  esac
  [ -z "$__brackets__matcher" ] && { echo "TODO ERROR" >&2; return 44; }
  Expect.assert "$__brackets__leftHandSide" $__brackets__matcher "$__brackets__rightHandSide"
}