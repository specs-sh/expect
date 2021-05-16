ExpectMatchers.utils.inspect() {
  case "${EXPECT_INSPECT:-declare}" in 
    declare)
      local value="$1"
      local output="$( declare -p value )"
      printf '%s' "${output#declare -- value=}"
      ;;
    cat) printf "'%s'" "$( printf '%s' "$1" | cat -vET )" ;;
    simple) printf '%s' "$1" ;;
    *) echo "Unknown EXPECT_INSPECT value '$EXPECT_INSPECT', expected one of: declare, cat, simple" >&2; return 1 ;;
  esac
}

ExpectMatchers.utils.inspectList() {
  while (( $# > 0 )); do
    expect.inspect "$1"
    shift
    (( $# > 0 )) && printf ' '
  done
}