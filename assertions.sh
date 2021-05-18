# Copyright (c) 2021 Rebecca Taylor - MIT License
#
# GENERATED FILE [DO NOT EDIT]
#

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

assertEqual()     { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert assertions "$2" equal "$1"; }
assertEquals()    { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert assertions "$2" equal "$1"; }
assertNotEqual()  { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert assertions "$2" not equal "$1"; }
assertNotEquals() { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert assertions "$2" not equal "$1"; }

assertEmpty()    { Assertions.assertActual "$@" || return $?; Expect.assert assertions "$1" empty; }
assertNotEmpty() { Assertions.assertActual "$@" || return $?; Expect.assert assertions "$1" not empty; }

assertEmptyArray()    { Assertions.assertActual "$@" || return $?; Expect.assert assertions "$1" array empty; }
assertNotEmptyArray() { Assertions.assertActual "$@" || return $?; Expect.assert assertions "$1" array not empty; }

assertContains()    { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert assertions "$2" contain "$1"; }
assertNotContains() { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert assertions "$2" not contain "$1"; }

assertSubstring()    { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert assertions "$2" substring "$1"; }
assertNotSubstring() { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert assertions "$2" not substring "$1"; }

assertLength()    { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert assertions "$2" length "$1"; }
assertNotLength() { Assertions.assertExpectedAndActual "$@" || return $?; Expect.assert assertions "$2" not length "$1"; }
# Included matchers/array matcher
ExpectMatcher.array() {
  EXPECT_ACTUAL_IS_ARRAY_NAME=true
  EXPECT_ACTUAL_ARRAY_NAME="$EXPECT_ACTUAL"
}
ExpectMatcher.list() { ExpectMatcher.array "$@"; }

# Included matchers/commands matcher
ExpectMatcher.exitcode() { EXPECT_ACTUAL="$EXPECT_COMMAND_EXITCODE"; }
ExpectMatcher.stdout() { EXPECT_ACTUAL="$EXPECT_COMMAND_STDOUT"; }
ExpectMatcher.stderr() { EXPECT_ACTUAL="$EXPECT_COMMAND_STDERR"; }
ExpectMatcher.output() { EXPECT_ACTUAL="$EXPECT_COMMAND_STDOUT$EXPECT_COMMAND_STDERR"; }
ExpectMatcher.fail() {
  if [ "$EXPECT_NOT" = true ] && [ "$EXPECT_COMMAND_EXITCODE" != "0" ]; then
    printf "Expected command not to fail:\nCommand: %s\nExit code: %s\n" "${EXPECT_COMMAND[*]}" "$EXPECT_COMMAND_EXITCODE" >&2
    return 61
  elif [ "$EXPECT_NOT" != true ] && [ "$EXPECT_COMMAND_EXITCODE" = "0" ]; then
    printf "Expected command to fail, but passed:\nCommand: %s\n" "${EXPECT_COMMAND[*]}" >&2
    return 61
  fi
  return 0
}
ExpectMatcher.pass() {
  if [ "$EXPECT_NOT" = true ] && [ "$EXPECT_COMMAND_EXITCODE" = "0" ]; then
    printf "Expected command not to pass:\nCommand: %s\n" "${EXPECT_COMMAND[*]}" >&2
    return 61
  elif [ "$EXPECT_NOT" != true ] && [ "$EXPECT_COMMAND_EXITCODE" != "0" ]; then
    printf "Expected command to pass:\nCommand: %s\nExit code: %s\n" "${EXPECT_COMMAND[*]}" "$EXPECT_COMMAND_EXITCODE" >&2
    return 61
  fi
  return 0
}
ExpectMatcher.ok() { ExpectMatcher.pass "$@"; }
ExpectMatcher.succeed() { ExpectMatcher.pass "$@"; }

