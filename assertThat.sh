# GENERATED
# DO NOT EDIT
# GENERATED

# In Development: use set -eEuo pipefail
set -eEuo pipefail

# Source Expect SDK
source expect-sdk.sh

# assertThat Version 2.0.0

assertThat() {
  local -r ASSERTTHAT_VERSION=2.0.0
  (( $# == 1 )) && [ "$1" = --version ] && { echo "AssertThat version $ASSERTTHAT_VERSION"; return 0; }
  Expect.assert "$@"; 
}


# GENERATED
# DO NOT EDIT
# GENERATED
