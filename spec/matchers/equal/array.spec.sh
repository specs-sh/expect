source spec/helper.sh

include types/array
include matchers/equal/array

example.zeroArguments.fail() {
  words=( Hello )
  e.g. assertThat : assertThat words array equals
  e.g. assertThat : assertThat words array eq
  e.g. assertThat : assertThat words array =
  e.g. assertThat : assertThat words array ==
  e.g. expect     : expect words array to equal
  e.g. expect     : expect words array to eq
  e.g. expect     : expect words array to =
  e.g. expect     : expect words array to ==
  e.g. should     : {{ words }} array should equal
  e.g. should     : {{ words }} array should eq
  e.g. should     : {{ words }} array should =
  e.g. should     : {{ words }} array should ==
  assertStderr 'Array: words'
  assertStderr 'Actual Elements: ("Hello")'
  assertStderr 'Expected Values: ()'
}

example.zeroArguments.pass() {
  words=()
  e.g. assertThat : assertThat words array equals
  e.g. assertThat : assertThat words array eq
  e.g. assertThat : assertThat words array =
  e.g. assertThat : assertThat words array ==
  e.g. expect     : expect words array to equal
  e.g. expect     : expect words array to eq
  e.g. expect     : expect words array to =
  e.g. expect     : expect words array to ==
  e.g. should     : {{ words }} array should equal
  e.g. should     : {{ words }} array should eq
  e.g. should     : {{ words }} array should =
  e.g. should     : {{ words }} array should ==
}

example.fail() {
  words=( Hello World )
  e.g. assertThat : assertThat words array equals World
  e.g. assertThat : assertThat words array eq World
  e.g. assertThat : assertThat words array = World
  e.g. assertThat : assertThat words array == World
  e.g. expect     : expect words array to equal World
  e.g. expect     : expect words array to eq World
  e.g. expect     : expect words array to = World
  e.g. expect     : expect words array to == World
  e.g. should     : {{ words }} array should equal World
  e.g. should     : {{ words }} array should eq World
  e.g. should     : {{ words }} array should = World
  e.g. should     : {{ words }} array should == World
  assertStderr 'Array: words'
  assertStderr 'Actual Elements: ("Hello" "World")'
  assertStderr 'Expected Values: ("World")'
}

example.pass() {
  words=( Hello World )
  e.g. assertThat : assertThat words array equals Hello World
  e.g. assertThat : assertThat words array eq Hello World
  e.g. assertThat : assertThat words array = Hello World
  e.g. assertThat : assertThat words array == Hello World
  e.g. expect     : expect words array to equal Hello World
  e.g. expect     : expect words array to eq Hello World
  e.g. expect     : expect words array to = Hello World
  e.g. expect     : expect words array to == Hello World
  e.g. should     : {{ words }} array should equal Hello World
  e.g. should     : {{ words }} array should eq Hello World
  e.g. should     : {{ words }} array should = Hello World
  e.g. should     : {{ words }} array should == Hello World
}

example.not.fail() {
  words=( Hello World )
  e.g. assertThat : assertThat words array does not equal Hello World
  e.g. assertThat : assertThat words array not eq Hello World
  e.g. assertThat : assertThat words array not = Hello World
  e.g. assertThat : assertThat words array != Hello World
  e.g. expect     : expect words array not to equal Hello World
  e.g. expect     : expect words array not to eq Hello World
  e.g. expect     : expect words array not = Hello World
  e.g. expect     : expect words array != Hello World
  e.g. should     : {{ words }} array should not equal Hello World
  e.g. should     : {{ words }} array should not eq Hello World
  e.g. should     : {{ words }} array should not = Hello World
  e.g. should     : {{ words }} array should != Hello World
  assertStderr 'Array: words'
  assertStderr 'Values: ("Hello" "World")'
}

example.not.pass() {
  words=( Hello World )
  e.g. assertThat : assertThat words array does not equal Hi There
  e.g. assertThat : assertThat words array not eq Hi There
  e.g. assertThat : assertThat words array not = Hi There
  e.g. assertThat : assertThat words array != Hi There
  e.g. expect     : expect words array not to equal Hi There
  e.g. expect     : expect words array not to eq Hi There
  e.g. expect     : expect words array not = Hi There
  e.g. expect     : expect words array != Hi There
  e.g. should     : {{ words }} array should not equal Hi There
  e.g. should     : {{ words }} array should not eq Hi There
  e.g. should     : {{ words }} array should not = Hi There
  e.g. should     : {{ words }} array should != Hi There
}

runExamples