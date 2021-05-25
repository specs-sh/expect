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
