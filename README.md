



# 🚧 Under Construction

> Check back soon for the first release of `Expect` `v2`

---

# 🧐 `Expect`

> _Modern assertions for Shell Scripting in the 2020s_

---

Download the [latest version](https://github.com/specs-sh/expect/archive/v2.0.0.tar.gz) or install via:

```
curl -o- https://expect.specs.sh/install.sh | bash
```

---

# Expectations for Everyone



_Choose your own **preferred** syntax for test assertions:_

> ```sh
> output="$( ls dir 2>&1 )" # Example of a command that fails
> exitcode=$?
> ```

**Classic-style Assertions**

> ```sh
> assertEquals 2 $exitcode
> assertContains "No such file or directory" "$output"
> ```

**BASH-style Assertions**

> ```sh
> [: $exitcode -eq 2 ]
> [[: "$output" = "*No such file or directory*" ]]
> ```

**`expect`-style Assertions**

> ```sh
> expect { ls dir } to fail with exitcode = 2  \
>                   and stdout containing "No such file or directory"
> ```

**`assertThat`-style Assertions**

> ```sh
> assertThat { ls dir } fails with exitcode = 2  \
>                       and stdout contains "No such file or directory"
> ```


**`should`-style Assertions**

> ```sh
> :{ ls dir } should fail with exitcode = 2  \
>             and stdout containing "No such file or directory"
> ```
>
> 

---

The `Expect` library brings all of these lovely assertions styles that you love to BASH! 💖

All running on top of the same core code which provides **_lovely_ assertion failure messages**.



## 📖 Documentation

- [⬇️ Download / Install](#)
- [💻 Getting Started](#)
  - [Classic-style Assertions](#)
  - [BASH-style Assertions](#)
  - [`expect` Assertions](#)
  - [`assertThat` Assertions](#)
  - [`should` Assertions](#)
- [⚗️ Filters](#)
  - **Debugging**
    - [`print`](#)
  - **Common**
    - [`inspect`](#) [`size`](#)
  - **Text**
    - [`split`](#) [`uppercase`](#) [`lowercase`](#) [`lines`](#) [`chars`](#)
  - **Collections**
    - [`first`](#) [`last`](#) [`join`](#) [`map`](#)
  - **Integer / Number**
    - [`+`](#) [`-`](#) [`/`](#) [`x`](#) [`bc`](#)
  - **Command**
    - [`exitcode`](#) [`output`](#) [`stdout`](#) [`stderr`](#)
  - **Conversion**
    - [`array`](#) [`text`](#) [`integer`](#) [`number`](#) [`file`](#) [`path`](#) [`directory`](#)
  - **Custom**
    - [Implementing Custom Filters](#)
- [⚛️ Matchers](#)
  - **Common**
    - [`equal`](#) [`empty`](#) [`length`](#) [`contain`](#) [`containAll`](#) [`containPattern`](#) [`include`](#) [`includeAll`](#) [`truthy`](#) [`falsy`](#)
  - **Text**
    - [`match`](#) [`startWith`](#) [`endWith`](#) [`greaterThan`](#) [`greaterThanOrEqualTo`](#) [`lessThan`](#) [`lessThanOrEqualTo`](#)
  - **Command**
    - [`fails`](#) [`succeeds`](#)
  - **Files and Directories**
    - [`exist`](#) [`readable`](#) [`writeable`](#) [`executable`](#) [`newerThan`](#) [`olderThan`](#) [`pipe`](#) [`socket`](#) [`symlink`](#)
  - **Custom**
    - [Implementing Custom Matchers](#)

## ⬇️ Download / Install

Download the [latest version](https://github.com/specs-sh/expect/archive/v2.0.0.tar.gz) or install via:

```
curl -o- https://expect.specs.sh/install.sh | bash
```

**Output**

> ```sh
> Expect 2.0.0 successfully installed
>
> 🧐 Downloaded files (and example syntax)
>
> » assertThat.sh - assertThat { ls } contains "assertThat.sh"
> » assertions.sh - assertContains "assertions.sh" "$( ls )"
> » brackets.sh   - [[: "$( ls )" = "*brackets.sh*" ]]
> » expect.sh     - expect { ls } to contain "expect.sh"
> » should.sh     - :{ ls } should contain "should.sh"
>
> To get started, source any of the provided files in your tests.
>
> Visit https://expect.specs.sh for documentation
> ```

## 💻 Getting Started

## ⚗️ Filters

`Expect` provides a number of built-in helper functions to allow expectations such as:



```sh
# Get the first line in a string
expect { cat README } lines first to contain "Hello"

# Split a string into a list using a separator
{{ "Hello, world!" }} uppercase split " " first should equal "HELLO,"

# Join a string from a list using
assertThat [ Hello World ] join ":" equals "Hello:World"

# Work with array variables
items=( A B C )
expect items array last to equal "C"
```



### Built-in Helpers

Click or tap one of the options below for description and examples:

<details>
  <summary>Array</summary>

...
hello

</details>

<details>
  <summary>Array</summary>

...
hello

</details>

## ⚛️ Matchers

Click or tap one of the options below for description and examples:

<details>
  <summary>Array</summary>

...
hello

</details>

<details>
  <summary>Array</summary>

...
hello

</details>
