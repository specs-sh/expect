#! /usr/bin/env bash

build=production

[ "$1" = --dev ] && { build=development; shift; }

expectVersion="$( cat expect-sdk.sh | grep EXPECT_VERSION= | sed 's/.*EXPECT_VERSION=//' | sed 's/"//g' )"

for library in assertions assertThat brackets expect should; do
  case "$build" in
    production)
      cp src/_header.sh "$library.sh"
      echo                                     >> "$library.sh"
      echo "# $library Version $expectVersion" >> "$library.sh"
      cat "src/$library.sh"                    >> "$library.sh"
      for matcher in matchers/*.sh; do
        echo                                     >> "$library.sh"
        echo "# Included ${matcher%.sh} matcher" >> "$library.sh"
        cat "$matcher"                           >> "$library.sh" 
        echo                                     >> "$library.sh"
      done
      echo                                        >> "$library.sh"
      echo "# Included Expect SDK $expectVersion" >> "$library.sh"
      cat expect-sdk.sh                           >> "$library.sh"
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
sed -i 's/<script.*//g' README.md