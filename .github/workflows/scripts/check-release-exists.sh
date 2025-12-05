#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-}"

if [[ -z "$VERSION" ]]; then
  echo "Usage: $0 <version>"
  exit 1
fi

# Check if release exists using gh CLI
if gh release view "$VERSION" &>/dev/null; then
  echo "Release $VERSION already exists"
  if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
    echo "exists=true" >> "$GITHUB_OUTPUT"
  fi
  exit 0
else
  echo "Release $VERSION does not exist"
  if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
    echo "exists=false" >> "$GITHUB_OUTPUT"
  fi
  exit 0
fi
