source spec/helper.sh

include matchers/equal/list

example.zeroArguments.fail() {
  e.g. assertThat : assertThat [ Hello ] equals
  e.g. assertThat : assertThat [ Hello ] eq
  e.g. assertThat : assertThat [ Hello ] =
  e.g. assertThat : assertThat [ Hello ] ==
  e.g. expect     : expect [ Hello ] to equal
  e.g. expect     : expect [ Hello ] to eq
  e.g. expect     : expect [ Hello ] to =
  e.g. expect     : expect [ Hello ] to ==
  e.g. should     : :[ Hello ] should equal
  e.g. should     : :[ Hello ] should eq
  e.g. should     : :[ Hello ] should =
  e.g. should     : :[ Hello ] should ==
  assertStderr 'Actual: ("Hello")'
  assertStderr 'Expected: ()'
}

example.zeroArguments.pass() {
  e.g. assertThat : assertThat [ ] equals
  e.g. assertThat : assertThat [ ] eq
  e.g. assertThat : assertThat [ ] =
  e.g. assertThat : assertThat [ ] ==
  e.g. expect     : expect [ ] to equal
  e.g. expect     : expect [ ] to eq
  e.g. expect     : expect [ ] to =
  e.g. expect     : expect [ ] to ==
  e.g. should     : :[ ] should equal
  e.g. should     : :[ ] should eq
  e.g. should     : :[ ] should =
  e.g. should     : :[ ] should ==
}

example.fail() {
  e.g. assertThat : assertThat [ Hello World ] equals World
  e.g. assertThat : assertThat [ Hello World ] eq World
  e.g. assertThat : assertThat [ Hello World ] = World
  e.g. assertThat : assertThat [ Hello World ] == World
  e.g. expect     : expect [ Hello World ] to equal World
  e.g. expect     : expect [ Hello World ] to eq World
  e.g. expect     : expect [ Hello World ] to = World
  e.g. expect     : expect [ Hello World ] to == World
  e.g. should     : :[ Hello World ] should equal World
  e.g. should     : :[ Hello World ] should eq World
  e.g. should     : :[ Hello World ] should = World
  e.g. should     : :[ Hello World ] should == World
}

example.pass() {
  e.g. assertThat : assertThat [ Hello World ] equals Hello World
  e.g. assertThat : assertThat [ Hello World ] eq Hello World
  e.g. assertThat : assertThat [ Hello World ] = Hello World
  e.g. assertThat : assertThat [ Hello World ] == Hello World
  e.g. expect     : expect [ Hello World ] to equal Hello World
  e.g. expect     : expect [ Hello World ] to eq Hello World
  e.g. expect     : expect [ Hello World ] to = Hello World
  e.g. expect     : expect [ Hello World ] to == Hello World
  e.g. should     : :[ Hello World ] should equal Hello World
  e.g. should     : :[ Hello World ] should eq Hello World
  e.g. should     : :[ Hello World ] should = Hello World
  e.g. should     : :[ Hello World ] should == Hello World
}

example.not.fail() {
  e.g. assertThat : assertThat [ Hello World ] does not equal Hello World
  e.g. assertThat : assertThat [ Hello World ] not eq Hello World
  e.g. assertThat : assertThat [ Hello World ] not = Hello World
  e.g. assertThat : assertThat [ Hello World ] != Hello World
  e.g. expect     : expect [ Hello World ] not to equal Hello World
  e.g. expect     : expect [ Hello World ] not to eq Hello World
  e.g. expect     : expect [ Hello World ] not = Hello World
  e.g. expect     : expect [ Hello World ] != Hello World
  e.g. should     : :[ Hello World ] should not equal Hello World
  e.g. should     : :[ Hello World ] should not eq Hello World
  e.g. should     : :[ Hello World ] should not = Hello World
  e.g. should     : :[ Hello World ] should != Hello World
  assertStderr 'Values: ("Hello" "World")'
}

example.not.pass() {
  e.g. assertThat : assertThat [ Hello World ] does not equal Hi There
  e.g. assertThat : assertThat [ Hello World ] not eq Hi There
  e.g. assertThat : assertThat [ Hello World ] not = Hi There
  e.g. assertThat : assertThat [ Hello World ] != Hi There
  e.g. expect     : expect [ Hello World ] not to equal Hi There
  e.g. expect     : expect [ Hello World ] not to eq Hi There
  e.g. expect     : expect [ Hello World ] not = Hi There
  e.g. expect     : expect [ Hello World ] != Hi There
  e.g. should     : :[ Hello World ] should not equal Hi There
  e.g. should     : :[ Hello World ] should not eq Hi There
  e.g. should     : :[ Hello World ] should not = Hi There
  e.g. should     : :[ Hello World ] should != Hi There
}

runExamples