# Included matchers/contain matcher
ExpectMatcher.contain() {
  (( $# == 0 )) && { echo "Missing required argument for 'contain' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")
  if [ "$EXPECT_NOT" = true ] && [[ "$EXPECT_ACTUAL" = *$1* ]]; then
    printf "Expected text value not to contain subtext:\nActual: %s\nUnexpected: %s\n" \
      "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" \
      "$( ExpectMatchers.utils.inspect "$1" )" >&2
    return 51
  elif [ "$EXPECT_NOT" != true ] && [[ "$EXPECT_ACTUAL" != *$1* ]]; then
    printf "Expected text value to contain subtext:\nActual: %s\nExpected: %s\n" \
      "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" \
      "$( ExpectMatchers.utils.inspect "$1" )" >&2
    return 51
  fi
  return 0
}

# Included matchers/empty matcher
ExpectMatcher.empty() {
  if [ "$EXPECT_ACTUAL_IS_ARRAY_NAME" = true ]; then
    if declare -p "$EXPECT_ACTUAL" 2>&1 | grep "^declare -a " &>/dev/null; then
      if [ "$EXPECT_BASH_NAME_REFERENCES" = true ]; then
        local -n __array__="$EXPECT_ACTUAL"
        if [ "$EXPECT_NOT" = true ] && (( ${#__array__[@]} == 0 )); then
          printf "Expected array not to have zero elements\nActual: ( )%s\n"
          return 52
        elif [ "$EXPECT_NOT" != true ] && (( ${#__array__[@]} > 0 )); then
          printf "Expected array to have zero elements\nActual: (%s)\nExpected: ( )\n" "$( ExpectMatchers.utils.inspectList "${__array__[@]}" )" >&2
          return 52
        fi
      else
        local -i __arrayLength__=
        eval "__arrayLength__=\"\${#$EXPECT_ACTUAL}\""
        if [ "$EXPECT_NOT" = true ] && (( __arrayLength__ == 0 )); then
          printf "Expected array not to have zero elements\nActual: ( )%s\n"
          return 52
        elif [ "$EXPECT_NOT" != true ] && (( __arrayLength__ > 0 )); then
          eval "printf \"Expected array to have zero elements\nActual: (%s)\nExpected: ( )\n\" \"\$( ExpectMatchers.utils.inspectList \"\${$EXPECT_ACTUAL[@]}\" )\"" >&2
          return 52
        fi
      fi
    else
      echo "Expected array '$EXPECT_ACTUAL' is not defined" >&2
      return 44
    fi
  else
    if [ "$EXPECT_NOT" = true ] && [ -z "$EXPECT_ACTUAL" ]; then
      printf "Expected text not to have zero-length\nActual: %s\n" "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" >&2
      return 52
    elif [ "$EXPECT_NOT" != true ] && [ -n "$EXPECT_ACTUAL" ]; then
      printf "Expected text to have zero-length\nActual: %s\nExpected: \"\"\n" "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" >&2
      return 52
    fi
  fi
  return 0
}

# Included matchers/equal matcher
ExpectMatcher.equal() {
  (( $# == 0 )) && { echo "Missing required argument for 'equal' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")
  if [ "${EXPECT_NOT:-}" = true ] && [ "${EXPECT_ACTUAL:-}" = "$1" ]; then
    printf "Expected values not to equal:\nValue: %s\n" \
      "$( ExpectMatchers.utils.inspect "${EXPECT_ACTUAL:-}" )" >&2
    return 50
  elif [ "${EXPECT_NOT:-}" != true ] && [ "${EXPECT_ACTUAL:-}" != "$1" ]; then
    printf "Expected values to equal:\nActual: %s\nExpected: %s\n" \
      "$( ExpectMatchers.utils.inspect "${EXPECT_ACTUAL:-}" )" \
      "$( ExpectMatchers.utils.inspect "$1" )" >&2
    return 50
  fi
  return 0
}
ExpectMatcher.eq() { ExpectMatcher.equal "$@"; }
ExpectMatcher.=() { ExpectMatcher.equal "$@"; }
ExpectMatcher.==() { ExpectMatcher.equal "$@"; }

# Included matchers/length matcher
ExpectMatcher.length() {
  (( $# == 0 )) && { echo "Missing required argument for 'length' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")
  if [ "$EXPECT_NOT" = true ] && [ "${#EXPECT_ACTUAL}" = "$1" ]; then
    printf "Expected text value not to have specified length\nText: %s\nLength: %s\n" \
      "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" "${#EXPECT_ACTUAL}" >&2
    return 56
  elif [ "$EXPECT_NOT" != true ] && [ "${#EXPECT_ACTUAL}" != "$1" ]; then
    printf "Expected text value to have specified length\nText: %s\nActual Length: %s\nExpected Length: %s\n" \
      "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" "${#EXPECT_ACTUAL}" "$1" >&2
    return 56
  fi
  return 0
}

# Included matchers/substring matcher
ExpectMatcher.substring() {
  (( $# == 0 )) && { echo "Missing required argument for 'substring' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")
  if [ "$EXPECT_NOT" = true ] && [[ "$EXPECT_ACTUAL" = *"$1"* ]]; then
    printf "Expected text value not to contain substring:\nActual: %s\nUnexpected: %s\n" \
      "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" \
      "$( ExpectMatchers.utils.inspect "$1" )" >&2
    return 55
  elif [ "$EXPECT_NOT" != true ] && [[ "$EXPECT_ACTUAL" != *"$1"* ]]; then
    printf "Expected text value to contain substring:\nActual: %s\nExpected: %s\n" \
      "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" \
      "$( ExpectMatchers.utils.inspect "$1" )" >&2
    return 55
  fi
  return 0
}

# Included Expect SDK 2.0.0
Expect.assert() {
  local -r EXPECT_VERSION="2.0.0"
  local -a EXPECT_ORIGINAL_ARGUMENTS=("$@") EXPECT_ARGUMENTS=() EXPECT_COMMAND=() EXPECT_ACTUAL_ARRAY=()
  local EXPECT_TYPE="${1:-expect}" EXPECT_ACTUAL= EXPECT_MATCHER= EXPECT_NOT= EXPECT_ACTUAL_IS_ARRAY_NAME= EXPECT_ACTUAL_ARRAY_NAME= \
        EXPECT_BLOCK_OPEN= EXPECT_BLOCK_CLOSE= \
        EXPECT_COMMAND_STDOUT= EXPECT_COMMAND_STDERR= \
        EXPECT_BASH_ASSOCIATIVE_ARRAYS= EXPECT_BASH_NAME_REFERENCES= \
        __expect__argument= __expect__isCommand= __expect__runCommandInSubShell= __expect__stdoutTempFile= __expect__stderrTempFile= __expect__nounsetOn= __expect__returnValue=
  local -i EXPECT_COMMAND_EXITCODE=0
  shift

  case "$1" in
    {)  EXPECT_BLOCK_OPEN={; EXPECT_BLOCK_CLOSE=} ;;
    {{) EXPECT_BLOCK_OPEN={{; EXPECT_BLOCK_CLOSE=}}; __expect__runCommandInSubShell=true ;;
    {{{)  EXPECT_BLOCK_OPEN={{{; EXPECT_BLOCK_CLOSE=}}} ;;
    {{{{) EXPECT_BLOCK_OPEN={{{{; EXPECT_BLOCK_CLOSE=}}}}; __expect__runCommandInSubShell=true ;;
    [)  EXPECT_BLOCK_OPEN=[; EXPECT_BLOCK_CLOSE=]; EXPECT_ACTUAL=EXPECT_ACTUAL_ARRAY; EXPECT_ACTUAL_IS_ARRAY_NAME=true; EXPECT_ACTUAL_ARRAY_NAME=EXPECT_ACTUAL_ARRAY;;
    [[) EXPECT_BLOCK_OPEN=[[; EXPECT_BLOCK_CLOSE=]]; EXPECT_ACTUAL=EXPECT_ACTUAL_ARRAY; EXPECT_ACTUAL_IS_ARRAY_NAME=true; EXPECT_ACTUAL_ARRAY_NAME=EXPECT_ACTUAL_ARRAY ;;
  esac

  if [ -n "$EXPECT_BLOCK_OPEN" ]; then
    for __expect__argument in "${EXPECT_ORIGINAL_ARGUMENTS[@]:2}"; do
      [ "$__expect__argument" = "$EXPECT_BLOCK_CLOSE" ] && { __expect__isCommand=true; break; } # UPDATE LOGIC (might not be a command, might just be a list)
      EXPECT_COMMAND+=("$__expect__argument")
    done
    __expect__argument=
    if [ "$EXPECT_ACTUAL_IS_ARRAY_NAME" = true ]; then
      shift "$(( 2 + ${#EXPECT_COMMAND[@]} ))"  # shift off {{ ... }}
      EXPECT_ACTUAL_ARRAY=("${EXPECT_COMMAND[@]}")
      EXPECT_COMMAND=()
    elif [ "$__expect__isCommand" = true ]; then
      (( ${#EXPECT_COMMAND[@]} == 0 )) && { echo "Error TODO no command" >&2; return 31; }
      shift "$(( 2 + ${#EXPECT_COMMAND[@]} ))"  # shift off {{ ... }}
    else
      EXPECT_BLOCK_OPEN= EXPECT_BLOCK_CLOSE= EXPECT_COMMAND=()
    fi
  fi

  if [ "$__expect__isCommand" = true ] && [ "$EXPECT_ACTUAL_IS_ARRAY_NAME" != true ]; then # FIXME
    __expect__stderrTempFile="$( mktemp )" || { echo "run: failed to create temporary file to store standard error using 'mktemp'" >&2; return 2; }
    if [ "$__expect__runCommandInSubShell" = true ]; then
      EXPECT_COMMAND_STDOUT="$( "${EXPECT_COMMAND[@]}" 2>"$__expect__stderrTempFile" )" && EXPECT_COMMAND_EXITCODE=$? || EXPECT_COMMAND_EXITCODE=$?
    else
      __expect__stdoutTempFile="$( mktemp )" || { echo "run: failed to create temporary file to store standard output using 'mktemp'" >&2; return 2; }
      "${EXPECT_COMMAND[@]}" 1>"$__expect__stdoutTempFile" 2>"$__expect__stderrTempFile" && EXPECT_COMMAND_EXITCODE=$? || EXPECT_COMMAND_EXITCODE=$?
      EXPECT_COMMAND_STDOUT="$( < "$__expect__stdoutTempFile" )" || echo "run: failed to read standard output from temporary file '$__expect__stdoutTempFile' created using 'mktemp'" >&2
      [ -f "$__expect__stdoutTempFile" ] && { rm "$__expect__stdoutTempFile" || echo "run: failed to delete temporary file used for standard output '$__expect__stdoutTempFile' created using 'mktemp'" >&2; }
    fi
    EXPECT_COMMAND_STDERR="$( < "$__expect__stderrTempFile" )" || echo "run: failed to read standard error from temporary file '$__expect__stderrTempFile' created using 'mktemp'" >&2
    [ -f "$__expect__stderrTempFile" ] && { rm "$__expect__stderrTempFile" || echo "run: failed to delete temporary file used for standard error '$__expect__stderrTempFile' created using 'mktemp'" >&2; }
    __expect__stdoutTempFile= __expect__stderrTempFile=
    EXPECT_ACTUAL="${EXPECT_COMMAND_STDOUT}${EXPECT_COMMAND_STDERR}"
  elif [ -z "$EXPECT_ACTUAL" ]; then
    EXPECT_ACTUAL="$1"; shift
  fi

  [ "$1" = not ] && { EXPECT_NOT=true; shift; }

  (( ${BASH_VERSINFO[0]} >= 4 )) && EXPECT_BASH_ASSOCIATIVE_ARRAYS=true
  (( ${BASH_VERSINFO[0]} >= 5 )) || { (( ${BASH_VERSINFO[0]} == 4 )) && (( ${BASH_VERSINFO[1]} >= 3 )); } && EXPECT_BASH_NAME_REFERENCES=true

  # (( $# == 0 )) && echo TODO ERROR
  EXPECT_ARGUMENTS=("$@")
  EXPECT_SEARCH_ARGUMENTS=("${EXPECT_ARGUMENTS[@]}")
  EXPECT_MATCHER=
  shopt -qo nounset && { __expect__nounsetOn=true; set +u; }
  until (( ${#EXPECT_ARGUMENTS[@]} == 0 )); do
    if Expect.core.nextMatcher; then
      "$EXPECT_MATCHER" "${EXPECT_ARGUMENTS[@]}" || { __expect__returnValue=$?; [ "$__expect__nounsetOn" = true ] && set -u; return $__expect__returnValue; }
      EXPECT_MATCHER= EXPECT_NOT=
    else
      echo "No matcher found for arguments: ${EXPECT_SEARCH_ARGUMENTS[*]}" >&2
      [ "$__expect__nounsetOn" = true ] && set -u
      return 44
    fi
    EXPECT_SEARCH_ARGUMENTS=("${EXPECT_ARGUMENTS[@]}")
  done
}

Expect.core.nextMatcher() {
  EXPECT_MATCHER="${EXPECT_MATCHER_PREFIX:-ExpectMatcher}"
  until (( ${#EXPECT_ARGUMENTS[@]} == 0 )) || declare -F "$EXPECT_MATCHER" &>/dev/null; do
    case "${EXPECT_ARGUMENTS[0]}" in
      not) EXPECT_NOT=true; EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      should) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      be) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      a) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      to) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      is) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      does) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      has) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      have) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      and) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      with) EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
      *) EXPECT_MATCHER+=".${EXPECT_ARGUMENTS[0]}"; EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}") ;;
    esac
    declare -F "${EXPECT_MATCHER%s}" &>/dev/null && EXPECT_MATCHER="${EXPECT_MATCHER%s}"
  done
  declare -F "$EXPECT_MATCHER" &>/dev/null || return 44
}

ExpectMatchers.utils.inspect() {
  case "${EXPECT_INSPECT:-declare}" in 
    declare)
      local value="${1:-}"
      local output="$( declare -p value )"
      printf '%s' "${output#declare -- value=}"
      ;;
    cat) printf "'%s'" "$( printf '%s' "${1:-}" | cat -vET )" ;;
    simple) printf '%s' "${1:-}" ;;
    *) echo "Unknown EXPECT_INSPECT value '${EXPECT_INSPECT:-}', expected one of: declare, cat, simple" >&2; return 1 ;;
  esac
}

ExpectMatchers.utils.inspectList() {
  while (( $# > 0 )); do
    ExpectMatchers.utils.inspect "$1"
    shift
    (( $# > 0 )) && printf ' '
  done
}
