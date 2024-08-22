#!/usr/bin/env bash

set -o errtrace -o nounset -o pipefail -o errexit

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Create temp working directory for mock repo
MOCK_REPO=$(mktemp -d)
if [[ ! "$MOCK_REPO" || ! -d "$MOCK_REPO" ]]; then
    echo "Could not create temp dir"
    exit 1
fi
function cleanup {
    echo "Deleting temp working directory $MOCK_REPO"
    rm -rf "$MOCK_REPO"
}
trap cleanup EXIT

# Filling the mock repo
pushd "$MOCK_REPO" >/dev/null || exit 1
git init --initial-branch=master
git config user.email "test@example.com"
git config user.name "pre-commit test"
cp "$SCRIPT_DIR/Counter.sol" .
git add .
git commit -m "Initial commit"

# Run pre-commit inside the mock repo while referencing the mythril directory,
# where the .pre-commit-hooks.yaml is located.
pre-commit try-repo "$SCRIPT_DIR/../.." mythril --verbose --color=always --all-files
