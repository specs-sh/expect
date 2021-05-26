# Copyright (c) 2021 Rebecca Taylor - MIT License
#
# GENERATED FILE [DO NOT EDIT]
#

# brackets Version 2.0.0
Brackets.single() {
  local -r BRACKETS_VERSION=2.0.0
  local -ra BRACKETS_ORIGINAL_ARGUMENTS=("$@")

  (( $# == 0 )) && { echo "Brackets [: missing required arguments: [!] [-bcdefghknprstuwxzGLNOS] [actual] [operator] [expected] ']'" >&2; return 46; }
  (( $# == 1 )) && [ "$1" = --version ] && { echo "Brackets version $BRACKETS_VERSION"; return 0; }
  if [ "${BRACKETS_ORIGINAL_ARGUMENTS[${#BRACKETS_ORIGINAL_ARGUMENTS[@]}-1]}" != ']' ]; then
    printf "Brackets [: missing closing ']' bracket. Provided arguments: [: %s" "$( Expect.utils.inspectArguments "${BRACKETS_ORIGINAL_ARGUMENTS[@]}" )" >&2
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
    printf "Brackets [: %s ] missing required arguments: [-bcdefghknprstuwxzGLNOS] [actual] [operator] [expected]" "$( Expect.utils.inspectArguments "${BRACKETS_BLOCK_ARGUMENTS[@]}" )" >&2
    return 46
  fi
  if (( ${#__brackets__argumentList[@]} != 2 )) && (( ${#__brackets__argumentList[@]} != 3 )); then
    printf "Brackets [: %s ] missing required arguments: [-bcdefghknprstuwxzGLNOS] [operator] [expected]" "$( Expect.utils.inspectArguments "${BRACKETS_BLOCK_ARGUMENTS[@]}" )" >&2
    return 46
  fi

  local __brackets__leftHandSide= __brackets__operator= __brackets__rightHandSide= __brackets__matcher=

  if (( ${#__brackets__argumentList[@]} == 2 )); then
    case "${__brackets__argumentList[0]}" in
      -z) Expect.assert "${__brackets__argumentList[1]}" $BRACKETS_NOT empty ;;
      -n) [ "$BRACKETS_NOT" = not ] && BRACKETS_NOT= || BRACKETS_NOT=not; Expect.assert "${__brackets__argumentList[1]}" $BRACKETS_NOT empty ;;
      *) printf "Brackets unknown operator: %s. Provided arguments: [: %s ]" "$( Expect.utils.inspect "${__brackets__argumentList[0]}" )" "$( Expect.utils.inspectArguments "${__brackets__argumentList[@]}" )"  >&2; return 46 ;;
    esac
  elif (( ${#__brackets__argumentList[@]} == 3 )); then
    case "${__brackets__argumentList[1]}" in
      =) Expect.assert "${__brackets__argumentList[0]}" $BRACKETS_NOT equal "${__brackets__argumentList[2]}" ;;
      !=) [ "$BRACKETS_NOT" = not ] && BRACKETS_NOT= || BRACKETS_NOT=not; Expect.assert "${__brackets__argumentList[0]}" $BRACKETS_NOT equal "${__brackets__argumentList[2]}" ;;
      *) printf "Brackets unknown operator: %s. Provided arguments: [: %s ]" "$( Expect.utils.inspect "${__brackets__argumentList[1]}" )" "$( Expect.utils.inspectArguments "${__brackets__argumentList[@]}" )"  >&2; return 46 ;;
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

# Included matchers/* matcher


# Included Expect SDK 2.0.0

# This is the main function underlying all assertions.
# All assertion libraries are wrappers around this function.
Expect.assert() {
  local -r EXPECT_VERSION="2.0.0"
  (( $# == 1 )) && [ "$1" = --version ] && { echo "Expect version $EXPECT_VERSION"; return 0; }

  local -a EXPECT_ORIGINAL_ARGUMENTS=("$@") EXPECT_ARGUMENTS=("$@") EXPECT_PROVIDED=() EXPECT_ACTUAL=() EXPECT_COMMAND=() EXPECT_ACTUAL_ARRAY=()

  local EXPECT_PROVIDED_TYPE=TEXT EXPECT_ACTUAL_TYPE=TEXT EXPECT_MATCHER= EXPECT_NOT="${EXPECT_NOT:-}" \
        EXPECT_BLOCK_OPEN= EXPECT_BLOCK_CLOSE= \
        EXPECT_COMMAND_STDOUT= EXPECT_COMMAND_STDERR= \
        EXPECT_BASH_ASSOCIATIVE_ARRAYS= EXPECT_BASH_NAME_REFERENCES= EXPECT_BASH_UPPERLOWER= \
        __expect__argument= __expect__isCommand= EXPECT_COMMAND_SUBSHELL= __expect__stdoutTempFile= __expect__stderrTempFile= __expect__nounsetOn= __expect__returnValue=

  local -i EXPECT_COMMAND_EXITCODE=0

  (( ${BASH_VERSINFO[0]} >= 4 )) && { EXPECT_BASH_ASSOCIATIVE_ARRAYS=true; EXPECT_BASH_UPPERLOWER=true; }
  (( ${BASH_VERSINFO[0]} >= 5 )) || { (( ${BASH_VERSINFO[0]} == 4 )) && (( ${BASH_VERSINFO[1]} >= 3 )); } && EXPECT_BASH_NAME_REFERENCES=true

  case "$1" in
    {)    EXPECT_BLOCK_OPEN={;    EXPECT_BLOCK_CLOSE=};    EXPECT_PROVIDED_TYPE=COMMAND ;;
    {{)   EXPECT_BLOCK_OPEN={{;   EXPECT_BLOCK_CLOSE=}};   EXPECT_PROVIDED_TYPE=COMMAND; EXPECT_COMMAND_SUBSHELL=true ;;
    {{{)  EXPECT_BLOCK_OPEN={{{;  EXPECT_BLOCK_CLOSE=}}};  EXPECT_PROVIDED_TYPE=COMMAND ;;
    {{{{) EXPECT_BLOCK_OPEN={{{{; EXPECT_BLOCK_CLOSE=}}}}; EXPECT_PROVIDED_TYPE=COMMAND; EXPECT_COMMAND_SUBSHELL=true ;;
    [)    EXPECT_BLOCK_OPEN=[;    EXPECT_BLOCK_CLOSE=];    EXPECT_PROVIDED_TYPE=LIST ;;
    [[)   EXPECT_BLOCK_OPEN=[[;   EXPECT_BLOCK_CLOSE=]];   EXPECT_PROVIDED_TYPE=LIST ;;
    [[[)  EXPECT_BLOCK_OPEN=[[[;  EXPECT_BLOCK_CLOSE=]]];  EXPECT_PROVIDED_TYPE=LIST ;;
    [[[[) EXPECT_BLOCK_OPEN=[[[[; EXPECT_BLOCK_CLOSE=]]]]; EXPECT_PROVIDED_TYPE=LIST ;;
  esac

  if [ -n "$EXPECT_BLOCK_OPEN" ]; then
    shift
    until (( $# == 0 )) || [ "${1:-}" = "$EXPECT_BLOCK_CLOSE" ]; do
      EXPECT_PROVIDED+=("$1"); shift
    done
    if (( $# == 0 )); then
      # Backtrack. No close.
      # This is therefore not a block.
      # Reset everything.
      EXPECT_PROVIDED=() EXPECT_BLOCK_OPEN= EXPECT_BLOCK_CLOSE= EXPECT_PROVIDED_TYPE=TEXT
      set -- "${EXPECT_ARGUMENTS[@]}"
    else
      shift # Shift off the block close, e.g. }}
      EXPECT_ARGUMENTS=("$@")
    fi
  fi

  if [ -z "$EXPECT_BLOCK_OPEN" ]; then
    EXPECT_PROVIDED=("$1")
    shift
    EXPECT_ARGUMENTS=("$@")
  fi

  # Do this after the command is run:

  case "$EXPECT_PROVIDED_TYPE" in
    COMMAND) EXPECT_COMMAND=("${EXPECT_PROVIDED[@]}") ;; # EXPECT_ACTUAL will be set below after the command is run.
    LIST)    (( ${#EXPECT_PROVIDED[@]} == 0 )) && EXPECT_ACTUAL=() || EXPECT_ACTUAL=("${EXPECT_PROVIDED[@]}"); EXPECT_ACTUAL_TYPE=LIST ;;
    *)       (( ${#EXPECT_PROVIDED[@]} == 0 )) && EXPECT_ACTUAL=() || EXPECT_ACTUAL=("${EXPECT_PROVIDED[*]}")
  esac

  if [ "$EXPECT_PROVIDED_TYPE" = COMMAND ]; then
    __expect__stderrTempFile="$( mktemp )" || { echo "run: failed to create temporary file to store standard error using 'mktemp'" >&2; return 2; }
    if [ "$EXPECT_COMMAND_SUBSHELL" = true ]; then
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
    EXPECT_ACTUAL=("${EXPECT_COMMAND_STDOUT}${EXPECT_COMMAND_STDERR}")
  fi

  [ "$1" = not ] && { EXPECT_NOT=true; shift; }

  # (( $# == 0 )) && echo TODO ERROR

  EXPECT_ARGUMENTS=("$@")
  EXPECT_SEARCH_ARGUMENTS=("${EXPECT_ARGUMENTS[@]}")
  EXPECT_MATCHER=
  shopt -qo nounset && { __expect__nounsetOn=true; set +u; }
  until (( ${#EXPECT_ARGUMENTS[@]} == 0 )); do
    if Expect.private.nextMatcher; then
      "$EXPECT_MATCHER" "${EXPECT_ARGUMENTS[@]}" || { __expect__returnValue=$?; [ "$__expect__nounsetOn" = true ] && set -u; return $__expect__returnValue; }
      EXPECT_MATCHER= EXPECT_NOT=
    else
      echo "No matcher found for type: '$EXPECT_ACTUAL_TYPE', arguments: [ ${EXPECT_SEARCH_ARGUMENTS[*]} ]" >&2
      [ "$__expect__nounsetOn" = true ] && set -u
      return 44
    fi
    EXPECT_SEARCH_ARGUMENTS=("${EXPECT_ARGUMENTS[@]}")
  done
}


Expect.private.nextMatcher() {
  EXPECT_MATCHER="${EXPECT_MATCHER_PREFIX:-ExpectMatcher}"
  until (( ${#EXPECT_ARGUMENTS[@]} == 0 )) || declare -F "$EXPECT_MATCHER.$EXPECT_ACTUAL_TYPE" &>/dev/null || declare -F "$EXPECT_MATCHER.ANY" &>/dev/null; do
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
    if declare -F "${EXPECT_MATCHER%s}.$EXPECT_ACTUAL_TYPE" &>/dev/null || declare -F "${EXPECT_MATCHER%s}.ANY" &>/dev/null; then
      EXPECT_MATCHER="${EXPECT_MATCHER%s}"
    elif declare -F "${EXPECT_MATCHER%ing}.$EXPECT_ACTUAL_TYPE" &>/dev/null || declare -F "${EXPECT_MATCHER%ing}.ANY" &>/dev/null; then
      EXPECT_MATCHER="${EXPECT_MATCHER%ing}"
    fi
  done
  if declare -F "$EXPECT_MATCHER.$EXPECT_ACTUAL_TYPE" &>/dev/null; then
    EXPECT_MATCHER="$EXPECT_MATCHER.$EXPECT_ACTUAL_TYPE" 
  elif declare -F "$EXPECT_MATCHER.ANY" &>/dev/null; then
    EXPECT_MATCHER="$EXPECT_MATCHER.ANY" 
  else
    return 44
  fi
}


# Print out a list of arguments.
# This is the same as #inspectArguments but wraps the arguments in parenthesis, e.g. ("Hello" "World")
Expect.utils.inspectList() {
  printf '('
  Expect.utils.inspectArguments "$@"
  printf ')'
  return 0
}


# Inspect the provided value (only accepts one argument, see #inspectList or #inspectArguments for multiple).
#
# You can set EXPECT_INSPECT when calling #inspect and it will call one of the existing Expect.utils.inspect.* functions.
# By default, the available values are: declaredValue (default), showSymbols, and simple.
# These can be called directly, e.g. Expect.utils.inspect.showSymbols (which shows newlines/tabs/etc as symbols $ ^I etc).
# You can add your own inspection function which will be usable via the EXPECT_INSPECT variable by
# defining a function with the signature Expect.utils.inspect.[something].
Expect.utils.inspect() {
  local inspectFunctionName="Expect.utils.inspect.${EXPECT_INSPECT:-declaredValue}"
  if declare -F "$inspectFunctionName" &>/dev/null; then
    "$inspectFunctionName" "$@"
  else
    printf "Unsupported Expect inspection type: %s\nFunction not found: %s" "${EXPECT_INSPECT:-declaredValue}" "$inspectFunctionName" >&2
    return 1
  fi
  return 0
}


# Show the value formatted via 'declare -p'
Expect.utils.inspect.declaredValue() {
  local value="${1:-}"
  local output="$( declare -p value )"
  printf '%s' "${output#declare -- value=}"
}


# Prints the value directly, equivalent to 'printf %s value'.
Expect.utils.inspect.simple() {
  printf '%s' "${1:-}"
}


# Show symbols using 'cat -vET'
Expect.utils.inspect.showSymbols() {
  printf "'%s'" "$( printf '%s' "${1:-}" | cat -vET )"
}


# Print out every argument inspected via #inspect separated by single spaces.
Expect.utils.inspectArguments() {
  while (( $# > 0 )); do
    Expect.utils.inspect "$1"
    shift
    (( $# > 0 )) && printf ' '
  done
  return 0
}


