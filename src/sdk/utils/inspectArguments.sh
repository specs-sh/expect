# Print out every argument inspected via #inspect separated by single spaces.
Expect.utils.inspectArguments() {
  while (( $# > 0 )); do
    Expect.utils.inspect "$1"
    shift
    (( $# > 0 )) && printf ' '
  done
  return 0
}
