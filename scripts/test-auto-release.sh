#!/usr/bin/env bash
# test-auto-release.sh - Comprehensive test suite for Blog-Tech-Kit auto-release
# Tests build, validation, and package integrity

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Test output directory
TEST_DIR="/tmp/blogkit-test-$$"
EXTRACT_DIR="$TEST_DIR/extracted"

# Expected values
EXPECTED_AGENTS=17  # 17 agents in ALL_AGENTS array
EXPECTED_COMMANDS=9
EXPECTED_BASH_SCRIPTS=5
EXPECTED_PS_SCRIPTS=5
EXPECTED_TEMPLATES=4  # spec, plan, tasks, blog-post

# Function to get agent directory (bash 3.2 compatible)
get_agent_dir() {
  local agent=$1
  case "$agent" in
    claude) echo ".claude/commands" ;;
    cursor-agent) echo ".cursor/commands" ;;
    windsurf) echo ".windsurf/workflows" ;;
    gemini) echo ".gemini/commands" ;;
    copilot) echo ".github/agents" ;;
    qoder) echo ".qoder/commands" ;;
    qwen) echo ".qwen/commands" ;;
    opencode) echo ".opencode/command" ;;
    codex) echo ".codex/prompts" ;;
    kilocode) echo ".kilocode/workflows" ;;
    auggie) echo ".augment/commands" ;;
    roo) echo ".roo/commands" ;;
    codebuddy) echo ".codebuddy/commands" ;;
    amp) echo ".agents/commands" ;;
    shai) echo ".shai/commands" ;;
    q) echo ".amazonq/prompts" ;;
    bob) echo ".bob/commands" ;;
    *) echo ".${agent}/commands" ;;
  esac
}

log_pass() {
  echo -e "${GREEN}✅ PASS${NC}: $1"
  TESTS_PASSED=$((TESTS_PASSED + 1))
  TESTS_RUN=$((TESTS_RUN + 1))
}

log_fail() {
  echo -e "${RED}❌ FAIL${NC}: $1"
  TESTS_FAILED=$((TESTS_FAILED + 1))
  TESTS_RUN=$((TESTS_RUN + 1))
}

log_info() {
  echo -e "${YELLOW}ℹ️  INFO${NC}: $1"
}

cleanup() {
  if [[ -d "$TEST_DIR" ]]; then
    rm -rf "$TEST_DIR"
  fi
}

trap cleanup EXIT

# ============================================================================
# Phase 1: Source Directory Validation
# ============================================================================

