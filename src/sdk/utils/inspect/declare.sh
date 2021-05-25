# Show the value formatted via 'declare -p'
Expect.utils.inspect.declaredValue() {
  local value="${1:-}"
  local output="$( declare -p value )"
  printf '%s' "${output#declare -- value=}"
}
