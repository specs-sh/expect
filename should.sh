set -uo pipefail # Remove when ready for production
source core/core.sh # Switch to compilation when ready for production

{{() {
  [ "${2:-}" = '}}' ] || { echo "TODO BOOM" >&2; return 1; }
  local -r __should__actual="$1"
  shift 2
  Expect.core.assert should "$__should__actual" "$@";
}

{{{() {
  local -a __should__command=()
  until (( $# == 0 )) || [ "$1" = }}} ]; do
    __should__command+=("$1"); shift
  done
  # errors here ...
  shift
  Expect.core.assert should { "${__should__command[@]}" } "$@";
}