test_source_directory() {
  echo ""
  echo "═══════════════════════════════════════════════════════════════════"
  echo "Phase 1: Source Directory Validation (.blogkit/)"
  echo "═══════════════════════════════════════════════════════════════════"
  
  # Test 1.1: Check .blogkit/ exists
  if [[ -d ".blogkit" ]]; then
    log_pass ".blogkit/ directory exists"
  else
    log_fail ".blogkit/ directory missing"
    return 1
  fi
  
  # Test 1.2: Check constitution exists and is Blog-Tech-Kit
  if [[ -f ".blogkit/memory/constitution.md" ]]; then
    if grep -q "Blog-Tech-Kit Constitution" ".blogkit/memory/constitution.md"; then
      log_pass "Constitution is Blog-Tech-Kit branded"
    else
      log_fail "Constitution is not Blog-Tech-Kit branded"
    fi
    
    if grep -q "Version.*1\.0\.0" ".blogkit/memory/constitution.md"; then
      log_pass "Constitution version is 1.0.0"
    else
      log_fail "Constitution version is not 1.0.0"
    fi
  else
    log_fail "Constitution file missing"
  fi
  
  # Test 1.3: Check command files count
  local cmd_count=$(ls -1 .blogkit/templates/commands/blogkit.*.md 2>/dev/null | wc -l | tr -d ' ')
  if [[ "$cmd_count" -eq "$EXPECTED_COMMANDS" ]]; then
    log_pass "Command files count: $cmd_count (expected: $EXPECTED_COMMANDS)"
  else
    log_fail "Command files count: $cmd_count (expected: $EXPECTED_COMMANDS)"
  fi
  
  # Test 1.4: Check bash scripts count
  local bash_count=$(ls -1 .blogkit/scripts/bash/*.sh 2>/dev/null | wc -l | tr -d ' ')
  if [[ "$bash_count" -eq "$EXPECTED_BASH_SCRIPTS" ]]; then
    log_pass "Bash scripts count: $bash_count (expected: $EXPECTED_BASH_SCRIPTS)"
  else
    log_fail "Bash scripts count: $bash_count (expected: $EXPECTED_BASH_SCRIPTS)"
  fi
  
  # Test 1.5: Check PowerShell scripts count
  local ps_count=$(ls -1 .blogkit/scripts/powershell/*.ps1 2>/dev/null | wc -l | tr -d ' ')
  if [[ "$ps_count" -eq "$EXPECTED_PS_SCRIPTS" ]]; then
    log_pass "PowerShell scripts count: $ps_count (expected: $EXPECTED_PS_SCRIPTS)"
  else
    log_fail "PowerShell scripts count: $ps_count (expected: $EXPECTED_PS_SCRIPTS)"
  fi
  
  # Test 1.6: Check blog-post-template.md exists
  if [[ -f ".blogkit/templates/blog-post-template.md" ]]; then
    log_pass "blog-post-template.md exists"
  else
    log_fail "blog-post-template.md missing"
  fi
  
  # Test 1.7: Check for speckit/pmfkit references in command files
  local speckit_refs=$(grep -r "speckit\." .blogkit/templates/commands/ 2>/dev/null | wc -l | tr -d ' ')
  if [[ "$speckit_refs" -eq 0 ]]; then
    log_pass "No speckit references in command files"
  else
    log_fail "Found $speckit_refs speckit references in command files"
    grep -rn "speckit\." .blogkit/templates/commands/ | head -3
  fi
}

# ============================================================================
# Phase 2: Build Script Validation
# ============================================================================

test_build_script() {
  echo ""
  echo "═══════════════════════════════════════════════════════════════════"
  echo "Phase 2: Build Script Validation"
  echo "═══════════════════════════════════════════════════════════════════"
  
  # Test 2.1: Check build script exists
  if [[ -f ".github/workflows/scripts/create-release-packages.sh" ]]; then
    log_pass "create-release-packages.sh exists"
  else
    log_fail "create-release-packages.sh missing"
    return 1
  fi
  
  # Test 2.2: Check script is executable
  if [[ -x ".github/workflows/scripts/create-release-packages.sh" ]]; then
    log_pass "create-release-packages.sh is executable"
  else
    log_fail "create-release-packages.sh is not executable"
  fi
  
  # Test 2.3: Check helper scripts exist
  for script in get-next-version.sh check-release-exists.sh generate-release-notes.sh create-github-release.sh; do
    if [[ -f ".github/workflows/scripts/$script" ]]; then
      log_pass "$script exists"
    else
      log_fail "$script missing"
    fi
  done
}

# ============================================================================
# Phase 3: Single Agent Build Test
# ============================================================================

test_single_agent_build() {
  echo ""
  echo "═══════════════════════════════════════════════════════════════════"
  echo "Phase 3: Single Agent Build Test (Claude bash)"
  echo "═══════════════════════════════════════════════════════════════════"
  
  mkdir -p "$TEST_DIR"
  
  # Build single variant
  log_info "Building claude-sh variant..."
  export GENRELEASES_DIR="$TEST_DIR"
  
  # Temporarily modify script to only build claude
  local VERSION="v0.0.0-test"
  
  # Create a minimal build for testing
  local variant_name="spec-kit-template-claude-sh-${VERSION}"
  local base_dir="$TEST_DIR/$variant_name"
  
  mkdir -p "$base_dir/.blogkit/memory"
  mkdir -p "$base_dir/.blogkit/templates"
  mkdir -p "$base_dir/.blogkit/scripts"
  mkdir -p "$base_dir/.claude/commands"
  
  cp .blogkit/memory/constitution.md "$base_dir/.blogkit/memory/"
  cp .blogkit/templates/*.md "$base_dir/.blogkit/templates/" 2>/dev/null || true
  cp -r .blogkit/scripts/bash "$base_dir/.blogkit/scripts/"
  
  # Generate commands manually for testing
  for template in .blogkit/templates/commands/blogkit.*.md; do
    local cmd_name=$(basename "$template" .md)
    local cmd_basename="${cmd_name#blogkit.}"
    local target_file="$base_dir/.claude/commands/blogkit.${cmd_basename}.md"
    
    sed "s/__AGENT__/blogkit.${cmd_basename}/g" "$template" | \
    sed "s/{SCRIPT}/sh/g" | \
    sed "s|\.specify/scripts/bash/|.blogkit/scripts/bash/|g" > "$target_file"
  done
  
  # Create ZIP
  (cd "$TEST_DIR" && zip -r "${variant_name}.zip" "$variant_name" > /dev/null)
  
  # Test 3.1: ZIP created
  if [[ -f "$TEST_DIR/${variant_name}.zip" ]]; then
    log_pass "ZIP file created"
  else
    log_fail "ZIP file not created"
    return 1
  fi
  
  # Extract and validate
  mkdir -p "$EXTRACT_DIR"
  unzip -q "$TEST_DIR/${variant_name}.zip" -d "$EXTRACT_DIR"
  
  local extracted="$EXTRACT_DIR/$variant_name"
  
  # Test 3.2: .blogkit/ directory exists
  if [[ -d "$extracted/.blogkit" ]]; then
    log_pass "Extracted package has .blogkit/ directory"
  else
    log_fail "Extracted package missing .blogkit/ directory"
  fi
  
  # Test 3.3: .claude/commands exists
  if [[ -d "$extracted/.claude/commands" ]]; then
    log_pass "Extracted package has .claude/commands/"
  else
    log_fail "Extracted package missing .claude/commands/"
  fi
  
  # Test 3.4: Command file count
  local ext_cmd_count=$(ls -1 "$extracted/.claude/commands/blogkit."*.md 2>/dev/null | wc -l | tr -d ' ')
  if [[ "$ext_cmd_count" -eq "$EXPECTED_COMMANDS" ]]; then
    log_pass "Extracted command count: $ext_cmd_count"
  else
    log_fail "Extracted command count: $ext_cmd_count (expected: $EXPECTED_COMMANDS)"
  fi
  
  # Test 3.5: Constitution copied correctly
  if grep -q "Blog-Tech-Kit Constitution" "$extracted/.blogkit/memory/constitution.md" 2>/dev/null; then
    log_pass "Constitution copied correctly"
  else
    log_fail "Constitution not copied or wrong content"
  fi
  
  # Test 3.6: blog-post-template.md present
  if [[ -f "$extracted/.blogkit/templates/blog-post-template.md" ]]; then
    log_pass "blog-post-template.md present in package"
  else
    log_fail "blog-post-template.md missing from package"
  fi
  
  # Test 3.7: Bash scripts present (not powershell)
  if [[ -d "$extracted/.blogkit/scripts/bash" ]]; then
    log_pass "bash/ scripts directory present"
  else
    log_fail "bash/ scripts directory missing"
  fi
  
  if [[ ! -d "$extracted/.blogkit/scripts/powershell" ]]; then
    log_pass "No powershell/ in sh variant (correct)"
  else
    log_fail "powershell/ incorrectly included in sh variant"
  fi
  
  # Test 3.8: No speckit references in extracted files
  local speckit_in_pkg=$(grep -r "speckit\." "$extracted/.claude/commands/" 2>/dev/null | wc -l | tr -d ' ')
  if [[ "$speckit_in_pkg" -eq 0 ]]; then
    log_pass "No speckit references in extracted commands"
  else
    log_fail "Found speckit references in extracted commands"
    grep -rn "speckit\." "$extracted/.claude/commands/" | head -3
  fi
  
  # Cleanup this test's files
  rm -rf "$EXTRACT_DIR"/*
  rm -f "$TEST_DIR/${variant_name}.zip"
  rm -rf "$base_dir"
}

# ============================================================================
# Phase 4: Full Build Test
# ============================================================================

test_full_build() {
  echo ""
  echo "═══════════════════════════════════════════════════════════════════"
  echo "Phase 4: Full Build Test (All 34 Variants)"
  echo "═══════════════════════════════════════════════════════════════════"
  
  log_info "Running full build..."
  
  export GENRELEASES_DIR="$TEST_DIR/full-build"
  mkdir -p "$GENRELEASES_DIR"
  
  # Run actual build script
  if bash .github/workflows/scripts/create-release-packages.sh "v0.0.0-test" > "$TEST_DIR/build.log" 2>&1; then
    log_pass "Build script completed successfully"
  else
    log_fail "Build script failed"
    cat "$TEST_DIR/build.log"
    return 1
  fi
  
  # Test 4.1: Count ZIP files
  local zip_count=$(ls -1 "$GENRELEASES_DIR"/*.zip 2>/dev/null | wc -l | tr -d ' ')
  local expected_zips=$((EXPECTED_AGENTS * 2))  # agents × 2 script types
  
  if [[ "$zip_count" -eq "$expected_zips" ]]; then
    log_pass "ZIP file count: $zip_count (expected: $expected_zips)"
  else
    log_fail "ZIP file count: $zip_count (expected: $expected_zips)"
    log_info "Generated files:"
    ls -1 "$GENRELEASES_DIR"/*.zip | head -10
  fi
  
  # Test 4.2: Spot-check different agents
  local agents_to_check=("claude" "gemini" "copilot" "cursor-agent")
  
  for agent in "${agents_to_check[@]}"; do
    local zip_file="$GENRELEASES_DIR/spec-kit-template-${agent}-sh-v0.0.0-test.zip"
    if [[ -f "$zip_file" ]]; then
      log_pass "${agent}-sh variant exists"
      
      # Extract and validate
      local extract_target="$TEST_DIR/check-${agent}"
      mkdir -p "$extract_target"
      unzip -q "$zip_file" -d "$extract_target"
      
      local expected_dir=$(get_agent_dir "$agent")
      local pkg_dir="$extract_target/spec-kit-template-${agent}-sh-v0.0.0-test"
      
      if [[ -d "$pkg_dir/$expected_dir" ]]; then
        log_pass "${agent} has correct agent directory: $expected_dir"
      else
        log_fail "${agent} missing agent directory: $expected_dir"
      fi
      
      rm -rf "$extract_target"
    else
      log_fail "${agent}-sh variant missing"
    fi
  done
  
  # Test 4.3: Verify PowerShell variant
  local ps_zip="$GENRELEASES_DIR/spec-kit-template-claude-ps-v0.0.0-test.zip"
  if [[ -f "$ps_zip" ]]; then
    local ps_extract="$TEST_DIR/check-ps"
    mkdir -p "$ps_extract"
    unzip -q "$ps_zip" -d "$ps_extract"
    
    local ps_pkg="$ps_extract/spec-kit-template-claude-ps-v0.0.0-test"
    
    if [[ -d "$ps_pkg/.blogkit/scripts/powershell" ]]; then
      log_pass "PowerShell variant has powershell/ scripts"
    else
      log_fail "PowerShell variant missing powershell/ scripts"
    fi
    
    if [[ ! -d "$ps_pkg/.blogkit/scripts/bash" ]]; then
      log_pass "PowerShell variant has no bash/ (correct)"
    else
      log_fail "PowerShell variant incorrectly has bash/"
    fi
    
    rm -rf "$ps_extract"
  fi
  
  # Test 4.4: Check TOML format for gemini
  local gemini_zip="$GENRELEASES_DIR/spec-kit-template-gemini-sh-v0.0.0-test.zip"
  if [[ -f "$gemini_zip" ]]; then
    local gemini_extract="$TEST_DIR/check-gemini"
    mkdir -p "$gemini_extract"
    unzip -q "$gemini_zip" -d "$gemini_extract"
    
    local gemini_pkg="$gemini_extract/spec-kit-template-gemini-sh-v0.0.0-test"
    local toml_count=$(ls -1 "$gemini_pkg/.gemini/commands/"*.toml 2>/dev/null | wc -l | tr -d ' ')
    
    if [[ "$toml_count" -eq "$EXPECTED_COMMANDS" ]]; then
      log_pass "Gemini has TOML command files: $toml_count"
    else
      log_fail "Gemini TOML count: $toml_count (expected: $EXPECTED_COMMANDS)"
    fi
    
    rm -rf "$gemini_extract"
  fi
}

# ============================================================================
# Phase 5: Content Integrity Tests
# ============================================================================

test_content_integrity() {
  echo ""
  echo "═══════════════════════════════════════════════════════════════════"
  echo "Phase 5: Content Integrity Tests"
  echo "═══════════════════════════════════════════════════════════════════"
  
  local zip_file="$TEST_DIR/full-build/spec-kit-template-claude-sh-v0.0.0-test.zip"
  if [[ ! -f "$zip_file" ]]; then
    log_fail "Cannot run content tests - no build output"
    return 1
  fi
  
  local content_extract="$TEST_DIR/content-check"
  mkdir -p "$content_extract"
  unzip -q "$zip_file" -d "$content_extract"
  
  local pkg="$content_extract/spec-kit-template-claude-sh-v0.0.0-test"
  
  # Test 5.1: Check all required command files exist
  local required_cmds=("specify" "plan" "tasks" "implement" "analyze" "checklist" "clarify" "constitution" "taskstoissues")
  
  for cmd in "${required_cmds[@]}"; do
    if [[ -f "$pkg/.claude/commands/blogkit.${cmd}.md" ]]; then
      log_pass "Command file exists: blogkit.${cmd}.md"
    else
      log_fail "Command file missing: blogkit.${cmd}.md"
    fi
  done
  
  # Test 5.2: Check frontmatter in command files
  local specify_file="$pkg/.claude/commands/blogkit.specify.md"
  if [[ -f "$specify_file" ]]; then
    if head -10 "$specify_file" | grep -q "description"; then
      log_pass "blogkit.specify.md has frontmatter"
    else
      log_fail "blogkit.specify.md missing frontmatter"
    fi
  fi
  
  # Test 5.3: Check no .specify paths in scripts
  local specify_refs=$(grep -r "\.specify/" "$pkg/.blogkit/scripts/" 2>/dev/null | grep -v "\.blogkit/" | wc -l | tr -d ' ')
  if [[ "$specify_refs" -eq 0 ]]; then
    log_pass "No .specify/ paths in scripts"
  else
    log_fail "Found .specify/ paths in scripts"
    grep -rn "\.specify/" "$pkg/.blogkit/scripts/" | head -3
  fi
  
  # Test 5.4: ZIP integrity - can re-extract
  if unzip -t "$zip_file" > /dev/null 2>&1; then
    log_pass "ZIP file integrity check passed"
  else
    log_fail "ZIP file is corrupted"
  fi
  
  rm -rf "$content_extract"
}

# ============================================================================
# Phase 6: Compare with Reference Package
# ============================================================================

test_compare_reference() {
  echo ""
  echo "═══════════════════════════════════════════════════════════════════"
  echo "Phase 6: Compare with Reference Package (spec-kit v0.0.89)"
  echo "═══════════════════════════════════════════════════════════════════"
  
  local ref_zip="/Users/frank/kits/twitter-init-kit/spec-kit-template-claude-sh-v0.0.89.zip"
  
  if [[ ! -f "$ref_zip" ]]; then
    log_info "Reference package not found - skipping comparison tests"
    return 0
  fi
  
  local ref_extract="$TEST_DIR/ref-extract"
  mkdir -p "$ref_extract"
  unzip -q "$ref_zip" -d "$ref_extract"
  
  # Reference zip extracts directly (no subdirectory)
  local ref_pkg="$ref_extract"
  
  if [[ ! -d "$ref_pkg/.specify" ]] && [[ ! -d "$ref_pkg/.claude" ]]; then
    log_fail "Could not find reference package contents"
    return 1
  fi
  
  # Test 6.1: Reference has .specify/, we have .blogkit/
  if [[ -d "$ref_pkg/.specify" ]]; then
    log_pass "Reference uses .specify/ (correct for spec-kit)"
  fi
  
  # Test 6.2: Check reference command count matches ours
  local ref_cmd_count=$(ls -1 "$ref_pkg/.claude/commands/"speckit.*.md 2>/dev/null | wc -l | tr -d ' ')
  log_info "Reference has $ref_cmd_count command files"
  
  if [[ "$ref_cmd_count" -eq "$EXPECTED_COMMANDS" ]]; then
    log_pass "Command count matches reference"
  else
    log_info "Command count differs from reference ($ref_cmd_count vs $EXPECTED_COMMANDS)"
  fi
  
  # Test 6.3: Compare script structure
  local ref_bash_count=$(ls -1 "$ref_pkg/.specify/scripts/bash/"*.sh 2>/dev/null | wc -l | tr -d ' ')
  log_info "Reference has $ref_bash_count bash scripts"
  
  rm -rf "$ref_extract"
}

# ============================================================================
# Main Test Runner
# ============================================================================

main() {
  echo ""
  echo "╔═══════════════════════════════════════════════════════════════════╗"
  echo "║        Blog-Tech-Kit Auto-Release Test Suite                      ║"
  echo "║        Testing build, validation, and package integrity           ║"
  echo "╚═══════════════════════════════════════════════════════════════════╝"
  echo ""
  echo "Test directory: $TEST_DIR"
  echo "Started at: $(date)"
  
  # Run all test phases
  test_source_directory
  test_build_script
  test_single_agent_build
  test_full_build
  test_content_integrity
  test_compare_reference
  
  # Summary
  echo ""
  echo "═══════════════════════════════════════════════════════════════════"
  echo "TEST SUMMARY"
  echo "═══════════════════════════════════════════════════════════════════"
  echo ""
  echo "Total tests run: $TESTS_RUN"
  echo -e "Passed: ${GREEN}$TESTS_PASSED${NC}"
  echo -e "Failed: ${RED}$TESTS_FAILED${NC}"
  echo ""
  
  if [[ "$TESTS_FAILED" -eq 0 ]]; then
    echo -e "${GREEN}════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}  ALL TESTS PASSED - Auto-release is ready for deployment!         ${NC}"
    echo -e "${GREEN}════════════════════════════════════════════════════════════════════${NC}"
    exit 0
  else
    echo -e "${RED}════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${RED}  TESTS FAILED - Please fix issues before releasing                 ${NC}"
    echo -e "${RED}════════════════════════════════════════════════════════════════════${NC}"
    exit 1
  fi
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
