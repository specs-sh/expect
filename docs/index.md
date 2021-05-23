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
> expect { ls dir } to fail with exitcode = 2 \
>                   with stdout containing "No such file or directory"
> ```

**`assertThat`-style Assertions**

> ```sh
> assertThat { ls dir } fails with exitcode = 2 \
>                       and stdout contains "No such file or directory"
> ```

{% raw %}
**`should`-style Assertions**

> ```sh
> :{ ls dir } should fail with exitcode = 2 \
>              and stdout containing "No such file or directory"
> ```
{% endraw %}

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
</details>

<details>
  <summary>First</summary>

...
</details>

<details>
  <summary>Last</summary>

...
</details>

<details>
  <summary>Split</summary>

...
</details>

<details>
  <summary>Join</summary>

...
</details>

<details>
  <summary>Lowercase</summary>

...
</details>

<details>
  <summary>Uppercase</summary>

...
</details>

<details>
  <summary>Exitcode</summary>

...
</details>

<details>
  <summary>Output</summary>

...
</details>

<details>
  <summary>Standard Output</summary>

...
</details>

<details>
  <summary>Standard Error</summary>

...
</details>

## <i class="fad fa-atom-alt"></i> Matchers

Click or tap one of the options below for description and examples:

### Common Matchers (_Text or Collections_)

<details>
  <summary>Equals</summary>

...
</details>

<details>
  <summary>Empty</summary>

...
</details>

<details>
  <summary>Length</summary>

...
</details>

<details>
  <summary>Contains &nbsp;<em>(allows <code>*</code> wildcards)</em></summary>

...
</details>

<details>
  <summary>Includes &nbsp;<em>(exact values)</em></summary>

...
</details>

### Text Matchers

<details>
  <summary>Starts With</summary>

...
</details>

<details>
  <summary>Ends With</summary>

...
</details>

### Command Matchers

<details>
  <summary>Command Fails</summary>

...
</details>

<details>
  <summary>Command Succeeds</summary>

...
</details>

### File / Directory Matchers

<details>
  <summary>Path Exists</summary>

...
</details>

<details>
  <summary>Directory Exists</summary>

...
</details>

<details>
  <summary>File Exists</summary>

...
</details>

<details>
  <summary>File Is Empty</summary>

...
</details>

<details>
  <summary>File Is Readable</summary>

...
</details>

<details>
  <summary>File Is Writeable</summary>

...
</details>

<details>
  <summary>File Is Executable</summary>

...
</details>

<details>
  <summary>File Is Newer Than</summary>

...
</details>

<details>
  <summary>File Is Older Than</summary>

...
</details>

<details>
  <summary>File Is Pipe</summary>

...
</details>

<details>
  <summary>File Is Socket</summary>

...
</details>

<details>
  <summary>File Paths Are Equal</summary>

...
</details>

<details>
  <summary>Path Is Symbolic Link</summary>

...
</details>

## <i class="fad fa-flask-potion"></i> Custom Matchers

A matcher is merely a function which returns zero on success or non-zero on failure.

```sh
TODO
```

### Changing Assertion Target with Function