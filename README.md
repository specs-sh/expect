[![Mac (BASH 3.2)](https://github.com/bx-sh/expect.sh/workflows/Mac%20(BASH%203.2)/badge.svg)](https://github.com/bx-sh/expect.sh/actions?query=workflow%3A%22Mac+%28BASH+3.2%29%22) [![BASH 4.4](https://github.com/bx-sh/expect.sh/workflows/BASH%204.4/badge.svg)](https://github.com/bx-sh/expect.sh/actions?query=workflow%3A%22BASH+4.4%22) [![BASH 5.0](https://github.com/bx-sh/expect.sh/workflows/BASH%205.0/badge.svg)](https://github.com/bx-sh/expect.sh/actions?query=workflow%3A%22BASH+5.0%22)


# 🧐 `expect.sh`

```sh
expect { BASH testing } toBe "wonderful"
```

---

Download the [latest release](https://github.com/bx-sh/expect.sh/archive/v0.2.3.tar.gz)

```sh
source "expect.sh"
```

---

`expect.sh` is a flexible test expectation library (_written in [< 50 LOC](https://github.com/bx-sh/expect.sh/blob/master/expect.sh)_)


```sh
expect { ls } not toContain "$filename"

writeFile "$filename"
expect $? toEqual 0

expect { ls } toContain "$filename"
```

## Basic Syntax

The provided matchers that come with `expect.sh` use these conventions:

If no `{ ... }` block is provided, the first argument is the "actual result"

```sh
expect "$( ls )" toContain "filename"
```

If `{ ... }` block is provided, the code inside is evaluated (_without a subshell_)

```sh
expect { ls } toContain "filename"
```

If `{{ ... }}` block is provided, the code inside is evaluated (_in a subshell_)

```sh
expect {{ ls } toContain "filename"
```

---

## Authoring Expectations

_Every project is different, you should author your own expectations!_

If you have a common set of assertions which you perform in your tests

```sh
checkIfConfigIsValid() {
  local configFile="$1"
  [ -f "$configFile" ] || { echo "Not found" >&2; return 1; }
  lint "$configFile"   || { echo "Invalid"   >&2; return 1  }
}

testOne() {
  local config="$( config --new )"
  checkIfConfigFileIsValid "$config"
}
```

You might want to consider authoring your own expectation(s) for your tests

```sh
testOne() {
  local config="$( config --new )"
  expect "$config" toBeValidConfig
}
```

For details, see the 🎓 [Authoring Expectations Tutorial](AUTHORING)

---

## Provided Expectations

## `toEqual`

> ([source code](https://github.com/bx-sh/expect.sh/blob/master/matchers/toEqual.sh))

```sh
source "matchers/toEqual.sh"

# Assert content equals provided text ( uses `cat -vet` to include non-visible characters )
expect 5 toEqual 5
expect 5 not toEqual 5

# Runs provided block an asserts content of STDOUT and STDERR combined (does not run in subshell)
expect { echo "Hello" } toEqual "Hello"
expect { echo "Hello" } not toEqual "Hello"

# Runs provided block an asserts content of STDOUT and STDERR combined (runs in subshell)
expect {{ echo "Hello" }} toEqual "Hello"
expect {{ echo "Hello" }} not toEqual "Hello"
```

## `toContain`

> ([source code](https://github.com/bx-sh/expect.sh/blob/master/matchers/toContain.sh))

```sh
source "matchers/toContain.sh"

# Assert content contains all of the provided texts
expect "Hello, world!" toContain "Hello" "world"
expect "Hello, world!" not toContain "Hello" "world"

# Runs provided block an asserts content of STDOUT and STDERR combined (does not run in subshell)
expect { ls } toContain "myFile.txt" "anotherFile.png"
expect { ls } not toEqual "myFile.txt" "anotherFile.png"

# Runs provided block an asserts content of STDOUT and STDERR combined (runs in subshell)
expect {{ ls }} toContain "myFile.txt" "anotherFile.png"
expect {{ ls }} not toEqual "myFile.txt" "anotherFile.png"
```

## `toBeEmpty`

> ([source code](https://github.com/bx-sh/expect.sh/blob/master/matchers/toBeEmpty.sh))

```sh
source "matchers/toBeEmpty.sh"

# Assert content is an empty string, e.g. [ -z "" ]
expect "" toBeEmpty
expect " " not toBeEmpty

# Runs provided block an asserts content of STDOUT and STDERR combined (does not run in subshell)
expect { cat somefile } toBeEmpty
expect { cat somefile } not toBeEmpty

# Runs provided block an asserts content of STDOUT and STDERR combined (runs in subshell)
expect {{ cat somefile }} toBeEmpty
expect {{ cat somefile }} not toBeEmpty
```

## `toMatch`

> ([source code](https://github.com/bx-sh/expect.sh/blob/master/matchers/toMatch.sh))

```sh
source "matchers/toMatch.sh"

# Assert content matches a provided BASH regex pattern, e.g. [[ "$x" =~ $pattern ]]
expect "Hello 1.2.3" toMatch '[0-9]\.[0-9]\.[0-9]$'
expect "Hello 1.2.3" not toMatch '[0-9]\.[0-9]\.[0-9]$'

# Runs provided block an asserts content of STDOUT and STDERR combined (does not run in subshell)
expect { cat version.txt } toMatch '[0-9]\.[0-9]\.[0-9]$'
expect { cat version.txt } not toMatch '[0-9]\.[0-9]\.[0-9]$'

# Runs provided block an asserts content of STDOUT and STDERR combined (runs in subshell)
expect {{ cat version.txt }} toMatch '[0-9]\.[0-9]\.[0-9]$'
expect {{ cat version.txt }} not toMatch '[0-9]\.[0-9]\.[0-9]$'
```

## `toOutput`

> ([source code](https://github.com/bx-sh/expect.sh/blob/master/matchers/toOutput.sh))

```sh
source "matchers/toOutput.sh"

# Requires { block } syntax

# Assert content is present in STDOUT or STDERR (combined)
expect { ls } toOutput "should contain this" "and also this"
expect { ls } not toOutput "should not contain this" "or this"

# Assert content is present in STDOUT (supports either toSTDOUT or toStdout)
expect { ls } toOutput toSTDOUT "should contain this" "and also this"
expect { ls } not toOutput toSTDOUT "should not contain this" "or this"

# Assert content is present in STDERR (supports either toSTDERR or toStderr)
expect { ls } toOutput toSTDERR "should contain this" "and also this"
expect { ls } not toOutput toSTDERR "should not contain this" "or this"

# Like other matchers, using {{ two braces }} runs the command in a subshell
expect {{ ls }} toOutput "should contain this" "and also this"
expect {{ ls }} not toOutput "should not contain this" "or this"
```

## `toFail`

> ([source code](https://github.com/bx-sh/expect.sh/blob/master/matchers/toFail.sh))

```sh
source "matchers/toFail.sh"

# Requires { block } syntax

# Assert that the provided command fails
expect { grep pattern file.txt } toFail

# Assert that the provided command does not fail
expect { grep pattern file.txt } not toFail

# Assert that the provided command with STDERR containing the provided text
expect { grep pattern file.txt } toFail "with this in STDERR" "and this"

# Assert that the provided command does not fail and the STDERR does not contain the provided text
expect { grep pattern file.txt } not toFail "and STDERR shouldn't contain this" "or this"

# Like other matchers, using {{ two braces }} runs the command in a subshell
expect {{ grep pattern file.txt }} toFail
expect {{ grep pattern file.txt }} not toFail
expect {{ grep pattern file.txt }} toFail "with this in STDERR" "and this"
expect {{ grep pattern file.txt }} not toFail "and STDERR shouldn't contain this" "or this"
```

---

## Related Projects

 - 🧐 [`assert.sh`](https://assert.sh) for `assert [ 1 -eq 42 ]` style assertions
 - 🚀 [`run-command.sh`](https://run-command.pages.sh) for `run ls && echo "$STDOUT"` helper function
 - 🔬 [`spec.sh`](https://specs.sh) for a lovely shell specification testing framework

---

#### Test Framework Compatibility

- [Bats](https://github.com/bats-core/bats-core)
- [shUnit2](https://github.com/kward/shunit2/)
- [roundup](http://bmizerany.github.io/roundup/roundup.1.html)
