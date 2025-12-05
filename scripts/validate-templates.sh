#!/usr/bin/env bash
set -euo pipefail

# validate-templates.sh
# Automated validation of blog-Kit template quality
# Prevents publishing templates with wrong namespace, missing files, or structural issues
# Usage: ./scripts/validate-templates.sh <template-dir-or-zip> [--verbose]

INPUT="${1:-.}"
VERBOSE="${2:-}"
TEMP_DIR=""
TOTAL_VARIANTS=0
PASSED_VARIANTS=0
FAILED_VARIANTS=0
FAILED_LIST=""

# Cleanup temporary directories on exit
cleanup() {
  if [[ -n "$TEMP_DIR" && -d "$TEMP_DIR" ]]; then
    rm -rf "$TEMP_DIR"
  fi
}
trap cleanup EXIT

# Color output functions
print_pass() { echo "  ✅ $1"; }
print_fail() { echo "  ❌ $1"; }
print_warn() { echo "  ⚠️  $1"; }

check_frontmatter_namespace() {
  local extract_dir=$1
  local variant_name=$2
  local errors=0

  # Find agent directory (anything starting with . except .blogkit)
  local agent_dir=$(find "$extract_dir" -maxdepth 1 -type d -name ".*" ! -name ".blogkit" | head -1)
  if [[ -z "$agent_dir" ]]; then
    print_fail "No agent directory found (expected .{agent}/)"
    return 1
  fi

  # Special handling for Copilot (uses .github/agents/ structure)
  local command_search_dir="$agent_dir"
  if [[ "$(basename "$agent_dir")" == ".github" ]]; then
    if [[ -d "$agent_dir/agents" ]]; then
      command_search_dir="$agent_dir/agents"
    fi
  fi

  # Check all command files in agent directory
  local command_files=$(find "$command_search_dir" -type f \( -name "blogkit.*.md" -o -name "blogkit.*.toml" -o -name "blogkit.*.agent.md" \) 2>/dev/null | wc -l)

  if [[ $command_files -lt 9 ]]; then
    print_fail "Command file count check: found $command_files, expected 9"
    return 1
  fi

  # Check frontmatter in a sample file (support .md, .toml, and .agent.md)
  local sample_file=$(find "$command_search_dir" -type f \( -name "blogkit.*.md" -o -name "blogkit.*.agent.md" \) | head -1)
  if [[ -n "$sample_file" ]]; then
    # Extract agent line from YAML frontmatter
    local agent_line=$(sed -n '/^---$/,/^---$/p' "$sample_file" 2>/dev/null | grep "^agent:" | head -1 || true)

    if [[ -z "$agent_line" ]]; then
      print_fail "No 'agent:' frontmatter found in $(basename "$sample_file")"
      return 1
    fi

    if [[ ! "$agent_line" =~ ^agent:[[:space:]]*blogkit\. ]]; then
      print_fail "Wrong namespace in frontmatter: $agent_line"
      return 1
    fi
  fi

  print_pass "Frontmatter uses blogkit.* namespace"
  return 0
}

# Check 2: Required files validation
check_required_files() {
  local extract_dir=$1
  local errors=0

  local required_files=(
    ".blogkit/memory/constitution.md"
    ".blogkit/templates/spec-template.md"
    ".blogkit/templates/plan-template.md"
    ".blogkit/templates/tasks-template.md"
  )

  for file in "${required_files[@]}"; do
    if [[ ! -f "$extract_dir/$file" ]]; then
      print_fail "Missing required file: $file"
      ((errors++))
    fi
  done

  if [[ $errors -eq 0 ]]; then
    print_pass "All required files present"
  fi

  return $errors
}

