#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-}"
if [[ -z "$VERSION" ]]; then
  echo "Usage: $0 <version>" >&2
  echo "Example: $0 v0.1.0-test" >&2
  echo ""
  echo "Environment variables:"
  echo "  AGENTS  - Filter agents (comma-separated, e.g., 'claude,gemini')"
  echo "  SCRIPTS - Filter script types (comma-separated, e.g., 'sh' or 'ps')"
  exit 1
fi

# Create output directory
DIST_DIR="dist/templates"
mkdir -p "$DIST_DIR"

# Set GENRELEASES_DIR for create-release-packages.sh
export GENRELEASES_DIR="$DIST_DIR"

echo "========================================="
echo "Blog-Tech-Kit Template Builder"
echo "========================================="
echo "Version: $VERSION"
echo "Source: .blogkit/ directory"
echo "Target: .blogkit/ directory (Option B)"
echo "Output: $DIST_DIR"
echo "========================================="
echo ""

# Call the workflow build script
.github/workflows/scripts/create-release-packages.sh "$VERSION"

echo ""
echo "========================================="
echo "Build Summary"
echo "========================================="

# Count generated files
ZIP_COUNT=$(ls -1 "$DIST_DIR"/*.zip 2>/dev/null | wc -l | tr -d ' ')
echo "Templates generated: $ZIP_COUNT"

# Calculate total size
TOTAL_SIZE=$(du -sh "$DIST_DIR" | cut -f1)
echo "Total size: $TOTAL_SIZE"

echo ""
echo "✅ Build complete! Templates available in $DIST_DIR/"
echo ""
echo "Next steps:"
echo "  1. Test a template: unzip -d /tmp/test $DIST_DIR/spec-kit-template-claude-sh-$VERSION.zip"
echo "  2. Inspect structure: ls -la /tmp/test/.blogkit/"
echo "  3. Run validation: ./scripts/validate-templates.sh $DIST_DIR (once validation script is created)"
