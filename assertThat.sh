set -uo pipefail # Remove when ready for production
source core/core.sh # Switch to compilation when ready for production

assertThat() { Expect.core.assert assertThat "$@"; }
