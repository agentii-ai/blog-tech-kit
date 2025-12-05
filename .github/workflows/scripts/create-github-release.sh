#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-}"

if [[ -z "$VERSION" ]]; then
  echo "Usage: $0 <version>"
  exit 1
fi

echo "Creating GitHub release for $VERSION..."

# Create the release with all ZIP files
gh release create "$VERSION" \
  .genreleases/*.zip \
  --title "Blog-Tech-Kit Templates $VERSION" \
  --notes-file release_notes.md

echo "✅ Release $VERSION created successfully!"
echo "View at: https://github.com/$(gh repo view --json nameWithOwner -q .nameWithOwner)/releases/tag/$VERSION"
