source spec/helper.sh
source matchers/commands.sh
source matchers/equal.sh
source expect.sh

passingFunction() {
  echo "Passing STDOUT"
  echo "Passing STDERR" >&2
}

failingFunction() {
  echo "Failing STDOUT"
  echo "Failing STDERR" >&2
  return 42
}

spec.expect.command.output.to.equal() {
  assert run expect { passingFunction } output to equal "Passing STDOUTPassing STDERR"
  assert run expect { failingFunction } output to equal "Failing STDOUTFailing STDERR"
}

spec.expect.command.to.have.exitcode() {
  assert run expect { passingFunction } exitcode to equal 0
  refute run expect { passingFunction } exitcode to equal 42
  [[ "$STDERR" = *"Expected results to equal:"* ]]
  [[ "$STDERR" = *"Actual: '0'"* ]]
  [[ "$STDERR" = *"Expected: '42'"* ]]

  assert run expect { failingFunction } exitcode not to equal 0
  refute run expect { failingFunction } exitcode not to equal 42
  [[ "$STDERR" = *"Expected results not to equal"* ]]
  [[ "$STDERR" = *"Value: '42'"* ]]
}

spec.expect.command.stdout.to.equal() {
  assert run expect { passingFunction } stdout to equal "Passing STDOUT"
  refute run expect { failingFunction } stdout to equal "Passing STDOUT"
  assert run expect { failingFunction } stdout not to equal "Passing STDOUT"
}

spec.expect.command.to.have.exitcode.and.stdout.equal() {
  assert run expect { failingFunction } exitcode to equal 42 \
                                    and stdout to equal "Failing STDOUT"
  refute run expect { failingFunction } exitcode to equal 42 \
                                    and stdout to equal "Failing STDOUTXX"
  [[ "$STDERR" = *"Expected results to equal:"* ]]
  [[ "$STDERR" = *"Actual: 'Failing STDOUT'"* ]]
  [[ "$STDERR" = *"Expected: 'Failing STDOUTXX'"* ]]

  assert run expect { failingFunction } to fail \
    with exitcode equals 42 \
    and stdout equals "Failing STDOUT" \
    and stderr equals "Failing STDERR"
}

spec.expect.command.to.fail() {
  assert run expect { failingFunction } to fail
  refute run expect { passingFunction } to fail
  [[ "$STDERR" = *"Expected command to fail"* ]]
  [[ "$STDERR" = *"Command: passingFunction"* ]]

  assert run expect { passingFunction } not to fail
  refute run expect { failingFunction } not to fail
  [[ "$STDERR" = *"Expected command not to fail"* ]]
  [[ "$STDERR" = *"Command: failingFunction"* ]]
  [[ "$STDERR" = *"Exit code: 42"* ]]
}
