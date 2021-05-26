#! /usr/bin/env bash

build=production

[ "$1" = --dev ] && { build=development; shift; }
[ "$1" = --prod ] && { build=production; shift; }

rm -f expect-sdk.sh
case "$build" in
  production)
    cp src/_header.sh expect-sdk.sh
    while read -rd '' file; do
      echo >> expect-sdk.sh
      cat "$file" >> expect-sdk.sh
      echo >> expect-sdk.sh
    done < <( find src/sdk -iname "*.sh" -print0 )
    ;;
  development)
    cp src/_devSdkHeader.sh expect-sdk.sh
    ;;
esac

expectVersion="$( cat expect-sdk.sh | grep EXPECT_VERSION= | sed 's/.*EXPECT_VERSION=//' | sed 's/"//g' )"

for library in assertions assertThat brackets expect should; do
  rm -f "$library.sh"
  case "$build" in
    production)
      cp src/_header.sh "$library.sh"
      echo                                     >> "$library.sh"
      echo "# $library Version $expectVersion" >> "$library.sh"
      cat "src/$library.sh"                    >> "$library.sh"
      for dir in types filters matchers; do
        while read -rd '' file; do
          echo >> "$library.sh"
          echo "# Included ${file%.sh}" >> "$library.sh"
          cat "$file" >> "$library.sh"
          echo >> "$library.sh"
        done < <( find "$dir" -iname "*.sh" -print0 )
      done
      echo                                        >> "$library.sh"
      echo "# Included Expect SDK $expectVersion" >> "$library.sh"
      cat expect-sdk.sh | tail -n +5              >> "$library.sh" # Without license header (already present)
      echo                                        >> "$library.sh"
      ;;
    development)
      cp src/_devHeader.sh "$library.sh"
      echo                                     >> "$library.sh"
      echo "# $library Version $expectVersion" >> "$library.sh"
      echo                                     >> "$library.sh"
      cat "src/$library.sh"                    >> "$library.sh"
      echo                                     >> "$library.sh"
      cat "src/_devFooter.sh"                  >> "$library.sh"
      ;;
  esac
done

# README_HEADER="
# [![Mac (BASH 3.2)](https://github.com/specs-sh/expect/workflows/Mac%20(BASH%203.2)/badge.svg)](https://github.com/specs-sh/expect/actions?query=workflow%3A%22Mac+%28BASH+3.2%29%22) [![BASH 4.0](https://github.com/specs-sh/expect/workflows/BASH%204.0/badge.svg)](https://github.com/specs-sh/expect/actions?query=workflow%3A%22BASH+4.0%22) [![BASH 4.4](https://github.com/specs-sh/expect/workflows/BASH%204.4/badge.svg)](https://github.com/specs-sh/expect/actions?query=workflow%3A%22BASH+4.4%22) [![BASH 5.0](https://github.com/specs-sh/expect/workflows/BASH%205.0/badge.svg)](https://github.com/specs-sh/expect/actions?query=workflow%3A%22BASH+5.0%22)
# "

README_HEADER=""

echo "$README_HEADER" > README.md
echo >> README.md
cat docs/index.md | tail -n +4 >> README.md
sed -i 's/{% raw %}//g' README.md
sed -i 's/{% endraw %}//g' README.md
sed -i 's/<i class="fad fa-books"><\/i>/📖/g' README.md
sed -i 's/<i class="fad fa-download"><\/i>/⬇️/g' README.md
sed -i 's/<i class="fad fa-flask"><\/i>/⚗️/g' README.md
sed -i 's/<i class="fad fa-atom-alt"><\/i>/⚛️/g' README.md
sed -i 's/<i class="fad fa-terminal"><\/i>/💻/g' README.md
sed -i 's/<i class="fad fa-digging"><\/i>/🚧/g' README.md
sed -i 's/<script.*//g' README.md