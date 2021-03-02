# TODO refactor this into 2 much simpler native arrays to represent pairs - no string separator - and remove the 3x
[ -z "$EXPECT_BLOCK_PAIRS" ] && EXPECT_BLOCK_PAIRS="{\n}\n{{\n}}\n{{{\n}}}\n[\n]\n[[\n]]\n[[[\n]]]\n"

expect() {
  [ $# -eq 0 ] && { echo "Missing required argument for 'expect': actual value or { code block } or {{ subshell code block }}" >&2; return 1; }
  EXPECT_VERSION=0.5.0
  [ $# -eq 1 ] && [ "$1" = "--version" ] && { echo "expect version $EXPECT_VERSION"; return 0; }
  local ___expect___BlockPairsArray
  IFS=$'\n' read -d '' -ra ___expect___BlockPairsArray < <(printf "$EXPECT_BLOCK_PAIRS")
  local ___expect___BlockSymbolIndex=0
  while [ $___expect___BlockSymbolIndex -lt "${#___expect___BlockPairsArray[@]}" ]
  do
    local ___expect___StartSymbol="${___expect___BlockPairsArray[$___expect___BlockSymbolIndex]}"
    (( ___expect___BlockSymbolIndex += 1 ))
    local ___expect___EndSymbol="${___expect___BlockPairsArray[$___expect___BlockSymbolIndex]}"
    (( ___expect___BlockSymbolIndex += 1 ))
    if [ -n "$___expect___StartSymbol" ] && [ -n "$___expect___EndSymbol" ]
    then
      if [ "$1" = "$___expect___StartSymbol" ]
      then
        local EXPECT_BLOCK_OPEN="$___expect___StartSymbol"
        local EXPECT_BLOCK_CLOSE="$___expect___EndSymbol"
        break
      fi
    fi
  done
  local EXPECT_BLOCK_TYPE="$EXPECT_BLOCK_OPEN"
  local EXPECT_ACTUAL_RESULT=""
  declare -a EXPECT_BLOCK=()
  if [ -n "$EXPECT_BLOCK_TYPE" ]
  then
    shift    
    while [ "$1" != "$EXPECT_BLOCK_CLOSE" ] && [ $# -gt 0 ]
    do
      EXPECT_BLOCK+=("$1")
      shift
    done
    [ "$1" != "$EXPECT_BLOCK_CLOSE" ] && { echo "Expected '$EXPECT_BLOCK_OPEN' block to be closed with '$EXPECT_BLOCK_CLOSE' but no '$EXPECT_BLOCK_CLOSE' provided" >&2; return 1; }
    shift
  else
    EXPECT_ACTUAL_RESULT="$1"
    shift
  fi
  local EXPECT_NOT=""
  [ "$1" = "not" ] && { EXPECT_NOT=true; shift; }
  local EXPECT_MATCHER_NAME="$1"
  shift
  if [ -n "$EXPECT_MATCHER_FUNCTION" ]
  then
    "$EXPECT_MATCHER_FUNCTION" "$@"
  else
    "expect.matcher.$EXPECT_MATCHER_NAME" "$@"
  fi
}

EXPECT_FAIL="exit 1"

expect.fail() { echo -e "$*" >&2; $EXPECT_FAIL; }

# TODO move this into expect under -- to note add another function into the scope!
expect.execute_block() {
  local ___expect___allowFailure=""
  [ "$1" = allowFailure ] && { ___expect___allowFailure=true; shift; }
  if [ "${#EXPECT_BLOCK[@]}" -gt 0 ]
  then
    local ___expect___RunInSubshell=""
    # TODO define the subshell -vs- not subshell types in a configurable variable
    [ "$EXPECT_BLOCK_TYPE" = "{{" ] || [ "$EXPECT_BLOCK_TYPE" = "[[" ] && ___expect___RunInSubshell=true
    local ___expect___stdout_file="$( mktemp )"
    local ___expect___stderr_file="$( mktemp )"
    if [ "$___expect___RunInSubshell" = "true" ]
    then
      # TODO pipe aliases instead of temporary files
      local ___expect___UnusedVariable
      ___expect___UnusedVariable="$( "${EXPECT_BLOCK[@]}" 1>"$___expect___stdout_file" 2>"$___expect___stderr_file" )"
      # Rename EXITCODE to STATUS
      EXPECT_EXITCODE=$?
    else
      if [[ "$SHELLOPTS" = *"errexit"* ]]
      then
        set +e
        "${EXPECT_BLOCK[@]}" 1>"$___expect___stdout_file" 2>"$___expect___stderr_file"
        EXPECT_EXITCODE=$?
        set -e
      else
        "${EXPECT_BLOCK[@]}" 1>"$___expect___stdout_file" 2>"$___expect___stderr_file"
        EXPECT_EXITCODE=$?
      fi
    fi
    EXPECT_STDOUT="$( < "$___expect___stdout_file" )"
    EXPECT_STDERR="$( < "$___expect___stderr_file" )"
    rm -rf "$___expect___stdout_file"
    rm -rf "$___expect___stderr_file"
    if [ $EXPECT_EXITCODE -ne 0 ]  && [ -z "$___expect___allowFailure" ]
    then
      echo "'expect' command failed unexpectedly: ${EXPECT_BLOCK[*]}" >&2
      [ -n "$EXPECT_STDOUT" ] && echo " Output:  $EXPECT_STDOUT" >&2
      if shopt -q extglob
      then
        [ -n "$EXPECT_STDERR" ] && echo "Command output: ${EXPECT_STDERR/expect.sh: line +([[:digit:]]): }" >&2
      else
        shopt -s extglob
        [ -n "$EXPECT_STDERR" ] && echo "Command error: ${EXPECT_STDERR/expect.sh: line +([[:digit:]]): }" >&2
        shopt -u extglob
      fi
      return 1
    else
      return 0
    fi
  fi
}