# Print out a list of arguments.
# This is the same as #inspectArguments but wraps the arguments in parenthesis, e.g. ("Hello" "World")
Expect.utils.inspectList() {
  printf '('
  Expect.utils.inspectArguments "$@"
  printf ')'
  return 0
}
