source spec/helper.sh

source brackets.sh

spec.noArguments() {
  refute run [:
  assertStderr "Brackets [: missing required arguments: [!] [-bcdefghknprstuwxzGLNOS] [actual] [operator] [expected] ']'"
}

spec.noClosingBracket() {
  refute run [: x = x
  assertStderr "Brackets [: missing closing ']' bracket. Provided arguments: [: \"x\" \"=\" \"x\""
}

spec.noBlockContent() {
  refute run [: ]
  assertStderr "Brackets [: ] missing required arguments: [!] [-bcdefghknprstuwxzGLNOS] [actual] [operator] [expected]"
}

spec.onlyNotOperator() {
  refute run [: ! ]
  assertStderr "Brackets [: \"!\" ] missing required arguments: [-bcdefghknprstuwxzGLNOS] [actual] [operator] [expected]"
}

spec.underTwoBlockArguments() {
  refute run [: ! hi ]
  assertStderr "Brackets [: \"!\" \"hi\" ] missing required arguments: [-bcdefghknprstuwxzGLNOS] [operator] [expected]"
}

spec.twoArguments.unsupportedOperator() {
  refute run [: = "Hello" ]
  assertStderr 'Brackets unknown operator: "=". Provided arguments: [: "=" "Hello" ]'
}

spec.threeArguments.unsupportedOperator() {
  refute run [: "Hello" -f "Hello" ]
  assertStderr 'Brackets unknown operator: "-f". Provided arguments: [: "Hello" "-f" "Hello" ]'
}