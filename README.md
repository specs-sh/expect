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

### `expect`

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

#### Authoring Expectations

- [Expectations vs Assertions](#expectations-vs-assertions)
- [Creating a function](#creating-a-function)
- [Exiting on failure](#exiting-on-failure)
- [Customizing function names](#customizing-function-names)
- [Expected and Actual Values](#expected-and-actual-values)
- [Block Values](#block-values)
- [Customizing block styles](#customizing-block-styles)
- [Negating with 'not'](#negagting-with-not)

#### Build-in Expectations

- [`toEqual`](#expect)
- [`toContain`](#expect)
- [`toBeEmpty`](#expect)
- [`toMatch`](#expect)
- [`toOutput`](#expect)
- [`toFail`](#expect)

---

## Authoring Expectations

> ```sh
> expect [ACTUAL_RESULT] [MATCHER_NAME] [arguments]
>
> # or
>
> expect { [BLOCK] } [MATCHER_NAME] [arguments]
> ```

---

### Expectations vs Assertions

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

### Creating a function

XXX

### Exiting on failure

XXX

### Customizing function names

XXX

### Expected and Actual Values

XXX

### Block Values

XXX

### Customizing block styles

XXX

### Negating with 'not'

XXX

---

## Built-in Expectations

### `toEqual`

XXX

```sh
source "matchers/toEqual.sh"

#
```

### `toContain`

XXX

```sh
source "matchers/toContain.sh"

#
```

### `toBeEmpty`

XXX

```sh
source "matchers/toBeEmpty.sh"

#
```

### `toMatch`

XXX

```sh
source "matchers/toMatch.sh"

#
```

### `toOutput`

XXX

```sh
source "matchers/toOutput.sh"

#
```

### `toFail`

XXX

```sh
source "matchers/toFail.sh"

#
```

### `toBeEmpty`

XXX

```sh
source "matchers/toBeEmpty.sh"

#
```