# Check 3: Content scanning for spec-kit references
check_content_references() {
  local extract_dir=$1
  local errors=0

  # Scan for /speckit. references in command files
  local speckit_refs=$(find "$extract_dir" -type f \( -name "*.md" -o -name "*.toml" -o -name "*.agent.md" \) -exec grep -l "speckit\." {} \; 2>/dev/null | wc -l)

  if [[ $speckit_refs -gt 0 ]]; then
    print_fail "Found $speckit_refs files with speckit references"
    return 1
  fi

  print_pass "No /speckit.* references found"
  return 0
}

# Check 4: Directory structure validation
check_directory_structure() {
  local extract_dir=$1
  local errors=0

  # Verify .blogkit directory
  if [[ ! -d "$extract_dir/.blogkit" ]]; then
    print_fail "Missing .blogkit directory"
    return 1
  fi

  # Verify subdirectories
  local required_dirs=("memory" "scripts" "templates")
  for dir in "${required_dirs[@]}"; do
    if [[ ! -d "$extract_dir/.blogkit/$dir" ]]; then
      print_fail "Missing .blogkit/$dir directory"
      ((errors++))
    fi
  done

  if [[ $errors -gt 0 ]]; then
    return 1
  fi

  print_pass "Directory structure is correct"
  return 0
}

# Check 5: Constitution version validation
check_constitution_version() {
  local extract_dir=$1

  if [[ ! -f "$extract_dir/.blogkit/memory/constitution.md" ]]; then
    print_fail "Constitution file not found"
    return 1
  fi

  # Check for Blog-Tech-Kit constitution header
  if ! grep -q "Blog-Tech-Kit Constitution" "$extract_dir/.blogkit/memory/constitution.md"; then
    print_fail "Not a Blog-Tech-Kit constitution (missing 'Blog-Tech-Kit Constitution' header)"
    return 1
  fi

  print_pass "Constitution is Blog-Tech-Kit v1.0.0"
  return 0
}

# Check 6: Script consistency (bash vs powershell)
check_script_consistency() {
  local extract_dir=$1
  local variant_name=$2
  local errors=0

  # Extract script type from variant name (sh or ps)
  local script_type=""
  if [[ $variant_name == *"-sh-"* ]]; then
    script_type="sh"
  elif [[ $variant_name == *"-ps-"* ]]; then
    script_type="ps"
  else
    print_warn "Could not determine script type from filename"
    return 0
  fi

  # Check script directories
  if [[ "$script_type" == "sh" ]]; then
    if [[ ! -d "$extract_dir/.blogkit/scripts/bash" ]]; then
      print_fail "Script type is 'sh' but no bash/ scripts directory found"
      return 1
    fi
    if [[ -d "$extract_dir/.blogkit/scripts/powershell" ]]; then
      print_warn "Script type is 'sh' but powershell/ directory found (should not exist)"
    fi
  elif [[ "$script_type" == "ps" ]]; then
    if [[ ! -d "$extract_dir/.blogkit/scripts/powershell" ]]; then
      print_fail "Script type is 'ps' but no powershell/ scripts directory found"
      return 1
    fi
    if [[ -d "$extract_dir/.blogkit/scripts/bash" ]]; then
      print_warn "Script type is 'ps' but bash/ directory found (should not exist)"
    fi
  fi

  print_pass "Script consistency check passed ($script_type)"
  return 0
}

# Check 7: ZIP integrity
check_zip_integrity() {
  local zip_file=$1

  if ! unzip -t "$zip_file" >/dev/null 2>&1; then
    print_fail "ZIP file is corrupted or invalid"
    return 1
  fi

  print_pass "ZIP file integrity verified"
  return 0
}

