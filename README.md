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
