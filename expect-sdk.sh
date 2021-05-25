# GENERATED
# DO NOT EDIT
# GENERATED

# In Development: use set -eEuo pipefail
set -eEuo pipefail

# Source Expect SDK
__sourceAll__() {
  local file=
  while read -rd '' file; do
    source "$file"
  done < <( find src/sdk -iname "*.sh" -print0 )
}

__sourceAll__