# Main validation function for a single variant
validate_variant() {
  local variant_path=$1
  local variant_name=$(basename "$variant_path" .zip)

  echo "Validating $variant_name..."

  # Create temporary extraction directory
  local temp_extract=$(mktemp -d)
  trap "rm -rf '$temp_extract'" RETURN

  # Check ZIP integrity first
  if ! check_zip_integrity "$variant_path"; then
    ((FAILED_VARIANTS++))
    FAILED_LIST="$FAILED_LIST\n  • $variant_name (ZIP corrupted)"
    return 1
  fi

  # Extract ZIP
  if ! unzip -q "$variant_path" -d "$temp_extract"; then
    ((FAILED_VARIANTS++))
    FAILED_LIST="$FAILED_LIST\n  • $variant_name (extraction failed)"
    return 1
  fi

  # Find the template root directory (the top-level directory in the ZIP)
  local template_root=$(find "$temp_extract" -mindepth 1 -maxdepth 1 -type d | head -1)
  if [[ -z "$template_root" ]]; then
    ((FAILED_VARIANTS++))
    FAILED_LIST="$FAILED_LIST\n  • $variant_name (no root directory found)"
    return 1
  fi

  # Run all validation checks
  local check_errors=0

  check_frontmatter_namespace "$template_root" "$variant_name" || ((check_errors++))
  check_required_files "$template_root" || ((check_errors++))
  check_content_references "$template_root" || ((check_errors++))
  check_directory_structure "$template_root" || ((check_errors++))
  check_constitution_version "$template_root" || ((check_errors++))
  check_script_consistency "$template_root" "$variant_name" || ((check_errors++))

  if [[ $check_errors -eq 0 ]]; then
    echo "  ✅ VALIDATION PASSED"
    ((PASSED_VARIANTS++))
    return 0
  else
    echo "  ⛔ VALIDATION FAILED ($check_errors checks)"
    ((FAILED_VARIANTS++))
    FAILED_LIST="$FAILED_LIST\n  • $variant_name"
    return 1
  fi
}

# Main entry point
main() {
  if [[ ! -e "$INPUT" ]]; then
    echo "Error: Input does not exist: $INPUT" >&2
    exit 1
  fi

  echo "╔════════════════════════════════════════════════════════════╗"
  echo "║     Blog-Tech-Kit Template Validator                      ║"
  echo "╚════════════════════════════════════════════════════════════╝"
  echo ""

  # Process input: single ZIP or directory of ZIPs
  if [[ -f "$INPUT" && "$INPUT" == *.zip ]]; then
    # Single ZIP file
    echo "Input: Single ZIP file"
    echo "File:  $(basename "$INPUT")"
    echo ""
    ((TOTAL_VARIANTS++))
    validate_variant "$INPUT" || true  # Don't exit on validation failure
  elif [[ -d "$INPUT" ]]; then
    # Directory of ZIPs
    local zip_count=$(find "$INPUT" -maxdepth 1 -name "*.zip" -type f | wc -l)
    echo "Input: Directory with $zip_count templates"
    echo "Path:  $INPUT"
    echo ""

    if [[ $zip_count -eq 0 ]]; then
      echo "⚠️  No ZIP files found in directory"
      exit 1
    fi

    TOTAL_VARIANTS=$zip_count

    # Process each ZIP file
    for zip_file in $(find "$INPUT" -maxdepth 1 -name "*.zip" -type f | sort); do
      validate_variant "$zip_file" || true  # Don't exit on validation failure
      echo ""
    done
  else
    echo "Error: Input must be a ZIP file or directory containing ZIPs" >&2
    exit 1
  fi

  # Print summary
  echo "╔════════════════════════════════════════════════════════════╗"
  echo "║                   VALIDATION SUMMARY                       ║"
  echo "╚════════════════════════════════════════════════════════════╝"
  echo ""
  echo "Total Variants:    $TOTAL_VARIANTS"
  echo "Passed:            $PASSED_VARIANTS"
  echo "Failed:            $FAILED_VARIANTS"
  echo ""

  if [[ $FAILED_VARIANTS -gt 0 ]]; then
    echo "Failed Templates:"
    echo -e "$FAILED_LIST"
    echo ""
    echo "❌ VALIDATION FAILED: $FAILED_VARIANTS template(s) have errors"
    exit 1
  else
    echo "✅ ALL VALIDATIONS PASSED"
    exit 0
  fi
}

main "$@"
