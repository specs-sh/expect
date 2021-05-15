set -uo pipefail # Remove when ready for production
source core/core.sh # Switch to compilation when ready for production

Assertions.assertExpectedAndActual() {
  case $# in
    0) echo "${FUNCNAME[1]} expected 2 arguments: [expected], [actual]" >&2; return 1 ;;
    1) echo "${FUNCNAME[1]} expected 2 arguments: [expected], [actual]" >&2; return 1 ;;
    2) return 0 ;;
    *) echo "${FUNCNAME[1]} expected 2 arguments: [expected], [actual]" >&2; return 1 ;;
  esac
}

assertEqual() { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert assertions "$2" equal "$1"; }
assertEquals() { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert assertions "$2" equal "$1"; }
assertNotEqual() { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert assertions "$2" not equal "$1"; }
assertNotEquals() { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert assertions "$2" not equal "$1"; }