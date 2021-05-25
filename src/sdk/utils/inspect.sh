# Inspect the provided value (only accepts one argument, see #inspectList or #inspectArguments for multiple).
#
# You can set EXPECT_INSPECT when calling #inspect and it will call one of the existing Expect.utils.inspect.* functions.
# By default, the available values are: declaredValue (default), showSymbols, and simple.
# These can be called directly, e.g. Expect.utils.inspect.showSymbols (which shows newlines/tabs/etc as symbols $ ^I etc).
# You can add your own inspection function which will be usable via the EXPECT_INSPECT variable by
# defining a function with the signature Expect.utils.inspect.[something].
Expect.utils.inspect() {
  local inspectFunctionName="Expect.utils.inspect.${EXPECT_INSPECT:-declaredValue}"
  if declare -F "$inspectFunctionName" &>/dev/null; then
    "$inspectFunctionName" "$@"
  else
    printf "Unsupported Expect inspection type: %s\nFunction not found: %s" "${EXPECT_INSPECT:-declaredValue}" "$inspectFunctionName" >&2
    return 1
  fi
  return 0
}
