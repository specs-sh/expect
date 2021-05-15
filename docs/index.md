---
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

Based on which programming language you prefer, you may have a favorite syntax for testing.

_Choose your own **preferred** syntax for test assertions:_

> ```sh
> output="$( ls dir 2>&1 )" # Example of a command that fails
> exitcode=$?
> ```

**Classic Assertions**

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
> assertThat { ls dir } fails with exitcode = 2
>                       and stdout contains "No such file or directory"
> ```

**`should`-style Assertions**

> ```sh
> {{ ls dir }} should fail with exitcode = 2
>              and stdout contains "No such file or directory"
> ```

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
> » assertThat.sh - assertThat { ls } output contains "assertThat.sh"
> » assertions.sh - assertContains "assertions.sh" "$( ls )"
> » brackets.sh   - [[: "$( ls )" = "*brackets.sh*" ]]
> » expect.sh     - expect { ls } output to contain "expect.sh"
> » should.sh     - {: ls } output should contain "should.sh"
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

## <i class="fad fa-atom-alt"></i> Available Matchers

Click or tap one of the options below for description and examples:

### Text Matchers

<details>
  <summary><h3>Empty</h3></summary>

...
</details>

<details>
  <summary><h3>Length</h3></summary>

...
</details>

<details>
  <summary><h3>Equals</h3></summary>

...
</details>

<details>
  <summary><h3>Contains</h3></summary>

...
</details>

<details>
  <summary><h3>Matches</h3></summary>

...
</details>

### Array Matchers

<details>
  <summary><h3>Empty</h3></summary>

...
</details>

<details>
  <summary><h3>Size</h3></summary>

...
</details>

<details>
  <summary><h3>Equals</h3></summary>

...
</details>

<details>
  <summary><h3>Contains</h3></summary>

...
</details>

<details>
  <summary><h3>One Match</h3></summary>

...
</details>

<details>
  <summary><h3>All Match</h3></summary>

...
</details>

### Command Matchers

<details>
  <summary><h3>Exit Code</h3></summary>

...
</details>

<details>
  <summary><h3>Passes</h3></summary>

...
</details>

<details>
  <summary><h3>Fails</h3></summary>

...
</details>

<details>
  <summary><h3>Output</h3></summary>

...
</details>

<details>
  <summary><h3>Standard Output</h3></summary>

...
</details>

<details>
  <summary><h3>Standard Error</h3></summary>

...
</details>

## <i class="fad fa-flask-potion"></i> Custom Matchers
