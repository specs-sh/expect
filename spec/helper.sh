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