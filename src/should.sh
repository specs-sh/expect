{{() {
  local SHOULD_ACTUAL=
  local -a SHOULD_ACTUAL_LIST=()
  until (( $# == 0 )) || [ "$1" = }} ]; do
    SHOULD_ACTUAL_LIST+=("$1"); shift
  done

  if [ "$1" = }} ]; then
    shift
  else
    echo "TODO BOOM" >&2
    return 1
  fi

  if (( ${#SHOULD_ACTUAL_LIST[@]} == 1 )); then
    local -r SHOULD_ACTUAL="${SHOULD_ACTUAL_LIST[0]}"
    Expect.assert "$SHOULD_ACTUAL" "$@"
  else
    local -r SHOULD_ACTUAL=""
    Expect.assert [ "${SHOULD_ACTUAL_LIST[@]}" ] "$@"
  fi
}

# HIGHLY recommended and preferred for lists
:[() {
  local -a SHOULD_ACTUAL_LIST=()
  until (( $# == 0 )) || [ "$1" = ] ]; do
    SHOULD_ACTUAL_LIST+=("$1"); shift
  done
  shift

  Expect.assert [ "${SHOULD_ACTUAL_LIST[@]}" ] "$@"
}

:{{() {
  local -a SHOULD_COMMAND=()
  until (( $# == 0 )) || [ "$1" = }} ]; do
    SHOULD_COMMAND+=("$1"); shift
  done
  # errors here ...
  shift
  Expect.assert {{ "${SHOULD_COMMAND[@]}" }} "$@";
}

:{() {
  local -a SHOULD_COMMAND=()
  until (( $# == 0 )) || [ "$1" = } ]; do
    SHOULD_COMMAND+=("$1"); shift
  done
  # errors here ...
  shift
  Expect.assert { "${SHOULD_COMMAND[@]}" } "$@";
}