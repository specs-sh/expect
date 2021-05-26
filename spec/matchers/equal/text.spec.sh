source spec/helper.sh

include matchers/equal/text

example.missingArgument.fail() {
  e.g. assertThat : assertThat Hello equals
  e.g. assertThat : assertThat Hello eq
  e.g. assertThat : assertThat Hello =
  e.g. assertThat : assertThat Hello ==
  e.g. expect     : expect Hello to equal
  e.g. expect     : expect Hello to eq
  e.g. expect     : expect Hello to =
  e.g. expect     : expect Hello to ==
  e.g. should     : {{ Hello }} should equal
  e.g. should     : {{ Hello }} should eq
  e.g. should     : {{ Hello }} should =
  e.g. should     : {{ Hello }} should ==
}

example.fail() {
  e.g. assertions : assertEqual World Hello
  e.g. assertThat : assertThat Hello equals World
  e.g. assertThat : assertThat Hello eq World
  e.g. assertThat : assertThat Hello = World
  e.g. assertThat : assertThat Hello == World
  e.g. brackets   : [: "Hello" = "World" ]
  e.g. brackets   : [: ! "Hello" != "World" ]
  e.g. expect     : expect Hello to equal World
  e.g. expect     : expect Hello to eq World
  e.g. expect     : expect Hello to = World
  e.g. expect     : expect Hello to == World
  e.g. should     : {{ Hello }} should equal World
  e.g. should     : {{ Hello }} should eq World
  e.g. should     : {{ Hello }} should = World
  e.g. should     : {{ Hello }} should == World
  assertStderr 'Actual: "Hello"'
  assertStderr 'Expected: "World"'
}

example.pass() {
  e.g. assertions : assertEqual Hello Hello
  e.g. assertThat : assertThat Hello equals Hello
  e.g. assertThat : assertThat Hello eq Hello
  e.g. assertThat : assertThat Hello = Hello
  e.g. assertThat : assertThat Hello == Hello
  e.g. brackets   : [: "Hello" = "Hello" ]
  e.g. brackets   : [: ! "Hello" != "Hello" ]
  e.g. expect     : expect Hello to equal Hello
  e.g. expect     : expect Hello to eq Hello
  e.g. expect     : expect Hello to = Hello
  e.g. expect     : expect Hello to == Hello
  e.g. should     : {{ Hello }} should equal Hello
  e.g. should     : {{ Hello }} should eq Hello
  e.g. should     : {{ Hello }} should = Hello
  e.g. should     : {{ Hello }} should == Hello
}

example.not.fail() {
  e.g. assertions : assertNotEqual Hello Hello
  e.g. assertThat : assertThat Hello does not equal Hello
  e.g. assertThat : assertThat Hello does not eq Hello
  e.g. assertThat : assertThat Hello does not = Hello
  e.g. assertThat : assertThat Hello does not == Hello
  e.g. brackets   : [: "Hello" != "Hello" ]
  e.g. brackets   : [: ! "Hello" = "Hello" ]
  e.g. expect     : expect Hello not to equal Hello
  e.g. expect     : expect Hello not to eq Hello
  e.g. expect     : expect Hello not to = Hello
  e.g. expect     : expect Hello not to == Hello
  e.g. should     : {{ Hello }} should not equal Hello
  e.g. should     : {{ Hello }} should not eq Hello
  e.g. should     : {{ Hello }} should not = Hello
  e.g. should     : {{ Hello }} should not == Hello
  assertStderr 'Text: "Hello"'
}

example.not.pass() {
  e.g. assertions : assertNotEqual World Hello
  e.g. assertThat : assertThat Hello does not equal World
  e.g. assertThat : assertThat Hello not eq World
  e.g. assertThat : assertThat Hello != World
  e.g. brackets   : [: "Hello" != "World" ]
  e.g. brackets   : [: ! "Hello" = "World" ]
  e.g. expect     : expect Hello not to equal World
  e.g. expect     : expect Hello not eq World
  e.g. expect     : expect Hello not = World
  e.g. expect     : expect Hello != World
  e.g. should     : {{ Hello }} should not equal World
  e.g. should     : {{ Hello }} should not eq World
  e.g. should     : {{ Hello }} should not = World
  e.g. should     : {{ Hello }} should != World
}

runExamples