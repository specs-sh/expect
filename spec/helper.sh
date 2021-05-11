source vendor/assert.sh
source vendor/refute.sh
source vendor/run.sh

loadAllMatchers() {
  local __matcherFile__
  while read -rd '' __matcherFile__; do
    source "$__matcherFile__"
  done < <( find matchers/ -type f -name "*.sh" -print0 )
}
