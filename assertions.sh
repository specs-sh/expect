# GENERATED
# DO NOT EDIT
# GENERATED

# In Development: use set -eEuo pipefail
set -eEuo pipefail

# Source Expect SDK
source expect-sdk.sh

# assertions Version 2.0.0

Assertions.assertExpectedAndActual() {
  case $# in
    0) echo "${FUNCNAME[1]} expected 2 arguments: [expected] [actual]" >&2; return 40 ;;
    1) echo "${FUNCNAME[1]} expected 2 arguments: [expected] [actual]" >&2; return 40 ;;
    2) return 0 ;;
    *) echo "${FUNCNAME[1]} expected 2 arguments: [expected] [actual]" >&2; return 40 ;;
  esac
}

Assertions.assertActual() {
  case $# in
    0) echo "${FUNCNAME[1]} expected 1 arguments: [actual]" >&2; return 40 ;;
    1) return 0 ;;
    2) echo "${FUNCNAME[1]} expected 1 arguments: [actual]" >&2; return 40 ;;
    *) echo "${FUNCNAME[1]} expected 1 arguments: [actual]" >&2; return 40 ;;
  esac
}

assertEqual()     { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" equal "$1"; }
assertEquals()    { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" equal "$1"; }
assertNotEqual()  { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" not equal "$1"; }
assertNotEquals() { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" not equal "$1"; }

assertEmpty()    { Assertions.assertActual "$@" || return $?; Expect.assert "$1" empty; }
assertNotEmpty() { Assertions.assertActual "$@" || return $?; Expect.assert "$1" not empty; }

assertEmptyArray()    { Assertions.assertActual "$@" || return $?; Expect.assert "$1" array empty; }
assertNotEmptyArray() { Assertions.assertActual "$@" || return $?; Expect.assert "$1" array not empty; }

assertContains()    { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" contain "$1"; }
assertNotContains() { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" not contain "$1"; }

assertSubstring()    { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" substring "$1"; }
assertNotSubstring() { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" not substring "$1"; }

assertLength()    { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" length "$1"; }
assertNotLength() { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" not length "$1"; }