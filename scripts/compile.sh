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
      ;;
  esac
done