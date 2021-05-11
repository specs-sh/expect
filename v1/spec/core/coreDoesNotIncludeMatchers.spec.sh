@spec.core_does_not_include_matchers() {
  refute run [[ expect "foo" toBeEmpty ]]
  [[ "$STDERR" = *"expect.matcher.toBeEmpty: command not found"* ]] || expect.fail "error not included in STDERR: $STDERR"

  refute run [[ expect "foo" toContain ]]
  [[ "$STDERR" = *"expect.matcher.toContain: command not found"* ]] || expect.fail "error not included in STDERR: $STDERR"

  refute run [[ expect "foo" toEqual ]]
  [[ "$STDERR" = *"expect.matcher.toEqual: command not found"* ]] || expect.fail "error not included in STDERR: $STDERR"

  refute run [[ expect "foo" toFail ]]
  [[ "$STDERR" = *"expect.matcher.toFail: command not found"* ]] || expect.fail "error not included in STDERR: $STDERR"

  refute run [[ expect "foo" toMatch ]]
  [[ "$STDERR" = *"expect.matcher.toMatch: command not found"* ]] || expect.fail "error not included in STDERR: $STDERR"

  refute run [[ expect "foo" toOutput ]]
  [[ "$STDERR" = *"expect.matcher.toOutput: command not found"* ]] || expect.fail "error not included in STDERR: $STDERR"
}