# GENERATED
# DO NOT EDIT
# GENERATED

# In Development: use set -eEuo pipefail
set -eEuo pipefail

# Source Expect SDK
source expect-sdk.sh

# brackets Version 2.0.0

Brackets.single() {
  local -r BRACKETS_VERSION=2.0.0
  local -ra BRACKETS_ORIGINAL_ARGUMENTS=("$@")

  (( $# == 0 )) && { echo "Brackets [: missing required arguments: [!] [-bcdefghknprstuwxzGLNOS] [actual] [operator] [expected] ']'" >&2; return 46; }
  (( $# == 1 )) && [ "$1" = --version ] && { echo "Brackets version $BRACKETS_VERSION"; return 0; }
  if [ "${BRACKETS_ORIGINAL_ARGUMENTS[${#BRACKETS_ORIGINAL_ARGUMENTS[@]}-1]}" != ']' ]; then
    printf "Brackets [: missing closing ']' bracket. Provided arguments: [: %s" "$( Expect.utils.inspectList "${BRACKETS_ORIGINAL_ARGUMENTS[@]}" )" >&2
    return 46
  fi

  local -ra BRACKETS_BLOCK_ARGUMENTS=("${BRACKETS_ORIGINAL_ARGUMENTS[@]:0:${#BRACKETS_ORIGINAL_ARGUMENTS[@]}-1}")
  if (( ${#BRACKETS_BLOCK_ARGUMENTS[@]} == 0 )); then
    echo "Brackets [: ] missing required arguments: [!] [-bcdefghknprstuwxzGLNOS] [actual] [operator] [expected]" >&2
    return 46
  fi

  local -a __brackets__argumentList=("${BRACKETS_BLOCK_ARGUMENTS[@]}")

  local BRACKETS_NOT=
  [ "${__brackets__argumentList[0]}" = '!' ] && { BRACKETS_NOT=not; __brackets__argumentList=("${__brackets__argumentList[@]:1}"); }
  if (( ${#__brackets__argumentList[@]} == 0 )); then
    printf "Brackets [: %s ] missing required arguments: [-bcdefghknprstuwxzGLNOS] [actual] [operator] [expected]" "$( Expect.utils.inspectList "${BRACKETS_BLOCK_ARGUMENTS[@]}" )" >&2
    return 46
  fi
  if (( ${#__brackets__argumentList[@]} != 2 )) && (( ${#__brackets__argumentList[@]} != 3 )); then
    printf "Brackets [: %s ] missing required arguments: [-bcdefghknprstuwxzGLNOS] [operator] [expected]" "$( Expect.utils.inspectList "${BRACKETS_BLOCK_ARGUMENTS[@]}" )" >&2
    return 46
  fi

  local __brackets__leftHandSide= __brackets__operator= __brackets__rightHandSide= __brackets__matcher=

  if (( ${#__brackets__argumentList[@]} == 2 )); then
    case "${__brackets__argumentList[0]}" in
      *) printf "Brackets unknown operator: %s. Provided arguments: [: %s ]" "$( Expect.utils.inspect "${__brackets__argumentList[0]}" )" "$( Expect.utils.inspectList "${__brackets__argumentList[@]}" )"  >&2; return 46 ;;
    esac
  elif (( ${#__brackets__argumentList[@]} == 3 )); then
    case "${__brackets__argumentList[1]}" in
      =) Expect.assert "${__brackets__argumentList[0]}" $BRACKETS_NOT equal "${__brackets__argumentList[2]}" ;;
      !=) [ "$BRACKETS_NOT" = not ] && BRACKETS_NOT= || BRACKETS_NOT=not; Expect.assert "${__brackets__argumentList[0]}" $BRACKETS_NOT equal "${__brackets__argumentList[2]}" ;;
      *) printf "Brackets unknown operator: %s. Provided arguments: [: %s ]" "$( Expect.utils.inspect "${__brackets__argumentList[1]}" )" "$( Expect.utils.inspectList "${__brackets__argumentList[@]}" )"  >&2; return 46 ;;
    esac
  fi

  # TODO bring these back with fresh new tests :)
  # -e) Expect.assert "$2" path $BRACKETS_NOT exists ;;
  # -f) Expect.assert "$2" file $BRACKETS_NOT exists ;;
  # -d) Expect.assert "$2" directory $BRACKETS_NOT exists ;;
  # -z) Expect.assert "$2" $BRACKETS_NOT empty ;;
  # -n) [ "$BRACKETS_NOT" = true ] && Expect.assert "$2" not empty || Expect.assert "$2" empty ;;
}

Brackets.double() {
  local -r BRACKETS_VERSION=2.0.0

  # TODO

  (( $# == 1 )) && [ "$1" = --version ] && { echo "Brackets version $BRACKETS_VERSION"; return 0; }
  local __brackets__leftHandSide="$1" __brackets__operator="$2" __brackets__rightHandSide="$3" __brackets__matcher=
  case "$__brackets__operator" in
    =) __brackets__matcher=containPattern ;;
    !=) __brackets__matcher="not containPattern" ;;
  esac
  [ -z "$__brackets__matcher" ] && { echo "TODO ERROR" >&2; return 44; }
  Expect.assert "$__brackets__leftHandSide" $__brackets__matcher "$__brackets__rightHandSide"
}

[:() { Brackets.single "$@"; }
[[:() { Brackets.double "$@"; }


# GENERATED
# DO NOT EDIT
# GENERATED
