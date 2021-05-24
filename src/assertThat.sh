assertThat() {
  local -r ASSERTTHAT_VERSION=2.0.0
  (( $# == 1 )) && [ "$1" = --version ] && { echo "AssertThat version $ASSERTTHAT_VERSION"; return 0; }
  Expect.assert "$@"; 
}
