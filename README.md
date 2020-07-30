# 🧐 `expect`

```sh
expect { BASH testing } toBe "wonderful"
```

---

```sh
source "expect.sh"

expect "$( echo "Hello" )" toEqual "Hello"

expect "$( ls )" toContain "myFile"

expect { whoops } toFail "whoops: command not found"
```
