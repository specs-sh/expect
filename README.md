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

To see how to support the `not` case, print out the `EXPECT` variables again:

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

## Block values

XXX

## Customize block styles

XXX

## Customize function names

XXX

## Supported `EXPECT` variables

xxx document all of them in a table with small heading for each one too xxx

---

# Provided Expectations

## `toEqual`

XXX

```sh
source "matchers/toEqual.sh"

#
```

## `toContain`

XXX

```sh
source "matchers/toContain.sh"

#
```

## `toBeEmpty`

XXX

```sh
source "matchers/toBeEmpty.sh"

#
```

## `toMatch`

XXX

```sh
source "matchers/toMatch.sh"

#
```

## `toOutput`

XXX

```sh
source "matchers/toOutput.sh"

#
```

## `toFail`

XXX

```sh
source "matchers/toFail.sh"

#
```

## `toBeEmpty`

XXX

```sh
source "matchers/toBeEmpty.sh"

#
```
