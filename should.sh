# Copyright (c) 2021 Rebecca Taylor - MIT License
#
# GENERATED FILE [DO NOT EDIT]
#

# should Version 2.0.0
{{() {
  local SHOULD_ACTUAL=
  local -a SHOULD_ACTUAL_LIST=()
  until (( $# == 0 )) || [ "$1" = }} ]; do
    SHOULD_ACTUAL_LIST+=("$1"); shift
  done

  if [ "$1" = }} ]; then
    shift
  else
    echo "TODO BOOM" >&2
    return 1
  fi

  if (( ${#SHOULD_ACTUAL_LIST[@]} == 1 )); then
    local -r SHOULD_ACTUAL="${SHOULD_ACTUAL_LIST[0]}"
    Expect.assert "$SHOULD_ACTUAL" "$@"
  else
    local -r SHOULD_ACTUAL=""
    Expect.assert [ "${SHOULD_ACTUAL_LIST[@]}" ] "$@"
  fi
}

# HIGHLY recommended and preferred for lists
:[() {
  local -a SHOULD_ACTUAL_LIST=()
  until (( $# == 0 )) || [ "$1" = ] ]; do
    SHOULD_ACTUAL_LIST+=("$1"); shift
  done
  shift

  Expect.assert [ "${SHOULD_ACTUAL_LIST[@]}" ] "$@"
}

:{{() {
  local -a SHOULD_COMMAND=()
  until (( $# == 0 )) || [ "$1" = }} ]; do
    SHOULD_COMMAND+=("$1"); shift
  done
  # errors here ...
  shift
  Expect.assert {{ "${SHOULD_COMMAND[@]}" }} "$@";
}

:{() {
  local -a SHOULD_COMMAND=()
  until (( $# == 0 )) || [ "$1" = } ]; do
    SHOULD_COMMAND+=("$1"); shift
  done
  # errors here ...
  shift
  Expect.assert { "${SHOULD_COMMAND[@]}" } "$@";
}
# Included matchers/array matcher
ExpectMatcher.array.ANY() {
  EXPECT_ACTUAL_TYPE=ARRAY_NAME
}


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
ExpectMatcher.contain.TEXT() {
  (( $# == 0 )) && { echo "Missing required argument for 'contain' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  # FIXME doesn't use actual right
  if [ "$EXPECT_NOT" = true ] && [[ "$EXPECT_ACTUAL" = *$1* ]]; then
    printf "Expected text value not to contain subtext\nActual: %s\nUnexpected: %s\n" "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" "$( ExpectMatchers.utils.inspect "$1" )" >&2
    return 51
  elif [ "$EXPECT_NOT" != true ] && [[ "$EXPECT_ACTUAL" != *$1* ]]; then
    printf "Expected text value to contain subtext\nActual: %s\nExpected: %s\n" "$( ExpectMatchers.utils.inspect "$EXPECT_ACTUAL" )" "$( ExpectMatchers.utils.inspect "$1" )" >&2
    return 51
  fi

  return 0
}

ExpectMatcher.contain.LIST() {
  (( $# == 0 )) && { echo "Missing required argument for 'contain' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  local __expected__found=
  local __expected__item=
  for __expected__item in "${EXPECT_ACTUAL[@]}"; do
    if [ "$EXPECT_NOT" = true ] && [[ "$__expected__item" = *$1* ]]; then
      printf "Expected list not to contain item with subtext\nList: (%s)\nMatching item: %s\nUnexpected: %s\n" "$( ExpectMatchers.utils.inspectList "${EXPECT_ACTUAL[@]}" )" "$( ExpectMatchers.utils.inspect "$__expected__item" )" "$( ExpectMatchers.utils.inspect "$1" )" >&2
      return 51
    elif [[ "$__expected__item" = *$1* ]]; then
      __expected__found=true
      break
    fi
  done

  if [ "$EXPECT_NOT" != true ] && [ "$__expected__found" != true ]; then
    printf "Expected list to contain item with subtext\nList: (%s)\nExpected: %s\n" "$( ExpectMatchers.utils.inspectList "${EXPECT_ACTUAL[@]}" )" "$( ExpectMatchers.utils.inspect "$1" )" >&2
    return 51
  fi

  return 0
}

ExpectMatcher.contain.ARRAY_NAME() {
  (( $# == 0 )) && { echo "Missing required argument for 'contain' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  if [ "$EXPECT_BASH_NAME_REFERENCES" = true ]; then
    local -n __expected__array="${EXPECT_ACTUAL[0]}"
  else
    eval "local -a __expected__array=(\"\${$EXPECT_ACTUAL[@]}\")"
  fi

  local __expected__found=
  local __expected__item=
  for __expected__item in "${__expected__array[@]}"; do
    if [ "$EXPECT_NOT" = true ] && [[ "$__expected__item" = *$1* ]]; then
      printf "Expected array not to contain item with subtext\nArray variable: %s\nElements: (%s)\nMatching item: %s\nUnexpected: %s\n" "${EXPECT_ACTUAL[0]}" "$( ExpectMatchers.utils.inspectList "${__expected__array[@]}" )" "$( ExpectMatchers.utils.inspect "$__expected__item" )" "$( ExpectMatchers.utils.inspect "$1" )" >&2
      return 51
    elif [[ "$__expected__item" = *$1* ]]; then
      __expected__found=true
      break
    fi
  done

  if [ "$EXPECT_NOT" != true ] && [ "$__expected__found" != true ]; then
    printf "Expected array to contain item with subtext\nArray variable: %s\nElements: (%s)\nExpected: %s\n" "${EXPECT_ACTUAL[0]}" "$( ExpectMatchers.utils.inspectList "${__expected__array[@]}" )" "$( ExpectMatchers.utils.inspect "$1" )" >&2
    return 51
  fi

  return 0
}

# Included matchers/empty matcher
ExpectMatcher.empty.TEXT() {
  if [ "$EXPECT_NOT" = true ] && [ -z "${EXPECT_ACTUAL[*]}" ]; then
    printf "Expected text not to have zero-length\nActual: %s\n" "$( ExpectMatchers.utils.inspect "${EXPECT_ACTUAL[*]}" )" >&2
    return 52
  elif [ "$EXPECT_NOT" != true ] && [ -n "${EXPECT_ACTUAL[*]}" ]; then
    printf "Expected text to have zero-length\nActual: %s\nExpected: \"\"\n" "$( ExpectMatchers.utils.inspect "${EXPECT_ACTUAL[*]}" )" >&2
    return 52
  fi

  return 0
}

ExpectMatcher.empty.LIST() {
  if [ "$EXPECT_NOT" = true ] && (( ${#EXPECT_ACTUAL[@]} == 0 )); then
    printf "Expected list not to have zero elements\nActual: ( )%s\n"
    return 52
  elif [ "$EXPECT_NOT" != true ] && (( ${#EXPECT_ACTUAL[@]} > 0 )); then
    printf "Expected list to have zero elements\nActual: (%s)\nExpected: ( )\n" "$( ExpectMatchers.utils.inspectList "${EXPECT_ACTUAL[@]}" )" >&2
    return 52
  fi

  return 0
}

ExpectMatcher.empty.ARRAY_NAME() {
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

  return 0
}

# Included matchers/equal matcher
ExpectMatcher.equal.TEXT() {
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
ExpectMatcher.eq.TEXT() { ExpectMatcher.equal.TEXT "$@"; }
ExpectMatcher.=.TEXT() { ExpectMatcher.equal.TEXT "$@"; }
ExpectMatcher.==.TEXT() { ExpectMatcher.equal.TEXT "$@"; }

# Included matchers/first matcher
ExpectMatcher.first.LIST() {
  if (( ${#EXPECT_ACTUAL[@]} > 0 )); then
    EXPECT_ACTUAL=("${EXPECT_ACTUAL[0]}")
  else
    EXPECT_ACTUAL=()
  fi
  EXPECT_ACTUAL_TYPE=TEXT
  return 0
}

ExpectMatcher.first.ARRAY_NAME() {
  if (( ${#EXPECT_ACTUAL[@]} > 0 )); then
    if [ "$EXPECT_BASH_NAME_REFERENCES" = true ]; then
      local -n __expected__array__="${EXPECT_ACTUAL[0]}"
    else
      eval "local -a __expected__array__=(\"\${$EXPECT_ACTUAL[@]}\")"
    fi
    if (( ${#__expected__array__[@]} > 0 )); then
      EXPECT_ACTUAL=("${__expected__array__[0]}")
    else
      EXPECT_ACTUAL=()
    fi
  else
    EXPECT_ACTUAL=()
  fi
  EXPECT_ACTUAL_TYPE=TEXT
  return 0
}


# Included matchers/include matcher
ExpectMatcher.include.LIST() {
  (( $# == 0 )) && { echo "Missing required argument for 'contain' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  local __expected__found=
  local __expected__item=
  for __expected__item in "${EXPECT_ACTUAL[@]}"; do
    if [ "$EXPECT_NOT" = true ] && [ "$__expected__item" = "$1" ]; then
      printf "Expected list not to include item\nList: (%s)\nMatching item: %s\nUnexpected: %s\n" "$( ExpectMatchers.utils.inspectList "${EXPECT_ACTUAL[@]}" )" "$( ExpectMatchers.utils.inspect "$__expected__item" )" "$( ExpectMatchers.utils.inspect "$1" )" >&2
      return 51
    elif [ "$__expected__item" = "$1" ]; then
      __expected__found=true
      break
    fi
  done

  if [ "$EXPECT_NOT" != true ] && [ "$__expected__found" != true ]; then
    printf "Expected list to include item\nList: (%s)\nExpected: %s\n" "$( ExpectMatchers.utils.inspectList "${EXPECT_ACTUAL[@]}" )" "$( ExpectMatchers.utils.inspect "$1" )" >&2
    return 51
  fi

  return 0
}

ExpectMatcher.include.ARRAY_NAME() {
  (( $# == 0 )) && { echo "Missing required argument for 'contain' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  if [ "$EXPECT_BASH_NAME_REFERENCES" = true ]; then
    local -n __expected__array="${EXPECT_ACTUAL[0]}"
  else
    eval "local -a __expected__array=(\"\${$EXPECT_ACTUAL[@]}\")"
  fi

  local __expected__found=
  local __expected__item=
  for __expected__item in "${__expected__array[@]}"; do
    if [ "$EXPECT_NOT" = true ] && [ "$__expected__item" = "$1" ]; then
      printf "Expected array not to include element\nArray variable: %s\nElements: (%s)\nMatching item: %s\nUnexpected: %s\n" "${EXPECT_ACTUAL[0]}" "$( ExpectMatchers.utils.inspectList "${__expected__array[@]}" )" "$( ExpectMatchers.utils.inspect "$__expected__item" )" "$( ExpectMatchers.utils.inspect "$1" )" >&2
      return 51
    elif [ "$__expected__item" = "$1" ]; then
      __expected__found=true
      break
    fi
  done

  if [ "$EXPECT_NOT" != true ] && [ "$__expected__found" != true ]; then
    printf "Expected array to include element\nArray variable: %s\nElements: (%s)\nExpected: %s\n" "${EXPECT_ACTUAL[0]}" "$( ExpectMatchers.utils.inspectList "${__expected__array[@]}" )" "$( ExpectMatchers.utils.inspect "$1" )" >&2
    return 51
  fi

  return 0
}

# Included matchers/last matcher
ExpectMatcher.last.LIST() {
  if (( ${#EXPECT_ACTUAL[@]} > 0 )); then
    EXPECT_ACTUAL=("${EXPECT_ACTUAL[${#EXPECT_ACTUAL[@]}-1]}")
  else
    EXPECT_ACTUAL=()
  fi
  EXPECT_ACTUAL_TYPE=TEXT
  return 0
}

ExpectMatcher.last.ARRAY_NAME() {
  if (( ${#EXPECT_ACTUAL[@]} > 0 )); then
    if [ "$EXPECT_BASH_NAME_REFERENCES" = true ]; then
      local -n __expected__array__="${EXPECT_ACTUAL[0]}"
    else
      eval "local -a __expected__array__=(\"\${$EXPECT_ACTUAL[@]}\")"
    fi
    if (( ${#__expected__array__[@]} > 0 )); then
      EXPECT_ACTUAL=("${__expected__array__[${#__expected__array__[@]}-1]}")
    else
      EXPECT_ACTUAL=()
    fi
  else
    EXPECT_ACTUAL=()
  fi
  EXPECT_ACTUAL_TYPE=TEXT
  return 0
}


# Included matchers/length matcher
ExpectMatcher.length.TEXT() {
  (( $# == 0 )) && { echo "Missing required argument for 'length' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  local -i __expect__length=0
  local __expect__length__actual=
  (( ${#EXPECT_ACTUAL[@]} > 0 )) && __expect__length__actual="${EXPECT_ACTUAL[0]}"
  __expect__length="${#__expect__length__actual}"

  if [ "$EXPECT_NOT" = true ] && [ "$__expect__length" = "$1" ]; then
    printf "Expected text value not to have specified length\nText: %s\nLength: %s\n" "$( ExpectMatchers.utils.inspect "$__expect__length__actual" )" "$__expect__length" >&2
    return 56
  elif [ "$EXPECT_NOT" != true ] && [ "$__expect__length" != "$1" ]; then
    printf "Expected text value to have specified length\nText: %s\nActual Length: %s\nExpected Length: %s\n" "$( ExpectMatchers.utils.inspect "$__expect__length__actual" )" "$__expect__length" "$1" >&2
    return 56
  fi

  return 0
}

ExpectMatcher.length.LIST() {
  (( $# == 0 )) && { echo "Missing required argument for 'length' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  if [ "$EXPECT_NOT" = true ] && [ "${#EXPECT_ACTUAL[@]}" = "$1" ]; then
    printf "Expected list not to have specified length\nList: (%s)\nLength: %s\n" "$( ExpectMatchers.utils.inspectList "${EXPECT_ACTUAL[@]}" )" "${#EXPECT_ACTUAL[@]}" >&2
    return 56
  elif [ "$EXPECT_NOT" != true ] && [ "${#EXPECT_ACTUAL[@]}" != "$1" ]; then
    printf "Expected list to have specified length\nList: (%s)\nActual Length: %s\nExpected Length: %s\n" "$( ExpectMatchers.utils.inspectList "${EXPECT_ACTUAL[@]}" )" "${#EXPECT_ACTUAL[@]}" "$1" >&2
    return 56
  fi

  return 0
}

ExpectMatcher.length.ARRAY_NAME() {
  (( $# == 0 )) && { echo "Missing required argument for 'length' matcher: [expected]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  if declare -p "$EXPECT_ACTUAL" 2>&1 | grep "^declare -a " &>/dev/null; then
    if [ "$EXPECT_BASH_NAME_REFERENCES" = true ]; then
      local -n __array__="${EXPECT_ACTUAL[0]}"
    else
      eval "local -a __array__=(\"\${$EXPECT_ACTUAL[@]}\")"
    fi
    if [ "$EXPECT_NOT" = true ] && [ "${#__array__[@]}" = "$1" ]; then
      printf "Expected array not to have specified length\nArray: %s\nArray Items: (%s)\nLength: %s\n" "$EXPECT_ACTUAL" "$( ExpectMatchers.utils.inspectList "${__array__[@]}" )" "${#__array__[@]}" >&2
      return 56
    elif [ "$EXPECT_NOT" != true ] && [ "${#__array__[@]}" != "$1" ]; then
      printf "Expected array to have specified length\nArray: %s\nArray Items: (%s)\nActual Length: %s\nExpected Length: %s\n" "$EXPECT_ACTUAL" "$( ExpectMatchers.utils.inspectList "${__array__[@]}" )" "${#__array__[@]}" "$1" >&2
      return 56
    fi
  else
    echo "Expected array '$EXPECT_ACTUAL' is not defined" >&2
    return 44
  fi

  return 0
}


# Included matchers/split matcher
ExpectMatcher.split.TEXT() {
  (( $# == 0 )) && { echo "Missing required argument for 'split': [separator]" >&2; return 40; }
  EXPECT_ARGUMENTS=("${EXPECT_ARGUMENTS[@]:1}")

  local __expect__split__separator="$1"
  local __expect__split__separatorLength="${#__expect__split__separator}"

  if (( ${#EXPECT_ACTUAL[@]} > 0 )); then

    local __expect__text="${EXPECT_ACTUAL[0]}"
    EXPECT_ACTUAL=()

    # Add elements between instances of the separator
    local -i __expect__i=0
    local -i __expect__lastMatch=0
    while (( __expect__i < ${#__expect__text} - __expect__split__separatorLength + 1 )); do
      if [ "${__expect__text:__expect__i:__expect__split__separatorLength}" = "$__expect__split__separator" ]; then
        EXPECT_ACTUAL+=("${__expect__text:__expect__lastMatch:__expect__i-__expect__lastMatch}")
        (( __expect__lastMatch = __expect__i + __expect__split__separatorLength ))
        (( __expect__i = __expect__lastMatch + 1 ))
      else
        (( __expect__i = __expect__i + 1 ))
      fi
    done

    # Add the last bit
    if (( $__expect__lastMatch != ${#__expect__text} - 1 )); then
      EXPECT_ACTUAL+=("${__expect__text:__expect__lastMatch:${#__expect__text}-__expect__lastMatch}")
    fi
  else
    EXPECT_ACTUAL=("")
  fi

  EXPECT_ACTUAL_TYPE=LIST

  return 0
}

# Included matchers/substring matcher
ExpectMatcher.substring.TEXT() {
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
# Rename to RUN.
Expect.assert() {
  local -r EXPECT_VERSION="2.0.0"

  local -a EXPECT_ORIGINAL_ARGUMENTS=("$@") EXPECT_ARGUMENTS=("$@") EXPECT_PROVIDED=() EXPECT_ACTUAL=() EXPECT_COMMAND=() EXPECT_ACTUAL_ARRAY=()

  local EXPECT_PROVIDED_TYPE=TEXT EXPECT_ACTUAL_TYPE=TEXT EXPECT_MATCHER= EXPECT_NOT= \
        EXPECT_BLOCK_OPEN= EXPECT_BLOCK_CLOSE= \
        EXPECT_COMMAND_STDOUT= EXPECT_COMMAND_STDERR= \
        EXPECT_BASH_ASSOCIATIVE_ARRAYS= EXPECT_BASH_NAME_REFERENCES= \
        __expect__argument= __expect__isCommand= EXPECT_COMMAND_SUBSHELL= __expect__stdoutTempFile= __expect__stderrTempFile= __expect__nounsetOn= __expect__returnValue=

  local -i EXPECT_COMMAND_EXITCODE=0

  (( ${BASH_VERSINFO[0]} >= 4 )) && EXPECT_BASH_ASSOCIATIVE_ARRAYS=true
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
    until (( $# == 0 )) || [ "$1" = "$EXPECT_BLOCK_CLOSE" ]; do
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
    LIST)    EXPECT_ACTUAL=("${EXPECT_PROVIDED[@]}"); EXPECT_ACTUAL_TYPE=LIST ;;
    *)       EXPECT_ACTUAL=("${EXPECT_PROVIDED[*]}")
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
    if Expect.core.nextMatcher; then
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

Expect.core.nextMatcher() {
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
    declare -F "${EXPECT_MATCHER%s}.$EXPECT_ACTUAL_TYPE" &>/dev/null || declare -F "${EXPECT_MATCHER%s}.ANY" &>/dev/null && EXPECT_MATCHER="${EXPECT_MATCHER%s}"
  done
  if declare -F "$EXPECT_MATCHER.$EXPECT_ACTUAL_TYPE" &>/dev/null; then
    EXPECT_MATCHER="$EXPECT_MATCHER.$EXPECT_ACTUAL_TYPE" 
  elif declare -F "$EXPECT_MATCHER.ANY" &>/dev/null; then
    EXPECT_MATCHER="$EXPECT_MATCHER.ANY" 
  else
    return 44
  fi
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
