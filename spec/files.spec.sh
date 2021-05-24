source spec/helper.sh
source matchers/file.sh
source matchers/io.sh

example.file.exists.fail() {
  e.g. assertions : assertFileExists does/not/exist
  e.g. assertThat : assertThat does/not/exist file exists
  e.g. brackets   : [: -f does/not/exist ]
  e.g. expect     : expect does/not/exist file to exist
  e.g. should     : {{ does/not/exist }} file should exist
  assertStderr "Expected file to exist" 'File Path: "does/not/exist"'
}

example.file.not.exists.fail() {
  e.g. assertions : assertNotFileExists README.md
  e.g. assertThat : assertThat README.md file does not exist
  e.g. brackets   : [: ! -f README.md ]
  e.g. expect     : expect README.md file not to exist
  e.g. should     : {{ README.md }} file should not exist
  assertStderr "Expected file not to exist" 'File Path: "README.md"'
}

runExamples