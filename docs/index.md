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
> {{ ls dir }} should fail with exitcode = 2 \
>              and stdout containing "No such file or directory"
> ```
{% endraw %}

---

The `Expect` library brings all of these lovely assertions styles that you love to BASH! 💖

All running on top of the same core code which provides **_lovely_ assertion failure messages**.

<script src="https://kit.fontawesome.com/319dabc23d.js" crossorigin="anonymous"></script>

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
> » should.sh     - {: ls } should contain "should.sh"
> 
> To get started, source any of the provided files in your tests.
> 
> Visit https://expect.specs.sh for documentation
> ```

## <i class="fad fa-terminal"></i> Getting Started

Click or tap on one of the options below for documentation:

<details>
  <summary><h3>Assertions (e.g. <code>assertEquals</code>)</h3></summary>

First, `source` the `assertions.sh`:

```sh
source assertions.sh
```

Now try making an assertion!

```sh
assertEquals "World" "Hello"
# Expected results to equal
# Actual: 'Hello'
# Expected: 'World'
```

> Note: the `assertions.sh` library contains multiple assertion functions.  
> See [<i class="fad fa-atom-alt"></i> Available Matchers](#-available-matchers) below for a reference of the available functions.
<br>
</details>

<details>
  <summary><h3>AssertThat</h3></summary>

First, `source` the `assertThat.sh`:

```sh
source assertThat.sh
```

Now try making an assertion!

```sh
assertThat "Hello" equals "World"
# Expected results to equal
# Actual: 'Hello'
# Expected: 'World'
```

{% raw %}

### Matchers

Matchers may be freely preceded by any of these (_ignored_) terms:

- `a` `be` `to` `and` `does` `have` `with` `should`

```sh
assertThat { ls } does contain "README"
```

## `not`

To negate an assertion, use `not`:

```sh
assertThat { ls } does not contain "README"
# Expected text not to contain subtext
# Actual: 'LICENSE README docs'
# Not Expected: 'README'
```

### Multiple Assertions (_aka 'fluent assertions'_)

Multiple assertions may be freely chained together:

```sh
assertThat { ls } contains "README" and contains "LICENSE"
```

## `{ }` vs `{{ }}`

### `{ command arg }`

To run a command and assert on its output, use `{ command }`:

```sh
assertThat { ls } contains "README"
```

> Note: this runs the command _in the same shell_.  
> Functions run in this way _can_ modify `local` variables.  
> Any number of arguments may be provided, e.g. `{ cmd arg1 arg2 }`

### `{{ command arg }}`

To run a command _in a subshell_ and assert on its output, use `{{ command }}`:

```sh
assertThat {{ ls }} contains "README"
```

> Note: this is the equivalent to running `"$( ls )"` within `"$( ... )"`  
> Any number of arguments may be provided, e.g. `{{ cmd arg1 arg2 }}`
{% endraw %}

<br>
</details>

<details>
  <summary><h3>Brackets (e.g. <code>[: "Hello" = "World" ]</code>)</h3></summary>

First, `source` the `assertThat.sh`:

```sh
source brackets.sh
```

Now try making an assertion!

```sh
[: "Hello" = "World" ]
# Expected results to equal
# Actual: 'Hello'
# Expected: 'World'
```

## `[: ]` vs `[[: ]]`

The goal of `brackets.sh` is to support _nearly_ the same syntax as BASH's `[` and `[[`.

### `[: x = y ]`

To assert equality, use `[: x = y ]`

### `[: 1 -gt 0 ]`

To perform assertions on numeric values, use `[: 1 -gt 0 ]`

> Note: All standard BASH operators are supported: `-eq -ne -gt -gt -lt -le`  
> This is the preferred way or comparing numeric values, no equivalent of `(( ))` is provided.

### `[[: "$text" = "$pattern" ]]`

To perform a pattern matching assertion, use: `[[: "$text" = "*pattern*" ]]`

> Note: Unlike native BASH, you _must_ quote your pattern.  
> Pattern matching elements (`*`) will be expanded and matching performed.

### `[[: "$text" =~ 'regular expression' ]]`

To match against a BASH regular expression, use `[[: "$text" =~ 'pattern' ]]`

> Note: Unlike native BASH, you _must_ quote your pattern.  

<br>
</details>


<details>
  <summary><h3>Expect</h3></summary>

First, `source` the `expect.sh`:

```sh
source expect.sh
```

Now try making an assertion!

```sh
expect "Hello" to equal "World"
# Expected results to equal
# Actual: 'Hello'
# Expected: 'World'
```

{% raw %}

### Matchers

Matchers may be freely preceded by any of these (_ignored_) terms:

- `a` `be` `to` `and` `does` `have` `with` `should`

```sh
expect { ls } to contain "README"
```

## `not`

To negate an assertion, use `not`:

```sh
expect { ls } not to contain "README"
# Expected text not to contain subtext
# Actual: 'LICENSE README docs'
# Not Expected: 'README'
```

### Multiple Assertions (_aka 'fluent assertions'_)

Multiple assertions may be freely chained together:

```sh
expect { ls } to contain "README" and contain "LICENSE"
```
## `{ }` vs `{{ }}`

### `{ command arg }`

To run a command and assert on its output, use `{ command }`:

```sh
expect { ls } to contain "README"
```

> Note: this runs the command _in the same shell_.  
> Functions run in this way _can_ modify `local` variables.  
> Any number of arguments may be provided, e.g. `{ cmd arg1 arg2 }`

### `{{ command arg }}`

To run a command _in a subshell_ and assert on its output, use `{{ command }}`:

```sh
expect {{ ls }} to contain "README"
```

> Note: this is the equivalent to running `"$( ls )"` within `"$( ... )"`  
> Any number of arguments may be provided, e.g. `{{ cmd arg1 arg2 }}`
{% endraw %}

<br>
</details>


<details>
  <summary><h3>Should</h3></summary>

First, `source` the `should.sh`:

```sh
source should.sh
```

Now try making an assertion!

{% raw %}
```sh
{{ "Hello" }} should equal "World"
# Expected results to equal
# Actual: 'Hello'
# Expected: 'World'
```
### Matchers

Matchers may be freely preceded by any of these (_ignored_) terms:

- `a` `be` `to` `and` `does` `have` `with` `should`

```sh
{: ls } should contain "README"
```

## `not`

To negate an assertion, use `not`:

```sh
{: ls } should not contain "README"
# Expected text not to contain subtext
# Actual: 'LICENSE README docs'
# Not Expected: 'README'
```

### Multiple Assertions (_aka 'fluent assertions'_)

Multiple assertions may be freely chained together:

```sh
{: ls } should contain "README" and contain "LICENSE"
```

## `{{ }}` vs `{: }` vs `{{: }}`

### `{{ value }}`

To assert on a value, use `{{ value }}`:

```sh
{{ "$myVariable" }} should eq "Hello, world!"
```

### `{{ value value }}`

To assert on a list of values, use `{{ value value }}`:

```sh
{{ "$@" }} should contain "--help"
{{ a b c }} should contain "a"
```

> Note: this is a feature unique to `should`

### `{: command arg }`

To run a command and assert on its output, use `{: command }`:

```sh
{: ls } should contain "README"
```

> Note: this runs the command _in the same shell_.  
> Functions run in this way _can_ modify `local` variables.  
> Any number of arguments may be provided, e.g. `{: cmd arg1 arg2 }`

### `{{: command arg }}`

To run a command _in a subshell_ and assert on its output, use `{{: command }}`:

```sh
{{: ls }} should contain "README"
```

> Note: this is the equivalent to running `"$( ls )"` within `"$( ... )"`  
> Any number of arguments may be provided, e.g. `{{: cmd arg1 arg2 }}`

{% endraw %}

<br>
</details>

## <i class="fad fa-atom-alt"></i> Matchers

Click or tap one of the options below for description and examples:

### Text Matchers

<details>
  <summary><h4>Empty</h4></summary>

...
</details>

<details>
  <summary><h4>Length</h4></summary>

...
</details>

<details>
  <summary><h4>Equals</h4></summary>

...
</details>

<details>
  <summary><h4>Contains</h4></summary>

...
</details>

<details>
  <summary><h4>Matches</h4></summary>

...
</details>

<details>
  <summary><h4>Starts With</h4></summary>

...
</details>

<details>
  <summary><h4>Ends With</h4></summary>

...
</details>

<details>
  <summary><h4>Has Substring</h4></summary>

...
</details>

### Array Matchers

<details>
  <summary><h4>Empty</h4></summary>

...
</details>

<details>
  <summary><h4>Size</h4></summary>

...
</details>

<details>
  <summary><h4>Equals</h4></summary>

...
</details>

<details>
  <summary><h4>Contains</h4></summary>

...
</details>

<details>
  <summary><h4>One Match</h4></summary>

...
</details>

<details>
  <summary><h4>All Match</h4></summary>

...
</details>

### Command Matchers

<details>
  <summary><h4>Exit Code</h4></summary>

...
</details>

<details>
  <summary><h4>Passes</h4></summary>

...
</details>

<details>
  <summary><h4>Fails</h4></summary>

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

### File / Directory Matchers

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
  <summary><h4>Path (File or Directory) Exists</h4></summary>

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