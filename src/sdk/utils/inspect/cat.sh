# Show symbols using 'cat -vET'
Expect.utils.inspect.showSymbols() {
  printf "'%s'" "$( printf '%s' "${1:-}" | cat -vET )"
}
