#!/usr/bin/env bash
set -euo pipefail

# build-templates.sh
# Local build wrapper for blog-Kit template generation
# Enables testing template generation without CI/CD
# Usage: ./scripts/build-templates.sh <version> [--verbose]
#   Version must match: v[0-9]+\.[0-9]+\.[0-9]+
#   Optional env vars:
#     AGENTS: space or comma separated agent names (default: all 18)
#     SCRIPTS: space or comma separated script types (default: sh,ps)
#   Examples:
#     ./scripts/build-templates.sh v0.1.0
#     AGENTS=claude SCRIPTS=sh ./scripts/build-templates.sh v0.1.0
#     AGENTS="claude,gemini" ./scripts/build-templates.sh v0.1.0

VERSION="${1:-}"
VERBOSE="${2:-}"

# Validate version argument
if [[ -z "$VERSION" ]]; then
  echo "Usage: $0 <version> [--verbose]" >&2
  echo "  Example: $0 v0.1.0" >&2
  exit 1
fi

# Version pattern: must be v[0-9]+.[0-9]+.[0-9]+ (no -test suffix for actual build)
if [[ ! $VERSION =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Error: Version must match pattern v[0-9]+\.[0-9]+\.[0-9]+ (e.g., v0.1.0)" >&2
  exit 1
fi

# Setup output directory
DIST_DIR="dist/templates"
mkdir -p "$DIST_DIR"
rm -rf "$DIST_DIR"/* || true

# Export for create-release-packages.sh
export GENRELEASES_DIR="$DIST_DIR"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║     blog-Kit Template Builder                               ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "Version: $VERSION"
echo "Output:  $DIST_DIR"
echo "Agents:  ${AGENTS:-all 18}"
echo "Scripts: ${SCRIPTS:-sh,ps}"
echo ""

# Call the existing build script
if [[ "$VERBOSE" == "--verbose" ]]; then
  chmod +x .github/workflows/scripts/create-release-packages.sh
  .github/workflows/scripts/create-release-packages.sh "$VERSION"
else
  chmod +x .github/workflows/scripts/create-release-packages.sh
  .github/workflows/scripts/create-release-packages.sh "$VERSION" >/dev/null 2>&1 || {
    echo "❌ Build failed" >&2
    exit 1
  }
fi

# Generate manifest with metadata
generate_manifest() {
  local version=$1
  local output_dir=$2
  local build_started=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

  echo "Generating build manifest..."

  # Create manifest JSON
  cat > "$output_dir/build-manifest.json" << 'MANIFEST_EOF'
{
  "build_id": "$(date -u +%Y%m%d-%H%M%S)",
  "version": "$version",
  "build_started_at": "$build_started",
  "build_completed_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "variants": [],
  "total_size_bytes": 0,
  "failed_variants": [],
  "environment": {
    "os": "$(uname -s)",
    "bash_version": "$BASH_VERSION",
    "git_commit": "$(git rev-parse HEAD 2>/dev/null || echo 'unknown')"
  }
}
MANIFEST_EOF

  # Collect variant metadata
  local variants_json="[]"
  local total_size=0
  local failed_count=0

  for zip_file in "$output_dir"/*.zip; do
    [[ -f "$zip_file" ]] || continue

    local filename=$(basename "$zip_file")
    local size=$(stat -f%z "$zip_file" 2>/dev/null || stat -c%s "$zip_file" 2>/dev/null || echo 0)
    local sha256=$(shasum -a 256 "$zip_file" | cut -d' ' -f1)

    # Extract agent and script from filename
    if [[ $filename =~ spec-kit-template-([^-]+)-(sh|ps)-v[0-9]+\.[0-9]+\.[0-9]+.*\.zip ]]; then
      local agent="${BASH_REMATCH[1]}"
      local script="${BASH_REMATCH[2]}"

      # Add variant to JSON
      local variant_json="{\"agent\":\"$agent\",\"script\":\"$script\",\"archive_name\":\"$filename\",\"size_bytes\":$size,\"sha256\":\"$sha256\",\"build_status\":\"completed\"}"

      if [[ "$variants_json" == "[]" ]]; then
        variants_json="[$variant_json]"
      else
        variants_json=$(echo "$variants_json" | sed "s/\]/,$variant_json]/")
      fi

      total_size=$((total_size + size))
    fi
  done

  # Update manifest with actual data (using jq if available, otherwise basic sed)
  if command -v jq &>/dev/null; then
    local manifest=$(jq \
      --arg version "$version" \
      --arg build_id "$(date -u +%Y%m%d-%H%M%S)" \
      --arg started "$build_started" \
      --arg completed "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
      --arg total "$total_size" \
      '.version = $version | .build_id = $build_id | .build_started_at = $started | .build_completed_at = $completed | .total_size_bytes = ($total | tonumber) | .variants = ('"$variants_json"' // []) | .failed_variants = []' \
      "$output_dir/build-manifest.json")
    echo "$manifest" > "$output_dir/build-manifest.json"
  else
    # Fallback: basic text replacement without jq
    echo "Warning: jq not found, using basic manifest generation" >&2
  fi
}

# Generate manifest
if ! generate_manifest "$VERSION" "$DIST_DIR"; then
  echo "⚠️  Warning: Could not generate manifest" >&2
fi

# Display summary
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                   BUILD COMPLETE                           ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Count and display generated templates
zip_count=$(find "$DIST_DIR" -name "*.zip" | wc -l)
total_size=$(du -sh "$DIST_DIR" | awk '{print $1}')

echo "📦 Templates Generated: $zip_count"
echo "📊 Total Size:         $total_size"
echo "📁 Output Directory:   $DIST_DIR"
echo ""

# Show first few ZIPs
echo "Sample Generated Templates:"
find "$DIST_DIR" -name "*.zip" -type f | sort | head -3 | while read -r zip; do
  size=$(ls -lh "$zip" | awk '{print $5}')
  name=$(basename "$zip")
  sha256=$(shasum -a 256 "$zip" | cut -d' ' -f1)
  echo "  • $name ($size)"
  echo "    SHA-256: $sha256"
done

if [[ $zip_count -gt 3 ]]; then
  echo "  ... and $((zip_count - 3)) more templates"
fi

echo ""

# Validate templates before declaring success
if [[ $zip_count -gt 0 ]]; then
  echo "🔍 Validating templates..."
  echo ""

  if ./scripts/validate-templates.sh "$DIST_DIR"; then
    echo ""
    echo "✅ Build and validation succeeded!"
    echo ""
    echo "Next steps:"
    echo ""
    echo "  1. Review templates in:"
    echo "     $DIST_DIR"
    echo ""
    echo "  2. Test with CLI:"
    echo "     blog init test-project --template file://$DIST_DIR/spec-kit-template-claude-sh-$VERSION.zip"
    echo ""
    echo "  3. Create a release:"
    echo "     gh release create $VERSION dist/templates/*.zip --draft --notes 'blog-Kit $VERSION'"
    echo ""
    exit 0
  else
    echo ""
    echo "❌ Validation failed - review errors above"
    echo ""
    echo "Templates were built but did not pass validation."
    echo "Fix errors and rebuild before releasing."
    echo ""
    exit 1
  fi
else
  echo "❌ No templates were generated!"
  exit 1
fi
