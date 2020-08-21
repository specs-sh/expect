@spec.expect.noArguments() {
  refute run expect
  assert [ "$STDOUT" = "" ]
  assert [ "$STDERR" = "Missing required argument for 'expect': actual value or { code block } or {{ subshell code block }}" ]
}