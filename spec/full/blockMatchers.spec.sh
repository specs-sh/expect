@spec.blockMatcher.matcher_not_found() {
  refute run expect { hello } toDoSomethingNobodyDefined
  assert [ "$STDOUT" = "" ]
  if [[ "$STDERR" != *"expect.matcher.toDoSomethingNobodyDefined: command not found" ]]
  then
    echo "STDERR did not include the expected text, actual: $STDERR" >&2
    return 1
  fi
}

@spec.blockMatcher.error_if_braces_not_closed() {
  refute run expect { hello there
  assert [ "$STDOUT" = "" ]
  assert [ "$STDERR" = "Expected '{' block to be closed with '}' but no '}' provided" ]

  refute run expect {{ hello there
  assert [ "$STDOUT" = "" ]
  assert [ "$STDERR" = "Expected '{{' block to be closed with '}}' but no '}}' provided" ]

  refute run expect [ echo closed with wrong type }
  assert [ "$STDOUT" = "" ]
  assert [ "$STDERR" = "Expected '[' block to be closed with ']' but no ']' provided" ]

  refute run expect [[ echo closed with wrong type ]
  assert [ "$STDOUT" = "" ]
  assert [ "$STDERR" = "Expected '[[' block to be closed with ']]' but no ']]' provided" ]
}

expect.matcher.toDoSomething() {
  block="${EXPECT_BLOCK[@]}"
  blockType="$EXPECT_BLOCK_TYPE"
  not="$EXPECT_NOT"
  name="$EXPECT_MATCHER_NAME"
}

expect.matcher.toRunSomething() {
  expect.execute_block || return 1
}

@spec.blockMatcher.block_available_to_matcher_as_BLOCK() {
  local block=""
  assert [ "$block" = "" ]

  expect { hello I am in the block } toDoSomething

  assert [ "$block" = "hello I am in the block" ]
}

@spec.blockMatcher.type_available_to_matcher_as_EXPECT_BLOCK_TYPE() {
  local blockType=""
  assert [ "$blockType" = "" ]

  expect { hello I am in the block } toDoSomething

  assert [ "$blockType" = "{" ]

  expect {{ hello I am in the block }} toDoSomething

  assert [ "$blockType" = "{{" ]
}

@spec.blockMatcher.NOT_is_available() {
  local not=""
  assert [ -z "$not" ]

  expect { hello I am in the block } toDoSomething

  assert [ -z "$not" ]

  expect { hello I am in the block } not toDoSomething

  assert [ -n "$not" ]
}

@spec.blockMatcher.EXPECT_MATCHER_NAME_is_available() {
  local name=""
  assert [ -z "$name" ]

  expect { hello I am in the block } toDoSomething

  assert [ "$name" = "toDoSomething" ]
}

@spec.blockMatcher.can_customize_block_start_and_end_symbols() {
  local block=""
  local blockType=""
  assert [ "$block" = "" ]
  assert [ "$blockType" = "" ]

  EXPECT_BLOCK_PAIRS="$EXPECT_BLOCK_PAIRS@@\n@@\n"

  expect @@ Haha this works @@ toDoSomething

  assert [ "$block" = "Haha this works" ]
  assert [ "$blockType" = "@@" ]

  block=""
  blockType=""
  assert [ "$block" = "" ]
  assert [ "$blockType" = "" ]

  # But the regular supported ones still work too
  expect {{ Haha this works }} toDoSomething

  assert [ "$block" = "Haha this works" ]
  assert [ "$blockType" = "{{" ]

  # Can even configure if they run in subshells

  local var=5
  expect @@ updateVar @@ toRunSomething
  assert [ "$var" = "changed" ]

  # But not configure it to run in a subshell:
  var="don't change me"
  EXPECT_BLOCK_SUBSHELL_TYPES="${EXPECT_BLOCK_SUBSHELL_TYPES}@@\n"
  expect @@ updateVar @@ toRunSomething
  assert [ "$var" = "don't change me" ]
}

updateVar() {
  var="changed"
}