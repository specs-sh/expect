. "$( bx BxSH )"

PACKAGE_PATH=.:packages/

import @assert
import @run

# Just core
import @expect/core

stderrContains() {
  if [[ "$STDERR" != *"$1"* ]]
  then
    echo "Expected STDERR [$STDERR] to contain [$1]" >&2
    return 1
  fi
}

stdoutContains() {
  if [[ "$STDOUT" != *"$1"* ]]
  then
    echo "Expected STDOUT [$STDOUT] to contain [$1]" >&2
    return 1
  fi
}