source vendor/run.sh
source vendor/assert.sh
source vendor/refute.sh

STDOUT= STDERR= EXITCODE=

e.g.() {
  local assertionsLibrary
  if [ -n "$RUN_EXAMPLE" ] && [ "$RUN_EXAMPLE" = "$1" ]; then
    assertionsLibrary="$1"; shift; shift
    [ -f "$assertionsLibrary.sh" ] && source "$assertionsLibrary.sh" || { echo "Could not load assertion library for example: $assertionsLibrary.sh"; exit 1; }
    run -p {{{ "$@" }}} || :
  fi
  return 0
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