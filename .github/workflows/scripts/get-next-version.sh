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

echo "Latest tag: $LATEST_TAG"
echo "New version: $NEW_VERSION"

# Output for GitHub Actions
if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
  echo "new_version=$NEW_VERSION" >> "$GITHUB_OUTPUT"
  echo "latest_tag=$LATEST_TAG" >> "$GITHUB_OUTPUT"
fi

echo "$NEW_VERSION"
