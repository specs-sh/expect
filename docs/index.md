---
---

{% raw %}

# 🧐 `Expect`

> _Modern assertions for Shell Scripting in the 2020s_

---

Download the [latest version](https://github.com/specs-sh/expect/archive/v2.0.0.tar.gz) or install via:

```
curl -o- https://expect.specs.sh/install.sh | bash
```

---

# Expectations for Everyone

{% endraw %}

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

{% raw %}
**`should`-style Assertions**

> ```sh
> :{ ls dir } should fail with exitcode = 2  \
>             and stdout containing "No such file or directory"
> ```
>
> {% endraw %}

---

The `Expect` library brings all of these lovely assertions styles that you love to BASH! 💖

All running on top of the same core code which provides **_lovely_ assertion failure messages**.

<script src="https://kit.fontawesome.com/319dabc23d.js" crossorigin="anonymous"></script>

## <i class="fad fa-books"></i> Documentation

- [<i class="fad fa-download"></i> Download / Install](#)
- [<i class="fad fa-terminal"></i> Getting Started](#)
  - [Classic-style Assertions](#)
  - [BASH-style Assertions](#)
  - [`expect` Assertions](#)
  - [`assertThat` Assertions](#)
  - [`should` Assertions](#)
- [<i class="fad fa-flask"></i> Filters](#)
  - **Text**
    - [`split`](#) [`uppercase`](#) [`lowercase`](#) [`array`](#) [`file`](#) [`path`](#) [`directory`](#)
  - **Collections**
    - [`first`](#) [`last`](#) [`join`](#)
  - **Command**
    - [`exitcode`](#) [`output`](#) [`stdout`](#) [`stderr`](#)
  - **Custom**
    - [Implementing Custom Filters](#)
- [<i class="fad fa-atom-alt"></i> Matchers](#)
  - **Common**
    - [`equals`](#) [`empty`](#) [`length`](#) [`contain`](#) [`include`](#)
  - **Text**
    - [`startWith`](#) [`endWith`](#)
  - **Command**
    - [`fails`](#) [`succeeds`](#)
  - **Files and Directories**
    - [`exists`](#) [`readable`](#) [`writeable`](#) [`executable`](#) [`newerThan`](#) [`olderThan`](#) [`pipe`](#) [`socket`](#) [`symlink`](#)

## <i class="fad fa-download"></i> Download / Install

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

## <i class="fad fa-terminal"></i> Getting Started

## <i class="fad fa-flask"></i> Filters

`Expect` provides a number of built-in helper functions to allow expectations such as:

{% raw %}

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

{% endraw %}

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

## <i class="fad fa-atom-alt"></i> Matchers

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
