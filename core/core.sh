set -uo pipefail # Remove when ready for production
source core/utils.sh # Switch to compilation when ready for production

Expect.assert() {
  local -a EXPECT_ORIGINAL_ARGUMENTS=("$@") EXPECT_ARGUMENTS=() EXPECT_COMMAND=()
  local EXPECT_TYPE="${1:-expect}" EXPECT_ACTUAL= EXPECT_MATCHER= EXPECT_NOT= EXPECT_IS_ARRAY= \
        EXPECT_BLOCK_OPEN= EXPECT_BLOCK_CLOSE= \
        EXPECT_COMMAND_STDOUT= EXPECT_COMMAND_STDERR= \
        EXPECT_BASH_ASSOCIATIVE_ARRAYS= EXPECT_BASH_NAME_REFERENCES= \
        __expect__argument= __expect__isCommand= __expect__runCommandInSubShell= __expect__stdoutTempFile= __expect__stderrTempFile=
  local -i EXPECT_COMMAND_EXITCODE=0
  shift

  case "$1" in
    {)  EXPECT_BLOCK_OPEN={; EXPECT_BLOCK_CLOSE=} ;;
    [)  EXPECT_BLOCK_OPEN=[; EXPECT_BLOCK_CLOSE=] ;;
    {{) EXPECT_BLOCK_OPEN={{; EXPECT_BLOCK_CLOSE=}}; __expect__runCommandInSubShell=true ;;
    [[) EXPECT_BLOCK_OPEN=[[; EXPECT_BLOCK_CLOSE=]]; __expect__runCommandInSubShell=true ;;
  esac

  if [ -n "$EXPECT_BLOCK_OPEN" ]; then
    for __expect__argument in "${EXPECT_ORIGINAL_ARGUMENTS[@]:2}"; do
      [ "$__expect__argument" = "$EXPECT_BLOCK_CLOSE" ] && { __expect__isCommand=true; break; }
      EXPECT_COMMAND+=("$__expect__argument")
    done
    __expect__argument=
    if [ "$__expect__isCommand" = true ]; then
      (( ${#EXPECT_COMMAND[@]} == 0 )) && { echo "Error TODO no command" >&2; return 31; }
      shift "$(( 2 + ${#EXPECT_COMMAND[@]} ))"  # shift off {{ ... }}
    else
      EXPECT_BLOCK_OPEN= EXPECT_BLOCK_CLOSE= EXPECT_COMMAND=()
    fi
  fi

  if [ "$__expect__isCommand" = true ]; then
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
  else
    EXPECT_ACTUAL="$1"; shift
  fi

  [ "$1" = not ] && { EXPECT_NOT=true; shift; }

  (( ${BASH_VERSINFO[0]} >= 4 )) && EXPECT_BASH_ASSOCIATIVE_ARRAYS=true
  (( ${BASH_VERSINFO[0]} >= 5 )) || { (( ${BASH_VERSINFO[0]} == 4 )) && (( ${BASH_VERSINFO[1]} >= 3 )); } && EXPECT_BASH_NAME_REFERENCES=true

  # (( $# == 0 )) && echo TODO ERROR
  EXPECT_ARGUMENTS=("$@")
  EXPECT_SEARCH_ARGUMENTS=("${EXPECT_ARGUMENTS[@]}")
  EXPECT_MATCHER=
  until (( ${#EXPECT_ARGUMENTS[@]} == 0 )); do
    if Expect.core.nextMatcher; then
      "$EXPECT_MATCHER" "${EXPECT_ARGUMENTS[@]}" || return $?
      EXPECT_MATCHER= EXPECT_NOT=
    else
      echo "No matcher found for arguments: ${EXPECT_SEARCH_ARGUMENTS[*]}" >&2
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