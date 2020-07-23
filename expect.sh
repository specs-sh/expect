expect() {
  local negateResults

  # For blocks, we need to preserve "$@" and shift/unshift to end up with $@ being the command
  if [ "$1" = "{" ]
  then
    shift # {
    local messageToCheckFor="${@: -1}"
    if [ "$messageToCheckFor" = "toFail" ]
    then
      messageToCheckFor=""
      set -- "${@:1:$#-1}" # toFail
      if [ "${@: -1}" = "not" ]
      then
        negateResults=true
        set -- "${@:1:$#-1}" # not
        set -- "${@:1:$#-1}" # }
      else
        set -- "${@:1:$#-1}" # }
      fi
    else
      set -- "${@:1:$#-1}" # message
      set -- "${@:1:$#-1}" # toFail
      if [ "${@: -1}" = "not" ]
      then
        negateResults=true
        set -- "${@:1:$#-1}" # not
        set -- "${@:1:$#-1}" # }
      else
        set -- "${@:1:$#-1}" # }
      fi
    fi
    expect.matcher._toFail "$negateResults" "$messageToCheckFor" "$@" 
    return $?
  fi

  # Everything besides 'toFail' below. Note we might use ^-- blocks for other things later
  local actualResults
  actualResults="$1"; shift
  if [ "$1" = "not" ]
  then
    negateResults=true; shift
  fi
  local matcherName="$1"; shift
  local expectedMatcherFn="expect.matcher.$matcherName"
  local typeCheckResult="$( type -t "$expectedMatcherFn" )"
  if [ $? -eq 0 ] && [ "$typeCheckResult" = "function" ]
  then
    "$expectedMatcherFn" "$negateResults" "$actualResults" "$@"
  else
    echo "Unknown expect matcher '$matcherName'" >&2
    exit 1
  fi
}