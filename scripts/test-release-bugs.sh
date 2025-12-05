#!/usr/bin/env bash
# Test script to verify release workflow bugs

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

TESTS_PASSED=0
TESTS_FAILED=0

log_pass() {
  echo -e "${GREEN}✅ PASS${NC}: $1"
  TESTS_PASSED=$((TESTS_PASSED + 1))
}

log_fail() {
  echo -e "${RED}❌ FAIL${NC}: $1"
  TESTS_FAILED=$((TESTS_FAILED + 1))
}

echo "=========================================="
echo "Testing Release Workflow Bugs"
echo "=========================================="
echo ""

# Test 1: Check package naming in create-release-packages.sh
echo "--- Test 1: Package Naming ---"
if grep -q 'spec-kit-template-' .github/workflows/scripts/create-release-packages.sh; then
  log_fail "Package uses 'spec-kit-template-' instead of 'blog-tech-kit-template-'"
  echo "  Found: $(grep 'spec-kit-template-' .github/workflows/scripts/create-release-packages.sh | head -1)"
else
  log_pass "Package naming is correct (blog-tech-kit-template-*)"
fi

# Test 2: Check workflow logic for check-release-exists
echo ""
echo "--- Test 2: Workflow Check-Release Logic ---"

# The workflow should NOT have if/else that overwrites script output
if grep -A5 'check-release-exists.sh' .github/workflows/release.yml | grep -q 'echo "exists=true"'; then
  log_fail "Workflow overwrites script output with hardcoded 'exists=true'"
  echo "  The workflow's if-then-else logic always sets exists=true because script exits 0"
else
  log_pass "Workflow correctly uses script output"
fi

# Test 3: Check that check-release-exists.sh uses GITHUB_OUTPUT correctly
echo ""
echo "--- Test 3: check-release-exists.sh Output ---"
# Script should write exists=true or exists=false to GITHUB_OUTPUT
if grep -q 'GITHUB_OUTPUT' .github/workflows/scripts/check-release-exists.sh; then
  log_pass "check-release-exists.sh writes to GITHUB_OUTPUT"
else
  log_fail "check-release-exists.sh does not use GITHUB_OUTPUT"
fi

# Test 4: Verify validation in workflow uses correct package names
echo ""
echo "--- Test 4: Workflow Validation Package Names ---"
if grep -q 'spec-kit-template-claude-sh-' .github/workflows/release.yml; then
  log_fail "Workflow validation references 'spec-kit-template-' instead of 'blog-tech-kit-template-'"
else
  log_pass "Workflow validation uses correct package names"
fi

# Test 5: Check README references correct package names
echo ""
echo "--- Test 5: README Package Names ---"
if grep -q 'spec-kit-template-' README.md; then
  log_fail "README references 'spec-kit-template-' packages"
  echo "  Downloads should point to blog-tech-kit-template-* packages"
else
  log_pass "README uses correct package names"
fi

# Test 6: Run a quick local build to verify package names
echo ""
echo "--- Test 6: Local Build Test ---"
TEST_DIR="/tmp/blogkit-release-test-$$"
mkdir -p "$TEST_DIR"

# Run build script with test version
GENRELEASES_DIR="$TEST_DIR" .github/workflows/scripts/create-release-packages.sh "v0.0.0-test" > /dev/null 2>&1 || true

if ls "$TEST_DIR"/*.zip 2>/dev/null | head -1 | grep -q "blog-tech-kit-template-"; then
  log_pass "Generated packages use 'blog-tech-kit-template-' naming"
else
  SAMPLE=$(ls "$TEST_DIR"/*.zip 2>/dev/null | head -1 | xargs basename 2>/dev/null || echo "none")
  log_fail "Generated packages use wrong naming: $SAMPLE"
fi

rm -rf "$TEST_DIR"

# Summary
echo ""
echo "=========================================="
echo "TEST SUMMARY"
echo "=========================================="
echo "Passed: $TESTS_PASSED"
echo "Failed: $TESTS_FAILED"
echo ""

if [[ $TESTS_FAILED -gt 0 ]]; then
  echo -e "${RED}BUGS FOUND - Fixes Required${NC}"
  exit 1
else
  echo -e "${GREEN}ALL TESTS PASSED${NC}"
  exit 0
fi
