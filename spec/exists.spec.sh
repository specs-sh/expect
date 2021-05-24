source spec/helper.sh
source matchers/file.sh
source matchers/path.sh
source matchers/directory.sh
source matchers/exist.sh

##
# Path
##

example.path.exists.fail() {
  e.g. assertions : assertExists does/not/exist
  e.g. assertThat : assertThat does/not/exist path exists
  e.g. brackets   : [: -e does/not/exist ]
  e.g. expect     : expect does/not/exist path to exist
  e.g. should     : {{ does/not/exist }} path should exist
  assertStderr "Expected path to exist" 'Path: "does/not/exist"'
}

example.path.exists.pass() {
  e.g. assertions : assertExists README.md
  e.g. assertThat : assertThat README.md path exists
  e.g. brackets   : [: -e README.md ]
  e.g. expect     : expect README.md path to exist
  e.g. should     : {{ README.md }} path should exist
  assertEmptyStderr
  assertExitcode 0
}

example.path.not.exists.fail() {
  e.g. assertions : assertNotExists README.md
  e.g. assertThat : assertThat README.md path does not exist
  e.g. brackets   : [: ! -e README.md ]
  e.g. expect     : expect README.md path not to exist
  e.g. should     : {{ README.md }} path should not exist
  assertStderr "Expected path not to exist" 'Path: "README.md"'
}

example.path.not.exists.pass() {
  e.g. assertions : assertNotExists Does-Not-Exist.md
  e.g. assertThat : assertThat Does-Not-Exist.md path does not exist
  e.g. brackets   : [: ! -e Does-Not-Exist.md ]
  e.g. expect     : expect Does-Not-Exist.md path not to exist
  e.g. should     : {{ Does-Not-Exist.md }} path should not exist
  assertEmptyStderr
  assertExitcode 0
}

##
# File
##

example.file.exists.fail() {
  e.g. assertions : assertFileExists does/not/exist
  e.g. assertThat : assertThat does/not/exist file exists
  e.g. brackets   : [: -f does/not/exist ]
  e.g. expect     : expect does/not/exist file to exist
  e.g. should     : {{ does/not/exist }} file should exist
  assertStderr "Expected file to exist" 'File Path: "does/not/exist"'
}

example.file.exists.pass() {
  e.g. assertions : assertFileExists README.md
  e.g. assertThat : assertThat README.md file exists
  e.g. brackets   : [: -f README.md ]
  e.g. expect     : expect README.md file to exist
  e.g. should     : {{ README.md }} file should exist
  assertEmptyStderr
  assertExitcode 0
}

example.file.not.exists.fail() {
  e.g. assertions : assertNotFileExists README.md
  e.g. assertThat : assertThat README.md file does not exist
  e.g. brackets   : [: ! -f README.md ]
  e.g. expect     : expect README.md file not to exist
  e.g. should     : {{ README.md }} file should not exist
  assertStderr "Expected file not to exist" 'File Path: "README.md"'
}

example.file.not.exists.pass() {
  e.g. assertions : assertNotFileExists Does-Not-Exist.md
  e.g. assertThat : assertThat Does-Not-Exist.md file does not exist
  e.g. brackets   : [: ! -f Does-Not-Exist.md ]
  e.g. expect     : expect Does-Not-Exist.md file not to exist
  e.g. should     : {{ Does-Not-Exist.md }} file should not exist
  assertEmptyStderr
  assertExitcode 0
}

##
# Directory
##

example.directory.exists.fail() {
  e.g. assertions : assertDirectoryExists does/not/exist
  e.g. assertThat : assertThat does/not/exist directory exists
  e.g. brackets   : [: -d does/not/exist ]
  e.g. expect     : expect does/not/exist directory to exist
  e.g. should     : {{ does/not/exist }} directory should exist
  assertStderr "Expected directory to exist" 'Directory Path: "does/not/exist"'
}

example.directory.exists.pass() {
  e.g. assertions : assertDirectoryExists spec
  e.g. assertThat : assertThat spec directory exists
  e.g. brackets   : [: -d spec ]
  e.g. expect     : expect spec directory to exist
  e.g. should     : {{ spec }} directory should exist
  assertEmptyStderr
  assertExitcode 0
}

example.directory.not.exists.fail() {
  e.g. assertions : assertNotDirectoryExists spec
  e.g. assertThat : assertThat spec directory does not exist
  e.g. brackets   : [: ! -d spec ]
  e.g. expect     : expect spec directory not to exist
  e.g. should     : {{ spec }} directory should not exist
  assertStderr "Expected directory not to exist" 'Directory Path: "spec"'
}

example.directory.not.exists.pass() {
  e.g. assertions : assertNotDirectoryExists Does-Not-Exist.md
  e.g. assertThat : assertThat Does-Not-Exist.md directory does not exist
  e.g. brackets   : [: ! -d Does-Not-Exist.md ]
  e.g. expect     : expect Does-Not-Exist.md directory not to exist
  e.g. should     : {{ Does-Not-Exist.md }} directory should not exist
  assertEmptyStderr
  assertExitcode 0
}

runExamples