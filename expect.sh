expect() {
  [ $# -eq 0 ] && { echo "Missing required argument for 'expect': actual value or { code block } or {{ subshell code block }}" >&2; return 1; }

  EXPECT_VERSION=0.2.0
  [ $# -eq 1 ] && [ "$1" = "--version" ] && { echo "expect version $EXPECT_VERSION"; return 0; }

  [ -z "$EXPECT_BLOCK_START_PATTERN" ] && local EXPECT_BLOCK_START_PATTERN="^[\[{]+$"
  [ -z "$EXPECT_BLOCK_END_PATTERN"   ] && local EXPECT_BLOCK_END_PATTERN="^[\]}]+$"

  local BLOCK_TYPE=""
  local EXPECT_ACTUAL_RESULT=""
  declare -a BLOCK=()

  if [[ "$1" =~ $EXPECT_BLOCK_START_PATTERN ]]
  then
    BLOCK_TYPE="$1"
    shift
    while [ $# -gt 0 ]
    do
      # Not entirely sure why [[ "$1" =~ $EXPECT_BLOCK_END_PATTERN ]] doesn't work outside of 'eval' 🤷🏼‍♀️
      eval "[[ \"$1\" =~ $EXPECT_BLOCK_END_PATTERN ]] && break"
      BLOCK+=("$1")
      shift
    done
    eval "
      if [[ \"\$1\" =~ $EXPECT_BLOCK_END_PATTERN ]]
      then
        shift
      else
        echo \"Expected block closing braces but found none\" >&2
        return 1
      fi
    "
  else
    EXPECT_ACTUAL_RESULT="$1"
    shift
  fi

  local NOT=""
  [ "$1" = "not" ] && { NOT=true; shift; }

  local MATCHER_NAME="$1"
  shift

  local MATCHER_FUNCTION="expect.matcher.$MATCHER_NAME"
  "$MATCHER_FUNCTION" "$@"
}