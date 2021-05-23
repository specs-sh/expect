


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
> expect { ls dir } to fail with exitcode = 2 \
>                   with stdout containing "No such file or directory"
> ```

**`assertThat`-style Assertions**

> ```sh
> assertThat { ls dir } fails with exitcode = 2 \
>                       and stdout contains "No such file or directory"
> ```


**`should`-style Assertions**

> ```sh
> :{ ls dir } should fail with exitcode = 2 \
>              and stdout containing "No such file or directory"
> ```


---

The `Expect` library brings all of these lovely assertions styles that you love to BASH! 💖

All running on top of the same core code which provides **_lovely_ assertion failure messages**.

<script src="https://kit.fontawesome.com/319dabc23d.js" crossorigin="anonymous"></script>

## 📖 Documentation

- [⬇️ Download / Install](#)
- [<i class="fad fa-terminal"></i> Getting Started](#)
  - [Classic-style Assertions](#)
  - [BASH-style Assertions](#)
  - [`expect` Assertions](#)
  - [`assertThat` Assertions](#)
  - [`should` Assertions](#)
- [⚗️ Filters](#)
  - **Text**
    - [`split`](#) [`uppercase`](#) [`lowercase`](#) [`array`](#) [`file`](#) [`path`](#) [`directory`](#)
  - **Collections**
    - [`first`](#) [`last`](#) [`join`](#)
  - **Command**
    - [`exitcode`](#) [`output`](#) [`stdout`](#) [`stderr`](#)
  - **Custom**
    - [Implementing Custom Filters](#)
- [⚛️ Matchers](#)
  - **Common**
    - [`equals`](#) [`empty`](#) [`length`](#) [`contain`](#) [`include`](#)
  - **Text**
    - [`startWith`](#) [`endWith`](#)
  - **Command**
    - [`fails`](#) [`succeeds`](#)
  - **Files and Directories**
    - [`exists`](#) [`readable`](#) [`writeable`](#) [`executable`](#) [`newerThan`](#) [`olderThan`](#) [`pipe`](#) [`socket`](#) [`symlink`](#)

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

## <i class="fad fa-terminal"></i> Getting Started

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
  <summary><h4>Array</h4></summary>

...
</details>

<details>
  <summary><h4>First</h4></summary>

...
</details>

<details>
  <summary><h4>Last</h4></summary>

...
</details>

<details>
  <summary><h4>Split</h4></summary>

...
</details>

<details>
  <summary><h4>Join</h4></summary>

...
</details>

<details>
  <summary><h4>Lowercase</h4></summary>

...
</details>

<details>
  <summary><h4>Uppercase</h4></summary>

...
</details>

<details>
  <summary><h4>Exitcode</h4></summary>

...
</details>

<details>
  <summary><h4>Output</h4></summary>

...
</details>

<details>
  <summary><h4>Standard Output</h4></summary>

...
</details>

<details>
  <summary><h4>Standard Error</h4></summary>

...
</details>

## ⚛️ Matchers

Click or tap one of the options below for description and examples:

### Common Matchers (_Text or Collections_)

<details>
  <summary><h4>Equals</h4></summary>

...
</details>

<details>
  <summary><h4>Empty</h4></summary>

...
</details>

<details>
  <summary><h4>Length</h4></summary>

...
</details>

<details>
  <summary><h4>Contains &nbsp;<em>(allows <code>*</code> wildcards)</em></h4></summary>

...
</details>

<details>
  <summary><h4>Includes &nbsp;<em>(exact values)</em></h4></summary>

...
</details>

### Text Matchers

<details>
  <summary><h4>Starts With</h4></summary>

...
</details>

<details>
  <summary><h4>Ends With</h4></summary>

...
</details>

### Command Matchers

<details>
  <summary><h4>Command Fails</h4></summary>

...
</details>

<details>
  <summary><h4>Command Succeeds</h4></summary>

...
</details>

### File / Directory Matchers

<details>
  <summary><h4>Path Exists</h4></summary>

...
</details>

<details>
  <summary><h4>Directory Exists</h4></summary>

...
</details>

<details>
  <summary><h4>File Exists</h4></summary>

...
</details>

<details>
  <summary><h4>File Is Empty</h4></summary>

...
</details>

<details>
  <summary><h4>File Is Readable</h4></summary>

...
</details>

<details>
  <summary><h4>File Is Writeable</h4></summary>

...
</details>

<details>
  <summary><h4>File Is Executable</h4></summary>

...
</details>

<details>
  <summary><h4>File Is Newer Than</h4></summary>

...
</details>

<details>
  <summary><h4>File Is Older Than</h4></summary>

...
</details>

<details>
  <summary><h4>File Is Pipe</h4></summary>

...
</details>

<details>
  <summary><h4>File Is Socket</h4></summary>

...
</details>

<details>
  <summary><h4>File Paths Are Equal</h4></summary>

...
</details>

<details>
  <summary><h4>Path Is Symbolic Link</h4></summary>

...
</details>

## <i class="fad fa-flask-potion"></i> Custom Matchers

A matcher is merely a function which returns zero on success or non-zero on failure.

```sh
TODO
```

### Changing Assertion Target with Function