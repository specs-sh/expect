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

> #### Usage Example
>
> ```sh
> local filename="file.txt"
>
> expect { ls } toContain "$filename"
> expect { cat "$filename" } not toBeEmpty
>
> rm "$filename"
>
> expect $? toEqual 0
>
> expect { ls } not toContain "$filename"
> ```

---

### Authoring Expectations

- [Expectations vs Assertions](#expectations-vs-assertions)
- [Write a matcher function](#writing-your-first)
- [Get the actual result](#writing-your-first)
- [Compare actual and expected results](#writing-your-first)
- [Exit on failure](#exiting-on-failure)
- [Customizing function names](#customizing-function-names)
- [Expected and Actual Values](#expected-and-actual-values)
- [Block Values](#block-values)
- [Customizing block styles](#customizing-block-styles)
- [Negating with 'not'](#negagting-with-not)

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

## Write a matcher function

Let's implement the following **`toEq`** "matcher function"

```sh
expect "$answer" toEq 42
```

First, try running the above code _without_ implementing the function:

- ```sh
  $ source "expect.sh"

  $ expect "$answer" toEq 42
  expect.matcher.toEq: command not found
  ```

You'll see an error: **`expect.matcher.toEq: command not found`**

By default, `expect` expects a function to exist named `expect.matcher.[MATCHER_NAME]`

The name of the matcher in this case is: `toEq`.

## Implement the Matcher Function

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

- ```
  $ source "expect.sh"

  $ expect "$answer" toEq 42
  toEq called with 1 arguments: 42
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
  > toEq called with 4 arguments: 42 another argument hello, world!
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

- ```
  $ source "expect.sh"

  $ answer="The result we want to verify equals 42"

  $ expect "$answer" toEq 42
  toEq called with 1 arguments: 42
  declare -- EXPECT_ACTUAL_RESULT="The result we want to verify equals 42"
  declare -a EXPECT_BLOCK=()
  declare -- EXPECT_BLOCK_END_PATTERN="^[\\]}]+\$"
  declare -- EXPECT_BLOCK_START_PATTERN="^[\\[{]+\$"
  declare -- EXPECT_BLOCK_TYPE=""
  declare -- EXPECT_MATCHER_NAME="toEq"
  declare -- EXPECT_NOT=""
  declare -- EXPECT_VERSION="0.2.0"
  ```

As you can see, there a number of `EXPECT_` variables available to the function.

The **"actual result"** is available in a variable named `EXPECT_ACTUAL_RESULT`:

- ```
  declare -- EXPECT_ACTUAL_RESULT="The result we want to verify equals 42"
  ```

## Compare actual and expected results

## Exit on failure

XXX

## Customizing function names

XXX

## Expected and Actual Values

XXX

## Block Values

XXX

## Customizing block styles

XXX

## Negating with 'not'

XXX

## Supported `EXPECT_` variables

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
