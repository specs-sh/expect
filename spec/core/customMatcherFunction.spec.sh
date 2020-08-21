custom.matcherFunction() {
  foo="Well, hey there, look at that! You used matcher '$EXPECT_MATCHER_NAME' but the custom function was called with args: [$*]"
}

@spec.matchers.can_customize_matcher_function_name_lookup() {
  local foo=""
  assert [ -z "$foo" ]

  EXPECT_MATCHER_FUNCTION=custom.matcherFunction

  expect { something in the block } toBeCustom arg1 "another arg"

  assert [ "$foo" = "Well, hey there, look at that! You used matcher 'toBeCustom' but the custom function was called with args: [arg1 another arg]" ]
}