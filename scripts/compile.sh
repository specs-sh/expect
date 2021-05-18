#! /usr/bin/env bash

SDK=""
NEWLINE=$'\n'

output="$( source "src/expect-sdk.sh" 2>&1 )"
(( $? != 0 )) || [ -n "$output" ] && { echo "Syntax error: $output" >&2; exit 1; }

sdkFunctions=(
  Expect.assert
  Expect.core.nextMatcher
  ExpectMatchers.utils.inspect
  ExpectMatchers.utils.inspectList
)

for sdkFunction in "${sdkFunctions[@]}"; do
  SDK+="$( source "src/expect-sdk.sh" && declare -f "$sdkFunction" )"
done

build=production

[ "$1" = --dev ] && { build=development; shift; }

expectVersion="$( cat src/expect-sdk.sh | grep EXPECT_VERSION= | sed 's/.*EXPECT_VERSION=//' | sed 's/"//g' )"

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
      echo "$SDK"                                 >> "$library.sh"
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