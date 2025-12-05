#!/usr/bin/env bash
set -euo pipefail

# Get the latest tag
LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")

# Extract version numbers
if [[ "$LATEST_TAG" =~ ^v([0-9]+)\.([0-9]+)\.([0-9]+) ]]; then
  MAJOR=${BASH_REMATCH[1]}
  MINOR=${BASH_REMATCH[2]}
  PATCH=${BASH_REMATCH[3]}
else
  MAJOR=0
  MINOR=0
  PATCH=0
fi

# Increment patch version
PATCH=$((PATCH + 1))
NEW_VERSION="v${MAJOR}.${MINOR}.${PATCH}"

# Debug info to stderr (not captured by command substitution)
echo "Latest tag: $LATEST_TAG" >&2
echo "New version: $NEW_VERSION" >&2

# Only the version to stdout (machine-readable)
echo "$NEW_VERSION"
