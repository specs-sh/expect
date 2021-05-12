ExpectMatchers.utils.inspect() {
  printf "'%s'" "$( printf '%s' "$1" | cat -vET )"
}

ExpectMatchers.utils.inspectList() {
  while (( $# > 0 )); do
    expect.inspect "$1"
    shift
    (( $# > 0 )) && printf ' '
  done
}