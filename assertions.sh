# GENERATED
# DO NOT EDIT
# GENERATED

# In Development: use set -eEuo pipefail
set -eEuo pipefail

# Source Expect SDK
source expect-sdk.sh

# assertions Version 2.0.0

ASSERTIONS_VERSION=2.0.0

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

Assertions.assertExpectedForList() {
  case $# in
    0) echo "${FUNCNAME[1]} expected 1 or more arguments: [expected] (actual) (actual) ..." >&2; return 40 ;;
    *) return 0 ;;
  esac
}

# Equals
assertEqual()     { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" equal "$1"; }
assertEquals()    { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" equal "$1"; }
assertNotEqual()  { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" not equal "$1"; }
assertNotEquals() { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" not equal "$1"; }

assertEmpty()    { Assertions.assertActual "$@" || return $?; Expect.assert "$1" empty; }
assertNotEmpty() { Assertions.assertActual "$@" || return $?; Expect.assert "$1" not empty; }
# TODO EMPTY LIST
assertEmptyArray()    { Assertions.assertActual "$@" || return $?; Expect.assert "$1" array empty; }
assertNotEmptyArray() { Assertions.assertActual "$@" || return $?; Expect.assert "$1" array not empty; }

# Contains
assertContains()    { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" contain "$1"; }
assertNotContains() { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" not contain "$1"; }
assertListContains()    { Assertions.assertExpectedForList "$@" || return $?; local expected="$1"; shift; Expect.assert [ "$@" ] contains "$expected"; }
assertNotListContains() { Assertions.assertExpectedForList "$@" || return $?; local expected="$1"; shift; Expect.assert [ "$@" ] not contains "$expected"; }
assertArrayContains()    { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" array contain "$1"; }
assertNotArrayContains() { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" array not contain "$1"; }

# Includes
assertListIncludes()    { Assertions.assertExpectedForList "$@" || return $?; local expected="$1"; shift; Expect.assert [ "$@" ] includes "$expected"; }
assertNotListIncludes() { Assertions.assertExpectedForList "$@" || return $?; local expected="$1"; shift; Expect.assert [ "$@" ] not includes "$expected"; }
assertArrayIncludes()    { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" array includes "$1"; }
assertNotArrayIncludes() { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" array not includes "$1"; }

# Substring
assertSubstring()    { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" substring "$1"; }
assertNotSubstring() { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" not substring "$1"; }

# Length
assertLength()    { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" length "$1"; }
assertNotLength() { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" not length "$1"; }
assertListLength()    { Assertions.assertExpectedForList "$@" || return $?; local expected="$1"; shift; Expect.assert [ "$@" ] length "$expected"; }
assertNotListLength() { Assertions.assertExpectedForList "$@" || return $?; local expected="$1"; shift; Expect.assert [ "$@" ] not length "$expected"; }
assertArrayLength()    { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" array length "$1"; }
assertNotArrayLength() { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert "$2" array not length "$1"; }


# GENERATED
# DO NOT EDIT
# GENERATED
