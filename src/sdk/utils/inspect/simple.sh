# Prints the value directly, equivalent to 'printf %s value'.
Expect.utils.inspect.simple() {
  printf '%s' "${1:-}"
}
