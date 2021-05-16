source spec/helper.sh
source matchers/commands.sh
source matchers/equal.sh
source should.sh

passingFunction() {
  echo "Passing STDOUT"
  echo "Passing STDERR" >&2
}

failingFunction() {
  echo "Failing STDOUT"
  echo "Failing STDERR" >&2
  return 42
}

spec.commands() {
  {{{ passingFunction }}} should pass with stdout equal "Passing STDOUT"
  {{{ passingFunction }}} should pass with stdout = "Passing STDOUT"
}