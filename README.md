# 🧐 `expect`

```sh
expect { BASH testing } toBe "wonderful"
```

Flexible testing expectation library in [< 50 LOC](https://github.com/bx-sh/expect.sh/blob/master/expect.sh)

---

Download the [latest release](https://github.com/bx-sh/expect.sh/archive/v0.2.0.tar.gz)

```sh
source "expect.sh"
```

---

## Built-in Matchers

### `toEqual`

```sh
source "matchers/toEqual.sh"

expect "$( echo "Hello" )" toEqual "Hello"
```
