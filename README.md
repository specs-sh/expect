# 🧐 `expect.sh`

Flexible testing expectation library in [< 50 LOC](https://github.com/bx-sh/expect.sh/blob/master/expect.sh)

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
- [Negating with 'not'](#negagting-with-not)

#### Build-in Expectations
- [`toEqual`](#expect)
- [`toContain`](#expect)
- [`toBeEmpty`](#expect)
- [`toMatch`](#expect)
- [`toOutput`](#expect)
- [`toFail`](#expect)

----

## Authoring Expectations

### Expectations vs Assertions

XXX

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
