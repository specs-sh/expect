# 🧐 `expect.sh`

Flexible test expectation library in [< 50 LOC](https://github.com/bx-sh/expect.sh/blob/master/expect.sh)

> ```sh
> expect { BASH testing } toBe "wonderful"
> ```

---

Download the [latest release](https://github.com/bx-sh/expect.sh/archive/v0.2.0.tar.gz)

```sh
source "expect.sh"
```

---

## `expect`

The `expect` function provides a simple framework for authoring and using "expectations"

```sh
local config="file.conf"

expect "$config" toBeValidConfig

expect { deployed --configs } not toContain "$config"

expect {{ deploy "$config" }} toOutput "Successfully deployed $config"

expect { deployed --configs } toContain "$config"
```

> All applications and scripts are different.
>
> Please use this to implement your own domain-specific expectations for your tests.

---

### Authoring Expectations

- [Expectations vs Assertions](#expectations-vs-assertions)
- [Matcher functions](#writing-your-first)
- [Write a matcher function](#writing-your-first)
- [Get the actual result](#writing-your-first)
- [Compare actual and expected results](#writing-your-first)
- [Write failure messages](#exiting-on-failure)
- [Negating with 'not'](#negagting-with-not)
- [Exit on failure](#exiting-on-failure)
- [Block values](#block-values)
- [Support block syntax](#block-values)
- [Customizing block styles](#customizing-block-styles)
- [Customizing function names](#customizing-function-names)
- [Supported `EXPECT` variables](#negagting-with-not)

### Provided Expectations

- [`toEqual`](#expect)
- [`toContain`](#expect)
- [`toBeEmpty`](#expect)
- [`toMatch`](#expect)
- [`toOutput`](#expect)
- [`toFail`](#expect)

---

# Authoring Expectations

## Expectations vs Assertions

The two most common test assertion styles in programming languages are:

> #### `assert`
>
> ```sh
> assert_equal "ACTUAL", "EXPECTED"
> ```

> #### `expect`
>
> ```sh
> expect "ACTUAL" equals "EXPECTED"
> ```

There are pros and cons to each, but at the end of the day it comes down to user preference.

`assert`

- Pros:
  - Classic 🥂
  - Easy to implement additional `assert_*` functions
- Cons:
  - Easy to forget which argument is `actual` and which is `expected`
  - Requires many `assert_*` functions
    > in BASH, these "pollute" the global namespace

`expect`

- Pros:
  - Reads closer to normal language, e.g. _expect '\$result' to equal 'foo'_
  - Only requires one top-level `expect` function
    > in BASH, this means not "polluting" the global namespace with extra functions
- Cons:
  - Slightly more complicated to implement additional `expect` matchers
    > ... as you'll see below! You'll implement a variety of matchers 🍻

---

## Matcher functions

Let's implement the following **`toEq`** "matcher function"

```sh
expect "$answer" toEq 42
```

First, try running the above code _without_ implementing the function:

- ```sh
  $ source "expect.sh"

  $ expect "$answer" toEq 42
  # expect.matcher.toEq: command not found
  ```

You'll see an error: **`expect.matcher.toEq: command not found`**

By default, `expect` expects a function to exist named `expect.matcher.[MATCHER_NAME]`

The name of the matcher in this case is: `toEq`.

## Write a matcher function

Next, add that function: **`expect.matcher.toEq()`**

To start with, just print out one thing:

1.  Information about the arguments being passed to the function

    ```sh
    expect.matcher.toEq() {
      echo "toEq called with $# arguments: $*"
    }
    ```

    > You can define the above function right in your BASH shell, just copy/paste it in!

Now, try running the code again:

- ```sh
  $ source "expect.sh"

  $ expect "$answer" toEq 42
  # toEq called with 1 arguments: 42
  ```

Wonderful! This time the command did not fail and the `toEq` function was called.

As you can see, the `toEq` function received one positional argument: `42`

This is considered the **"expected result"**.

- > #### Optional
  >
  > Try passing additional arguments to `toEq`
  >
  > ```sh
  > $ expect "$answer" toEq 42 another argument "hello, world!"
  > # toEq called with 4 arguments: 42 another argument hello, world!
  > ```

But what about the `$answer` variable which is the **"actual result"**?

Instead of being provided as a positional argument, the "actual result" is available as a pre-defined variable.

## Get the actual result

Next, update the **`expect.matcher.toEq()`** function to print two things:

1.  Information about the arguments being passed to the function
2.  All of the currently defined variables which start with `EXPECT_`

    ```sh
    expect.matcher.toEq() {
      echo "toEq called with $# arguments: $*"
      declare -p | grep EXPECT_
    }
    ```

    > You can redefine the above function right in your BASH shell, just copy/paste it in!  
    > It will replace the previous function definition.

Now, try running the code again. This time, set a value for `$answer`:

- ```sh
  $ source "expect.sh"

  $ answer="This is the actual result"

  $ expect "$answer" toEq 42
  # toEq called with 1 arguments: 42
  # declare -- EXPECT_ACTUAL_RESULT="This is the actual result"
  # declare -a EXPECT_BLOCK=()
  # declare -- EXPECT_BLOCK_END_PATTERN="^[\\]}]+\$"
  # declare -- EXPECT_BLOCK_START_PATTERN="^[\\[{]+\$"
  # declare -- EXPECT_BLOCK_TYPE=""
  # declare -- EXPECT_MATCHER_NAME="toEq"
  # declare -- EXPECT_NOT=""
  # declare -- EXPECT_VERSION="0.2.0"
  ```

  > A summary of all `EXPECT_` variables is [found below](#foo) under [Supported `EXPECT` variables](#foo)

As you can see, there a number of `EXPECT_` variables available to the function.

The **"actual result"** is available in a variable named **`EXPECT_ACTUAL_RESULT`**:

- ```sh
  declare -- EXPECT_ACTUAL_RESULT="This is the actual result"
  ```

## Compare actual and expected results

The `toEq` matcher function now has access to both the **"expected result"** and **"actual result"**.

Update the function to compare the expected and actual retults:

- ```sh
  expect.matcher.toEq() {
    local expectedResult="$1"                  # e.g. 42
    local actualResult="$EXPECT_ACTUAL_RESULT" # e.g. "This is the actual result"

    if [ "$actualResult" = "$expectedResult" ]
    then
      echo "They match! This matcher should pass."
    else
      echo "Oh noes! They are not the same! This matcher should fail."
    fi
  }
  ```

Now, run the function again providing a variety of expected and actual values:

- ```sh
  $ expect 42 toEq 42
  # They match! This matcher should pass.

  $ expect 42 toEq 42-42-42-42
  # Oh noes! They are not the same! This matcher should fail.
  ```

## Write failure messages

It would be more useful if the matcher provided more info about failures when they occur.

Update the function to print out the **"actual result"** and the **"expected result"** when it fails:

- ```sh
  expect.matcher.toEq() {
    local expectedResult="$1"
    local actualResult="$EXPECT_ACTUAL_RESULT"

    if [ "$actualResult" = "$expectedResult" ]
    then
      echo "They match! I guess we don't need to print anything when it passes..."
    else
      echo "Expected values to equal"
      echo "Actual: $actualResult"
      echo "Expected: $expectedResult"
    fi
  }
  ```

Now, run the function again providing a variety of expected and actual values:

- ```sh
  $ expect 42 toEq 42
  # They match! I guess we don't need to print anything when it passes..

  $ expect 42 toEq 42-42-42-42
  # Expected values to equal
  # Actual: 42
  # Expected: 42-42-42-42
  ```

That's more useful!

## Negating with 'not'

What about handling when `not` is provided?

```sh
$ expect "$answer" not toEq 42
```

Right now, the `expect.matcher.toEq()` function does not support `not`.

To see how to support using `not`, print out the `EXPECT` variables again:

- ```sh
  expect.matcher.toEq() {
    echo "toEq called with $# arguments: $*"
    declare -p | grep EXPECT_
  }
  ```
- ```sh
  $ expect "Hello" toEq "World"
  # toEq called with 1 arguments: World
  # declare -- EXPECT_ACTUAL_RESULT="Hello"
  # declare -a EXPECT_BLOCK=()
  # declare -- EXPECT_BLOCK_END_PATTERN="^[\\]}]+\$"
  # declare -- EXPECT_BLOCK_START_PATTERN="^[\\[{]+\$"
  # declare -- EXPECT_BLOCK_TYPE=""
  # declare -- EXPECT_MATCHER_NAME="toEq"
  # declare -- EXPECT_NOT=""
  # declare -- EXPECT_VERSION="0.2.0"

  $ expect "Hello" not toEq "World"
  # toEq called with 1 arguments: World
  # declare -- EXPECT_ACTUAL_RESULT="Hello"
  # declare -a EXPECT_BLOCK=()
  # declare -- EXPECT_BLOCK_END_PATTERN="^[\\]}]+\$"
  # declare -- EXPECT_BLOCK_START_PATTERN="^[\\[{]+\$"
  # declare -- EXPECT_BLOCK_TYPE=""
  # declare -- EXPECT_MATCHER_NAME="toEq"
  # declare -- EXPECT_NOT="true"
  # declare -- EXPECT_VERSION="0.2.0"
  ```

When the `not` keyword comes before the name of the matcher `EXPECT_NOT` is set to `"true"`.

Update the function to support when `not` is used:

- ```sh
  expect.matcher.toEq() {
    local expectedResult="$1"
    local actualResult="$EXPECT_ACTUAL_RESULT"

    if [ "$EXPECT_NOT" = "true" ]
    then
      # Expect values NOT to be equal.
      #
      # If they are equal, show a failure message.
      if [ "$actualResult" = "$expectedResult" ]
      then
        echo "Expected values not to equal"
        echo "Actual: $actualResult"
        echo "Not Expected: $expectedResult"
      fi
    else
      # Expect values to be equal.
      #
      # If they are not equal, show a failure message.
      if [ "$actualResult" != "$expectedResult" ]
      then
        echo "Expected values to equal"
        echo "Actual: $actualResult"
        echo "Expected: $expectedResult"
      fi
    fi
  }
  ```

Now run the function with and without the `not` keyword:

- ```sh
  $ expect 42 toEq 42

  $ expect 42 toEq 42-42-42
  # Expected values to equal
  # Actual: 42
  # Expected: 42-42-42

  $ expect 42 not toEq 42-42-42

  $ expect 42 not toEq 42
  # Expected values not to equal
  # Actual: 42
  # Expected: 42
  ```

Wonderful! Looking great!

However, right now, a test would not fail because the function does not `return 1` or `exit 1`.

## Exit on failure

There are two common ways to "fail" an assertion or expectation in BASH test frameworks:

1.  `return 1` _(or any non-zero code)_
2.  `exit 1` _(or any non-zero code)_

Test frameworks that fail whenever a command `return 1` usually do this via `set -e`.

There are pros and cons to each approach.

`expect` can be used in either type of framework by using `expect.fail()`.

Here is the source code for the `expect.fail()` function from [`expect.sh`](https://github.com/bx-sh/expect.sh/blob/master/expect.sh):

- ```sh
  EXPECTATION_FAILED="exit 1"

  expect.fail() {
    echo -e "$*" >&2
    $EXPECTATION_FAILED
  }
  ```

By default, `expect` will `exit 1` whenever the `expect.fail()` function is called.

> Note: if you test this in your BASH shell, your shell will close and exit!

If you want to use `expect` in a framework like `Bats` which uses `set -e`:

- ```sh
  # Set the value of EXPECTATION_FAILED anywhere in your code before you use 'expect'
  EXPECTATION_FAILED="return 1"
  ```

Now, update the **`expect.matcher.toEq()`** function to call `expect.fail` on failure:

- ```sh
  expect.matcher.toEq() {
    local expectedResult="$1"
    local actualResult="$EXPECT_ACTUAL_RESULT"

    if [ "$EXPECT_NOT" = "true" ]
    then
      # Expect values NOT to be equal.
      #
      # If they are equal, show a failure message.
      if [ "$actualResult" = "$expectedResult" ]
      then
        expect.fail "Expected values not to equal\nActual: $actualResult\nNot Expected: $expectedResult"
      fi
    else
      # Expect values to be equal.
      #
      # If they are not equal, show a failure message.
      if [ "$actualResult" != "$expectedResult" ]
      then
        expect.fail "Expected values to equal\nActual: $actualResult\nExpected: $expectedResult"
      fi
    fi
  }
  ```

In your shell, set `EXPECTATION_FAILED="return 1"` and then try the function:

- ```sh
  $ expect 42 toEq 42

  $ echo $?
  # 0

  $ expect 42 toEq 42-42-42
  # Expected values to equal
  # Actual: 42
  # Expected: 42-42-42

  $ echo $?
  # 1

  $ expect 42 not toEq 42-42-42

  $ echo $?
  # 0

  $ expect 42 not toEq 42
  # Expected values not to equal
  # Actual: 42
  # Expected: 42

  $ echo $?
  # 1
  ```

**Reminder:** your function will `return` the exit status of the last command or function executed.

- If you plan to run any commands after you call `expect.fail()`, it is best practice to end your matcher with `return 0`
- ```sh
  expect.matcher.toEq() {
    local expectedResult="$1"
    local actualResult="$EXPECT_ACTUAL_RESULT"

    if [ "$EXPECT_NOT" = "true" ]
    then
      # Expect values NOT to be equal.
      # <...>
    else
      # Expect values to be equal.
      # <...>
    fi

    return 0
  }
  ```

## Block values

One limitation of using `expect "some value" toEq "another value"` is:

- The **"actual result"** can only be _ony value_, e.g. "some value"

But what if the value you are testing against is multiple values?

- e.g. You want to `expect "$@" toEq something"` (in BASH `"$@"` expands to multiple values)
- e.g. You want a command and arguments which your matcher will execute

If you want your matcher to take a command and arguments, you could try:

- `expect "command arg1 arg2" toRunSuccessfully`

But this runs into problems if you need to quote argument values:

- `expect "command 'Hello World' 'Value with spaces'" toRunSuccessfully`

To solve this problem, `expect` provides **blocks**:

- `expect { a list of things } toMeetMyExpectations`

By default, you can wrap your block in any number of curly braces or brackets:

- `expect { a list of things } toMeetMyExpectations`
- `expect {{ a list of things }} toMeetMyExpectations`
- `expect {{{ a list of things }}} toMeetMyExpectations`
- `expect [ a list of things ] toMeetMyExpectations`
- `expect [[ a list of things ]] toMeetMyExpectations`
- `expect [[[ a list of things ]]] toMeetMyExpectations`

This provides flexibility, e.g. if you want `{` and `{{` to behave differently.

### Example

The matchers which come with `expect.sh` all support using `{` or `{{`

When `{` is used, the block is executed to get the actual result

When `{{` is used, the block is executed _in a subshell_ to get the actual result

### `EXPECT_BLOCK`

To see how to support blocks, print out the `EXPECT` variables again:

- ```sh
  expect.matcher.toEq() {
    echo "toEq called with $# arguments: $*"
    declare -p | grep EXPECT_
  }
  ```
- ```sh
  $ expect "Hello" toEq "something"
  # toEq called with 1 arguments: something
  # declare -- EXPECT_ACTUAL_RESULT="Hello"
  # declare -a EXPECT_BLOCK=()
  # declare -- EXPECT_BLOCK_END_PATTERN="^[\\]}]+\$"
  # declare -- EXPECT_BLOCK_START_PATTERN="^[\\[{]+\$"
  # declare -- EXPECT_BLOCK_TYPE=""
  # declare -- EXPECT_MATCHER_NAME="toEq"
  # declare -- EXPECT_NOT=""
  # declare -- EXPECT_VERSION="0.2.2"

  $ expect { "Hello" } toEq "something"
  # toEq called with 1 arguments: something
  # declare -- EXPECT_ACTUAL_RESULT=""
  # declare -a EXPECT_BLOCK=([0]="Hello")
  # declare -- EXPECT_BLOCK_END_PATTERN="^[\\]}]+\$"
  # declare -- EXPECT_BLOCK_START_PATTERN="^[\\[{]+\$"
  # declare -- EXPECT_BLOCK_TYPE="{"
  # declare -- EXPECT_MATCHER_NAME="toEq"
  # declare -- EXPECT_NOT=""
  # declare -- EXPECT_VERSION="0.2.2"

  $ expect [[ "Hello" there, "how are" you? ]] toEq "something"
  # toEq called with 1 arguments: something
  # declare -- EXPECT_ACTUAL_RESULT=""
  # declare -a EXPECT_BLOCK=([0]="Hello" [1]="there," [2]="how are" [3]="you?")
  # declare -- EXPECT_BLOCK_END_PATTERN="^[\\]}]+\$"
  # declare -- EXPECT_BLOCK_START_PATTERN="^[\\[{]+\$"
  # declare -- EXPECT_BLOCK_TYPE="[["
  # declare -- EXPECT_MATCHER_NAME="toEq"
  # declare -- EXPECT_NOT=""
  # declare -- EXPECT_VERSION="0.2.2"
  ```

As you can see, the content of the block is available in the `EXPECT_BLOCK` BASH array.

The symbol used for the block is available as `EXPECT_BLOCK_TYPE`, e.g. `{` or `[[`.

If your matcher does not require the block syntax, fail your matcher when a block is provided:

- ```sh
  expect.matcher.toEq() {
    # If the block length is greater than one, fail the matcher with a message
    if [ "${#EXPECT_BLOCK[@]}" -gt 0 ]
    then
      expect.fail "toEq does not support block syntax"
    fi
    # ...
  }
  ```

If you want to support executing commands, like the provided matchers, follow the next section.

## Support block syntax

This provides an example implementation for executing block commands in matchers, e.g.

- ```sh
  expect { ls } toEq "file1\nfile2"
  ```

The `expect.matcher.toEq()` function will support three types of syntax:

- `expect "simple value" toEq "something"`
- `expect { command args } toEq "something"` - run command and verify its output
- `expect {{ command args }} toEq "something"` - run command in subshell and verify its output

For the block syntax, we will combine the command's `STDOUT` and `STDERR` and compare against that.

**Reminder:** functions will have access to all of the variables your matcher defines, including `local` variables!

- When we run `command args`, if it is a function, it will have access to ALL variables
- Because of this, we will prefix all of our variables with `___expect___toEq_`
- If we use a variable like `command`, it could cause variable naming collisions with the function's variables

### The Code

```sh
##
# expect.matcher.toEq: with block support
#
# see the matchers that come with expect.sh for similar examples
##
expect.matcher.toEq() {
  # By default, use the "actual result" provided by this syntax: expect "actual result" toEq "something"
  local ___expect___toEq_ActualResult="$EXPECT_ACTUAL_RESULT"

  # If a block was provided, use it to get the "actual value" as: STDOUT + STDERR
  if [ "${#EXPECT_BLOCK[@]}" -gt 0 ]
  then
    local ___expect___toEq_RunInSubshell=""

    # If {  then do not run in subshell
    [ "$EXPECT_BLOCK_TYPE" = "{" ] && ___expect___toEq_RunInSubshell="false"

    # If {{ then run in subshell
    [ "$EXPECT_BLOCK_TYPE" = "{{" ] && ___expect___toEq_RunInSubshell="true"

    # If some other block type, give an error
    [ "$EXPECT_BLOCK_TYPE" != "{" ] && [ "$EXPECT_BLOCK_TYPE" != "{{" ] && { expect.fail "toEq only supports { or {{ blocks"; return 1; }

    # Do you want to fail the matcher if the command fails?
    # Or ignore a failure to allow the following example?
    # > expect { i fail } toEq "STDERR should equal this"
    # It is up to you. I will store the $? exit code but not use it.
    local ___expect___toEq_ReturnOrExitCode


    if [ "$___expect___toEq_RunInSubshell" = "true" ]
    then
      # Run the command in a $( subshell ) piping STDERR to STDOUT so they will be combined

      # Gotcha: this will NOT WORK if you try `local output="$( subshell )"`, the $? will not be correct.
      #         if you want to get the $? of the command, you need to define the local on a previous line.
      #
      ___expect___toEq_ActualResult="$( "${EXPECT_BLOCK[@]}" 2>&1 )"

      # Get the exit code or return code of the command or function that was run
      ___expect___toEq_ReturnOrExitCode=$?
    else
      # Run the command regularly, not in a subshell, piping STDERR to STDOUT so they will be combined

      # To support getting the output of a command run locally (no subshell), store output in file
      local ___expect___toEq_outputTempFile="$( mktemp )"

      "${EXPECT_BLOCK[@]}" 2>&1 >"$___expect___toEq_outputTempFile"

      # Get the exit code or return code of the command or function that was run
      ___expect___toEq_ReturnOrExitCode=$?

      # Populate the result variable by cat'ing the temporary file (which will add an extra newline)
      ___expect___toEq_ActualResult="$( cat "$___expect___toEq_outputTempFile" )"

      # Remove the extra newline
      ___expect___toEq_ActualResult="${___expect___toEq_ActualResult/%"\n"}"

      # Cleanup the tempfile
      rm -rf "$___expect___toEq_outputTempFile"
    fi
  fi

  # Now $___expect___toEq_ActualResult has been set from EITHER the block or regular `expect "simple" toEq "something"`
  #
  # The regular matcher code can go below! And because the command has already run, no reason to prefix variables
  #
  # Copy/pasted from the existing toEq function used in the previous examples
  local expectedResult="$1"
  local actualResult="$___expect___toEq_ActualResult"

  if [ "$EXPECT_NOT" = "true" ]
  then
    # Expect values NOT to be equal.
    #
    # If they are equal, show a failure message.
    if [ "$actualResult" = "$expectedResult" ]
    then
      expect.fail "Expected values not to equal\nActual: $actualResult\nNot Expected: $expectedResult"
    fi
  else
    # Expect values to be equal.
    #
    # If they are not equal, show a failure message.
    if [ "$actualResult" != "$expectedResult" ]
    then
      expect.fail "Expected values to equal\nActual: $actualResult\nExpected: $expectedResult"
    fi
  fi
}
```

**Reminder:** before trying this in your local shell, set `EXPECTATION_FAILED="return 1"`

Give it a shot!

To verify that `{ ... }` runs locally and `{{ ... }}` runs in a subshell, try changing a variable:

```sh
myFunction() {
  # change some variable in the command you run
  # will use this as an example, it will set x to the first argument provided
  x="$1"
  echo "Set x to $1"
}

x="hello"

echo "$x"
# hello

# This expectation will pass, but it runs in a subshell so it can't change variable values
expect {{ myFunction "this won't work" }} toEq "Set x to this won't work"

echo "$x"
# hello

# This expectation will pass and it runs locally so it can change variable values
expect {{ myFunction "haha I changed it" }} toEq "Set x to haha I changed it"

echo "$x"
# haha I changed it
```

## Customize block styles

The default supported block types are any number of `{` or `[` characters.

> Note: `expect` does not verify that the closing character is the same as the open character

In BASH you cannot/should not try to use any of these:

- `< ... >`
- `( ... )`
- `` ` ... ` ``
- `' ... '`
- `" ... "`

`expect` uses BASH regular expressions to determine when a block (a) starts (b) is closed

The default regular expressions are:

- Start: `^[\\[{]+\$`
- End: `^[\\]}]+\$`

You can change these by overriding the `EXPECT_BLOCK_START_PATTERN` and `EXPECT_BLOCK_END_PATTERN` variables.

To also support wrapping blocks in any number of `@` or `%` characters, add these symbols to the `[ ]+` group:

- Start: `^[\\[{@%]+\$`
- End: `^[\\]}@%]+\$`

You can test this in your shell:

```sh
EXPECT_BLOCK_START_PATTERN="^[\\[{@%]+\$"
EXPECT_BLOCK_END_PATTERN="^[\\]}@%]+\$"

expect.matcher.toTest() {
  echo "Hi from 'toTest' here is the $EXPECT_BLOCK_TYPE block:"
  echo "${EXPECT_BLOCK[@]}"
}

expect @ Cool I could use this syntax @ toTest
# Hi from 'toTest' here is the @ block:
# Cool I could use this syntax

expect %% Or I could use this %% toTest
# Hi from 'toTest' here is the %% block:
# Or I could use this
```

## Customize function names

By default, `expect` calls matcher functions in this format: `expect.matcher.[MATCHER_NAME]`

You can completely customize how `expect` finds functions by implementing your own matcher function.

To customize matcher invocation, define a function and set `EXPECT_MATCHER_FUNCTION=yourFunctionName`

```sh
EXPECT_MATCHER_FUNCTION=myExpectMatcherLookup

myExpectMatcherLookup() {
  echo "I should invoke a function which implements matcher: $EXPECT_MATCHER_NAME"
}

expect { hello world } toExecute OK
# I should invoke a function which implements matcher: toExecute
```

This adds complete flexibility, you could do anything.

You could use this to implement: `expect { ... } to be equalTo "something"`

Or you could invoke different functions based on whether a block was passed or a simple value.

You can do matcher lookup however best works for you.

## Supported `EXPECT` variables

| Variable Name              | Description                                                                 |
| -------------------------- | --------------------------------------------------------------------------- |
| EXPECT_VERSION             | Returns version of `expect`                                                 |
| EXPECT_MATCHER_NAME        | Name of matcher invoked, e.g. `toEq`                                        |
| EXPECT_NOT                 | Set to `"true"` when `not` precedes matcher                                 |
| EXPECT_ACTUAL_RESULT       | Contains actual result (_blank value if a block was provided_)              |
| EXPECT_BLOCK               | BASH Array containing block (_empty array if no block provided_)            |
| EXPECT_BLOCK_TYPE          | Opening block character used, e.g. `{` (_blank value is no block provided_) |
| EXPECT_BLOCK_END_PATTERN   | Custom BASH regex pattern for detecting block start                         |
| EXPECT_BLOCK_START_PATTERN | Custom BASH regex pattern for detecting block close                         |
| EXPECT_MATCHER_FUNCTION    | If provided, `expect` will invoke this instead of `expect.matcher.[name]`   |

---

# Provided Expectations

## `toEqual`

```sh
source "matchers/toEqual.sh"

# Assert content equals provided text ( uses `cat -A` to include non-visible characters )
expect 5 toEqual 5
expect 5 not toEqual 5

# Runs provided block an asserts content of STDOUT and STDERR combined (does not run in subshell)
expect { echo "Hello" } toEqual "Hello"
expect { echo "Hello" } not toEqual "Hello"

# Runs provided block an asserts content of STDOUT and STDERR combined (runs in subshell)
expect {{ echo "Hello" }} toEqual "Hello"
expect {{ echo "Hello" }} not toEqual "Hello"
```

## `toContain`

```sh
source "matchers/toContain.sh"

# Assert content contains provided text
expect "Hello, world!" toContain "Hello"
expect "Hello, world!" not toContain "Hello"

# Runs provided block an asserts content of STDOUT and STDERR combined (does not run in subshell)
expect { ls } toContain "myFile.txt"
expect { ls } not toEqual "myFile.txt"

# Runs provided block an asserts content of STDOUT and STDERR combined (runs in subshell)
expect {{ ls }} toContain "myFile.txt"
expect {{ ls }} not toEqual "myFile.txt"
```

## `toBeEmpty`

```sh
source "matchers/toBeEmpty.sh"

# Assert content is an empty string, e.g. [ -z "" ]
expect "" toBeEmpty
expect " " not toBeEmpty

# Runs provided block an asserts content of STDOUT and STDERR combined (does not run in subshell)
expect { cat somefile } toBeEmpty
expect { cat somefile } not toBeEmpty

# Runs provided block an asserts content of STDOUT and STDERR combined (runs in subshell)
expect {{ cat somefile }} toBeEmpty
expect {{ cat somefile }} not toBeEmpty
```

## `toMatch`

```sh
source "matchers/toMatch.sh"

# Assert content matches a provided BASH regex pattern, e.g. [[ "$x" =~ $pattern ]]
expect "Hello 1.2.3" toMatch '[0-9]\.[0-9]\.[0-9]$'
expect "Hello 1.2.3" not toMatch '[0-9]\.[0-9]\.[0-9]$'

# Runs provided block an asserts content of STDOUT and STDERR combined (does not run in subshell)
expect { cat version.txt } toMatch '[0-9]\.[0-9]\.[0-9]$'
expect { cat version.txt } not toMatch '[0-9]\.[0-9]\.[0-9]$'

# Runs provided block an asserts content of STDOUT and STDERR combined (runs in subshell)
expect {{ cat version.txt }} toMatch '[0-9]\.[0-9]\.[0-9]$'
expect {{ cat version.txt }} not toMatch '[0-9]\.[0-9]\.[0-9]$'
```

## `toOutput`

```sh
source "matchers/toOutput.sh"

# Requires { block } syntax

# Assert content is present in STDOUT or STDERR (combined)
expect { ls } toOutput "should contain this" "and also this"
expect { ls } not toOutput "should not contain this" "or this"

# Assert content is present in STDOUT (supports either toSTDOUT or toStdout)
expect { ls } toOutput toSTDOUT "should contain this" "and also this"
expect { ls } not toOutput toSTDOUT "should not contain this" "or this"

# Assert content is present in STDERR (supports either toSTDERR or toStderr)
expect { ls } toOutput toSTDERR "should contain this" "and also this"
expect { ls } not toOutput toSTDERR "should not contain this" "or this"

# Like other matchers, using {{ two braces }} runs the command in a subshell
expect {{ ls }} toOutput "should contain this" "and also this"
expect {{ ls }} not toOutput "should not contain this" "or this"
```

## `toFail`

```sh
source "matchers/toFail.sh"

# Requires { block } syntax

#
```
