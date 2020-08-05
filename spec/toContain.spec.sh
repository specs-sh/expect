import @expect/matchers/toContain

@spec.toContain.wrong_number_of_arguments() {
  refute run expect "Hi" toContain
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "toContain expects 1 or more arguments, received 0 []" ]
}

@spec.toContain() {
  assert run expect "Hello, world!" toContain "Hello" "world"
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run expect "Goodnight, moon!" toContain "Hello" "world"
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "Expected result to contain text\nActual text: 'Goodnight, moon!$'\nExpected text: 'Hello$'" ]

  refute run expect "Goodnight, moon!" toContain "Goodnight" "world"
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "Expected result to contain text\nActual text: 'Goodnight, moon!$'\nExpected text: 'world$'" ]
}

@spec.toContain.newlines_and_tabs_etc() {
  refute run expect "Hello\tworld" toContain "Goodnight\nmoon"
  assert [ -z "$STDOUT" ]
  local expected="$( echo -e "Goodnight\nmoon" | cat -A )"
  assert [ "$STDERR" = "Expected result to contain text\nActual text: 'Hello^Iworld$'\nExpected text: '$expected'" ]
}

@spec.not.toContain() {
  assert run expect "Hello, world!" not toContain "Goodnight" "moon"
  assert [ -z "$STDOUT" ]
  assert [ -z "$STDERR" ]

  refute run expect "Hello, world!" not toContain "Goodnight" "world"
  assert [ -z "$STDOUT" ]
  assert [ "$STDERR" = "Expected result not to contain text\nActual text: 'Hello, world!$'\nUnexpected text: 'world$'" ]
}