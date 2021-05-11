@spec.expect.version() {
  assert run expect --version
  assert [ "$STDERR" = "" ]
  if [[ "$STDOUT" =~ expect[[:space:]]version[[:space:]][0-9]\.[0-9]\.[0-9] ]]
  then
    return 0
  else
    echo "$STDOUT did not match expected regular expression" >&2
    return 1
  fi
}