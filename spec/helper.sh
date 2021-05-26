source vendor/run.sh
source vendor/assert.sh
source vendor/refute.sh
source spec/MESSAGES_and_CODES.sh

STDOUT= STDERR= EXITCODE=

include() {
  [ "${EXPECT_BUILD:-}" = --prod ] && return 0
  local import=
  for import; do
    [[ "$import" = *.sh ]] && source "$import" || source "$import.sh"
  done
  return 0
}

e.g.() {
  local assertionsLibrary
  if [ -n "$RUN_EXAMPLE" ] && [ "$RUN_EXAMPLE" = "$1" ]; then
    
    assertionsLibrary="$1"; shift; shift
    
    [ -f "$assertionsLibrary.sh" ] && source "$assertionsLibrary.sh" || { echo "Could not load assertion library for example: $assertionsLibrary.sh"; exit 1; }
    
    run -p {{{ "$@" }}} || :
    
    local typeUnderTest="${SPEC_FILE##*/}"; typeUnderTest="${typeUnderTest%%.*}"; typeUnderTest="$( echo "$typeUnderTest" | tr '[:lower:]' '[:upper:]' )"
    local matcherUnderTest="${SPEC_FILE%/*}"; matcherUnderTest="${matcherUnderTest##*/}"; matcherUnderTest="$( echo "$matcherUnderTest" | tr '[:lower:]' '[:upper:]' )"

    if [[ "$SPEC_TEST" = *.fail ]] || [[ "$SPEC_TEST" = *.pass ]]; then
      [[ "$SPEC_TEST" = *.fail ]] && assertFail || assertPass

      local messageVariableName="${matcherUnderTest}_${typeUnderTest}_MESSAGE"
      [[ "$SPEC_TEST" = *.not.fail ]] && messageVariableName="${matcherUnderTest}_${typeUnderTest}_NOT_MESSAGE"
      [[ "$SPEC_TEST" = *.missingArgument.fail ]] && messageVariableName="${matcherUnderTest}_${typeUnderTest}_NO_ARGUMENT_MESSAGE"
      if [ -z "${!messageVariableName:-}" ]; then
        echo "Please set $messageVariableName to expected message" >&2
        return 1
      else
        [[ "$SPEC_TEST" = *.fail ]] && assertStderr "${!messageVariableName}"
      fi

      if [[ "$SPEC_TEST" = *.missingArgument.fail ]]; then
        assertExitcode 40
      else
        local exitCodeVariableName="${matcherUnderTest}_EXITCODE"
        [ -z "${!exitCodeVariableName:-}" ] && { echo "Please set $exitCodeVariableName to expected exitcode" >&2; return 1; }
        [[ "$SPEC_TEST" = *.fail ]] && [ -n "${!exitCodeVariableName}" ] && assertExitcode "${!exitCodeVariableName}"
        [[ "$SPEC_TEST" = *.fail ]] && [ -n "${!messageVariableName}" ] && assertStderr "${!messageVariableName}"
      fi

      assertEmptyStdout
    fi
  fi
  return 0
}

assertPass() {
  (( EXITCODE == 0 )) || { echo "Expected command to pass but failed ($EXITCODE)" >&2; return 1; }
  return 0
}

assertFail() {
  (( $# > 0 )) && assertStderr "$@"
  (( EXITCODE == 0 )) && { echo "Expected command to fail but passed ($EXITCODE)" >&2; return 1; }
  return 0
}

assertStderr() {
  local expected=
  for expected; do
    if [[ "$STDERR" != *"$expected"* ]]; then
      printf "Expected STDERR to contain '%s'\nActual: %s" "$expected" "$STDERR" >&2
      return 1
    fi
  done
}

assertStdout() {
  local expected=
  for expected; do
    if [[ "$STDOUT" != *"$expected"* ]]; then
      printf "Expected STDOUT to contain '%s'\nActual: %s\n" "$expected" "$STDOUT" >&2
      return 1
    fi
  done
}

assertExitcode() {
  [ "$EXITCODE" = "$1" ] || { printf "Expected exitcode to equal\nActual: %s\nExpected: %s\n" "$EXITCODE" "$1" >&2; }
}

assertEmptyStdout() {
  [ -z "$STDOUT" ] || { printf "Expected STDOUT to be empty\nActual: '%s'" "$STDOUT" >&2; return 1; }
}

assertEmptyStderr() {
  [ -z "$STDERR" ] || { printf "Expected STDERR to be empty\nActual: '%s'" "$STDERR" >&2; return 1; }
}

runExamples() {
  local exampleFn exampleFnBody assertionsLibrary
  for exampleFn in $( declare -pF | awk '{print $3}' | grep ^example. ); do
    exampleFnBody="$( declare -f $exampleFn | tail -n +3 | head -n -1 )"
    for assertionsLibrary in assertions assertThat brackets expect should; do
      if echo "$exampleFnBody" | grep "e.g. $assertionsLibrary" &>/dev/null; then
        eval "spec.$assertionsLibrary.$exampleFn() {
          RUN_EXAMPLE=$assertionsLibrary
          $exampleFnBody
        }"
      fi
    done
  done
}