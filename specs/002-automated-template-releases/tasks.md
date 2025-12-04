# Tasks: Automated Template Release Generation

**Feature**: Automated template release generation for multiple AI agents
**Branch**: 002-automated-template-releases
**Created**: 2025-12-04
**Status**: Ready for Implementation

---

## Task Organization

Tasks are grouped by implementation phase and ordered by dependencies. Each task includes:
- **ID**: Unique task identifier
- **Phase**: Implementation phase (1-4)
- **Priority**: P0 (critical path), P1 (high), P2 (medium), P3 (low)
- **Estimated Time**: Time to complete
- **Dependencies**: Tasks that must complete first
- **Acceptance Criteria**: How to verify completion

---

## Phase 1: Local Build Infrastructure (2-3 days)

### 🔨 Task 1.1: Create Local Build Script

**ID**: TMPL-001
**Priority**: P0 (Critical Path)
**Estimated Time**: 3 hours
**Dependencies**: None
**Owner**: Dev
**Status**: Not Started

**Description**:
Create `scripts/build-templates.sh` wrapper script that enables local template generation for testing before CI integration.

**Implementation Steps**:
1. Create new file: `scripts/build-templates.sh`
2. Add shebang and error handling: `#!/usr/bin/env bash` and `set -euo pipefail`
3. Parse version argument with validation (must match `v[0-9]+\.[0-9]+\.[0-9]+`)
4. Create `dist/templates/` output directory
5. Set `GENRELEASES_DIR=dist/templates` environment variable
6. Call `.github/workflows/scripts/create-release-packages.sh` with version
7. Add `generate_manifest()` function to create build-manifest.json
8. Display summary with file sizes and checksums

**Files to Create**:
- `scripts/build-templates.sh` (new, ~150 lines)

**Acceptance Criteria**:
- ✅ Script accepts version argument (e.g., `v0.1.0-test`)
- ✅ Creates `dist/templates/` directory
- ✅ Supports AGENTS env var (e.g., `AGENTS=claude,gemini`)
- ✅ Supports SCRIPTS env var (e.g., `SCRIPTS=sh`)
- ✅ Generates build-manifest.json with all variant metadata
- ✅ Returns exit code 0 on success, non-zero on failure
- ✅ Displays human-readable summary at end

**Testing**:
```bash
# Test basic usage
./scripts/build-templates.sh v0.1.0-test

# Test agent filtering
AGENTS=claude ./scripts/build-templates.sh v0.1.0-test

# Test script filtering
SCRIPTS=sh ./scripts/build-templates.sh v0.1.0-test

# Verify manifest created
cat dist/templates/build-manifest.json | jq '.variants | length'
```

---

### 📝 Task 1.2: Update Command Templates for blog-Kit Namespace

**ID**: TMPL-002
**Priority**: P0 (Critical Path)
**Estimated Time**: 2 hours
**Dependencies**: None (can run parallel to TMPL-001)
**Owner**: Dev
**Status**: Not Started

**Description**:
Update all command template files in `templates/commands/` to ensure they use blog-Kit branding and `/blogkit.*` namespace instead of spec-kit references.

**Implementation Steps**:
1. Review each `.md` file in `templates/commands/` directory
2. For each file:
   - Verify frontmatter uses `agent: __AGENT__` placeholder
   - Check body text for `/speckit.` references → replace with `/blogkit.`
   - Verify path references use .specify/ prefix
   - Confirm `scripts.sh` and `scripts.ps` point to correct bash/powershell directories
   - Ensure descriptions mention blog-Kit (not Spec-Kit)
3. Verify YAML frontmatter structure is valid
4. Test template variable substitution

**Files to Update**:
- `templates/commands/specify.md`
- `templates/commands/plan.md`
- `templates/commands/tasks.md`
- `templates/commands/implement.md`
- `templates/commands/clarify.md`
- `templates/commands/analyze.md`
- `templates/commands/checklist.md`
- `templates/commands/taskstoissues.md`
- `templates/commands/constitution.md`

**Validation Commands**:
```bash
# Check for spec-kit references (should return nothing)
grep -r "speckit\." templates/commands/ && echo "❌ Found speckit references"

# Check for correct agent placeholder
grep -L "__AGENT__" templates/commands/*.md && echo "⚠️  Missing agent placeholder"

# Verify path references
grep -r "memory/" templates/commands/ | grep -v ".specify/memory/" && echo "⚠️  Missing .specify prefix"
```

**Acceptance Criteria**:
- ✅ All 9 command files use `agent: __AGENT__` placeholder in frontmatter
- ✅ Zero occurrences of `/speckit.` in command bodies
- ✅ All path references use `.specify/` prefix (memory/ → .specify/memory/)
- ✅ Script commands point to bash/ or powershell/ subdirectories
- ✅ Descriptions mention "blog-Kit" not "Spec-Kit"
- ✅ YAML frontmatter parses without errors

---

### ✅ Task 1.3: Test Local Build with Single Agent Variant

**ID**: TMPL-003
**Priority**: P0 (Critical Path)
**Estimated Time**: 1 hour
**Dependencies**: TMPL-001, TMPL-002
**Owner**: Dev/QA
**Status**: Not Started

**Description**:
Validate that the build process correctly generates a single template variant by testing with Claude (bash) before attempting all 36 variants.

**Implementation Steps**:
1. Run build script with single agent: `AGENTS=claude SCRIPTS=sh ./scripts/build-templates.sh v0.1.0-test`
2. Verify ZIP file created: `dist/templates/spec-kit-template-claude-sh-v0.1.0-test.zip`
3. Extract ZIP to temporary directory: `unzip -d /tmp/test-claude dist/templates/spec-kit-template-claude-sh-v0.1.0-test.zip`
4. Manually inspect directory structure
5. Verify all required files present
6. Check for spec-kit references in extracted files
7. Verify constitution is blog-Kit v1.0.0
8. Check command file frontmatter uses `blogkit.*` namespace

**Test Checklist**:
```bash
# 1. Build single variant
AGENTS=claude SCRIPTS=sh ./scripts/build-templates.sh v0.1.0-test

# 2. Extract
unzip -d /tmp/test-claude dist/templates/spec-kit-template-claude-sh-v0.1.0-test.zip

# 3. Check structure
ls -la /tmp/test-claude/.specify/
ls -la /tmp/test-claude/.claude/commands/

# 4. Verify required directories exist
test -d /tmp/test-claude/.specify/memory && echo "✅ memory/"
test -d /tmp/test-claude/.specify/scripts/bash && echo "✅ scripts/bash/"
test -d /tmp/test-claude/.specify/templates && echo "✅ templates/"
test -d /tmp/test-claude/.claude/commands && echo "✅ .claude/commands/"

# 5. Check for spec-kit references
grep -r "speckit" /tmp/test-claude/ && echo "❌ Found speckit references" || echo "✅ No speckit references"

# 6. Verify frontmatter
head -5 /tmp/test-claude/.claude/commands/blogkit.specify.md
# Should show: agent: blogkit.specify

# 7. Count command files
ls /tmp/test-claude/.claude/commands/blogkit.*.md | wc -l
# Should output: 9

# 8. Verify constitution
grep "blog-Kit Constitution" /tmp/test-claude/.specify/memory/constitution.md
grep "Version: 1.0.0" /tmp/test-claude/.specify/memory/constitution.md
```

**Acceptance Criteria**:
- ✅ ZIP file extracts without errors
- ✅ Directory structure matches expected layout (.specify/ and .claude/)
- ✅ All 9 command files present: specify, plan, tasks, implement, clarify, analyze, checklist, taskstoissues, constitution
- ✅ Command files use `blogkit.*` naming and namespace
- ✅ Constitution is blog-Kit v1.0.0 (not Spec-Kit)
- ✅ Zero occurrences of "speckit" in extracted files
- ✅ Scripts directory contains only bash/ (not powershell/)
- ✅ Template files present: spec-template.md, plan-template.md, tasks-template.md

**Blockers**: If this test fails, do NOT proceed to Task 1.4. Fix issues first.

---

### 🏗️ Task 1.4: Test Full Build with All 36 Variants

**ID**: TMPL-004
**Priority**: P0 (Critical Path)
**Estimated Time**: 2 hours
**Dependencies**: TMPL-003 (must pass)
**Owner**: Dev/QA
**Status**: Not Started

**Description**:
Validate that all 36 template variants (18 agents × 2 script types) generate correctly and consistently.

**Implementation Steps**:
1. Run full build: `./scripts/build-templates.sh v0.1.0-test`
2. Verify 36 ZIP files created
3. Check build-manifest.json contains all variants
4. Verify no failed variants in manifest
5. Spot-check 4 different variants for correctness:
   - Claude (sh): Markdown commands in .claude/commands/
   - Gemini (ps): TOML commands in .gemini/commands/ with {{args}} format
   - Copilot (sh): Agent files in .github/agents/ + prompts in .github/prompts/
   - Cursor (ps): Markdown commands in .cursor/commands/
6. Calculate total archive size
7. Verify checksums are unique for each variant

**Test Script**:
```bash
# 1. Full build
./scripts/build-templates.sh v0.1.0-test

# 2. Count ZIPs
ZIP_COUNT=$(ls dist/templates/*.zip | wc -l)
echo "ZIP files created: $ZIP_COUNT"
test $ZIP_COUNT -eq 36 && echo "✅ Correct count" || echo "❌ Expected 36, got $ZIP_COUNT"

# 3. Check manifest
cat dist/templates/build-manifest.json | jq '.variants | length'
# Should output: 36

# 4. Check for failures
FAILED=$(cat dist/templates/build-manifest.json | jq '.failed_variants | length')
test $FAILED -eq 0 && echo "✅ No failures" || echo "❌ $FAILED variants failed"

# 5. Spot-check Claude
unzip -q -d /tmp/spot-claude dist/templates/spec-kit-template-claude-sh-v0.1.0-test.zip
ls /tmp/spot-claude/.claude/commands/blogkit.*.md | wc -l
# Should output: 9

# 6. Spot-check Gemini
unzip -q -d /tmp/spot-gemini dist/templates/spec-kit-template-gemini-ps-v0.1.0-test.zip
ls /tmp/spot-gemini/.gemini/commands/blogkit.*.toml | wc -l
# Should output: 9
grep "{{args}}" /tmp/spot-gemini/.gemini/commands/blogkit.specify.toml
# Should find {{args}} format

# 7. Spot-check Copilot
unzip -q -d /tmp/spot-copilot dist/templates/spec-kit-template-copilot-sh-v0.1.0-test.zip
test -d /tmp/spot-copilot/.github/agents && echo "✅ Has agents/"
test -d /tmp/spot-copilot/.github/prompts && echo "✅ Has prompts/"
ls /tmp/spot-copilot/.github/agents/blogkit.*.agent.md | wc -l
# Should output: 9

# 8. Spot-check Cursor
unzip -q -d /tmp/spot-cursor dist/templates/spec-kit-template-cursor-agent-ps-v0.1.0-test.zip
test -d /tmp/spot-cursor/.specify/scripts/powershell && echo "✅ Has powershell/"
test ! -d /tmp/spot-cursor/.specify/scripts/bash && echo "✅ No bash/ directory"

# 9. Verify total size
du -sh dist/templates/
# Should be around 2-3 MB

# 10. Check checksums are unique
cat dist/templates/build-manifest.json | jq -r '.variants[].sha256' | sort | uniq -d
# Should output nothing (no duplicates)
```

**Acceptance Criteria**:
- ✅ Exactly 36 ZIP files generated
- ✅ build-manifest.json shows all 36 variants with status "completed"
- ✅ Zero variants in failed_variants array
- ✅ Each agent has correct directory structure and file format:
  - Markdown agents (.md files): claude, cursor-agent, windsurf, opencode, codex, kilocode, auggie, roo, codebuddy, qoder, amp, shai, q, bob
  - TOML agents (.toml files): gemini, qwen
  - Special agents: copilot (.agent.md + .prompt.md)
- ✅ Bash variants only contain scripts/bash/, PowerShell variants only contain scripts/powershell/
- ✅ Total archive size is reasonable (~2-3 MB for all 36)
- ✅ All SHA-256 checksums are unique
- ✅ All checksums are 64 hexadecimal characters

**Blockers**: If failures occur, check build-manifest.json for which variants failed and fix those specific agent configurations.

---

## Phase 2: Validation Infrastructure (2 days)

### 🛡️ Task 2.1: Create Template Validation Script

**ID**: TMPL-005
**Priority**: P0 (Critical Path)
**Estimated Time**: 4 hours
**Dependencies**: TMPL-004 (full build works)
**Owner**: Dev
**Status**: Not Started

**Description**:
Create automated validation script that verifies template quality before release. This prevents publishing templates with wrong namespace, missing files, or structural issues.

**Implementation Steps**:
1. Create `scripts/validate-templates.sh`
2. Implement validation functions:
   - `check_frontmatter_namespace()`: Verify all commands use `agent: blogkit.*`
   - `check_required_files()`: Verify constitution, templates, scripts, commands present
   - `check_content_references()`: Scan for unintended `/speckit.` references
   - `check_directory_structure()`: Verify .specify/ and agent directories exist
   - `check_constitution_version()`: Verify blog-Kit constitution v1.0.0
   - `check_script_consistency()`: Ensure sh has bash/, ps has powershell/
   - `check_command_count()`: Verify 9 required commands present
   - `check_zip_integrity()`: Test ZIP extracts without errors
3. Add validation report generation (JSON output)
4. Support validating single ZIP or directory of ZIPs
5. Add verbose and quiet modes

**Script Structure**:
```bash
#!/usr/bin/env bash
set -euo pipefail

# Usage: ./scripts/validate-templates.sh <dir-or-zip> [--verbose] [--json]

# Global counters
TOTAL_VARIANTS=0
PASSED_VARIANTS=0
FAILED_VARIANTS=0

# Validation functions
check_frontmatter_namespace() {
  local extract_dir=$1
  local agent_dir=$2
  local errors=0

  # Find all command files
  find "$extract_dir/$agent_dir" -name "blogkit.*.md" -o -name "blogkit.*.toml" -o -name "blogkit.*.agent.md" | while read -r file; do
    # Extract agent: line from frontmatter
    agent_line=$(sed -n '/^---$/,/^---$/p' "$file" | grep '^agent:' || true)

    if [[ -z "$agent_line" ]]; then
      echo "    ❌ No agent: frontmatter in $(basename "$file")"
      ((errors++))
      continue
    fi

    if [[ ! "$agent_line" =~ agent:[[:space:]]*blogkit\. ]]; then
      echo "    ❌ Wrong namespace in $(basename "$file"): $agent_line"
      ((errors++))
    fi
  done

  return $errors
}

check_required_files() {
  local extract_dir=$1
  local errors=0

  # Required files
  local required_files=(
    ".specify/memory/constitution.md"
    ".specify/templates/spec-template.md"
    ".specify/templates/plan-template.md"
    ".specify/templates/tasks-template.md"
  )

  for file in "${required_files[@]}"; do
    if [[ ! -f "$extract_dir/$file" ]]; then
      echo "    ❌ Missing required file: $file"
      ((errors++))
    fi
  done

  return $errors
}

# ... more validation functions ...

validate_variant() {
  local variant_path=$1
  local variant_name=$(basename "$variant_path" .zip)
  local errors=0
  local warnings=0

  echo "Validating $variant_name..."

  # Extract ZIP to temp directory
  local temp_dir=$(mktemp -d)
  trap "rm -rf $temp_dir" EXIT

  if ! unzip -q "$variant_path" -d "$temp_dir"; then
    echo "  ❌ ZIP extraction FAILED"
    return 1
  fi

  # Detect agent directory
  local agent_dir=$(find "$temp_dir" -maxdepth 1 -type d -name ".*" ! -name ".specify" | head -1)

  # Run all validation checks
  check_frontmatter_namespace "$temp_dir" "$agent_dir" || ((errors++))
  check_required_files "$temp_dir" || ((errors++))
  check_content_references "$temp_dir" || ((errors++))
  check_directory_structure "$temp_dir" "$agent_dir" || ((errors++))
  check_constitution_version "$temp_dir" || ((errors++))
  check_script_consistency "$temp_dir" "$variant_name" || ((errors++))
  check_command_count "$temp_dir" "$agent_dir" || ((errors++))

  if [[ $errors -gt 0 ]]; then
    echo "  ⛔ VALIDATION FAILED ($errors errors, $warnings warnings)"
    return 1
  else
    echo "  ✅ VALIDATION PASSED ($warnings warnings)"
    return 0
  fi
}

main() {
  local input_path=$1
  local total_errors=0

  if [[ -f "$input_path" ]] && [[ "$input_path" == *.zip ]]; then
    validate_variant "$input_path" || ((total_errors++))
  elif [[ -d "$input_path" ]]; then
    for zip in "$input_path"/*.zip; do
      [[ -f "$zip" ]] || continue
      validate_variant "$zip" || ((total_errors++))
    done
  else
    echo "Error: Input must be a ZIP file or directory containing ZIPs" >&2
    exit 1
  fi

  if [[ $total_errors -gt 0 ]]; then
    echo ""
    echo "❌ VALIDATION FAILED: $total_errors variants have errors"
    exit 1
  else
    echo ""
    echo "✅ ALL VALIDATIONS PASSED"
    exit 0
  fi
}

main "$@"
```

**Files to Create**:
- `scripts/validate-templates.sh` (new, ~400 lines)

**Acceptance Criteria**:
- ✅ Script accepts directory path or single ZIP file
- ✅ Implements all 9 validation checks (frontmatter, required files, content, structure, constitution, scripts, commands, ZIP integrity, checksum)
- ✅ Returns exit code 0 if all variants pass, non-zero if any fail
- ✅ Provides clear error messages indicating which check failed and why
- ✅ Supports --verbose flag for detailed output
- ✅ Supports --json flag for machine-readable output
- ✅ Can validate 36 variants in under 2 minutes

---

### 🧪 Task 2.2: Create Validation Test Cases

**ID**: TMPL-006
**Priority**: P1 (High)
**Estimated Time**: 3 hours
**Dependencies**: TMPL-005
**Owner**: QA/Dev
**Status**: Not Started

**Description**:
Create test cases with intentionally broken templates to verify the validation script catches common errors.

**Implementation Steps**:
1. Create `test-data/` directory for test fixtures
2. Generate valid template as baseline
3. Create 5 negative test cases:
   - Wrong namespace: Edit command to use `agent: speckit.specify`
   - Missing file: Remove constitution.md
   - Speckit reference: Add `/speckit.plan` to command body
   - Wrong scripts: Include both bash/ and powershell/ in sh variant
   - Malformed ZIP: Corrupt ZIP archive
4. Create test runner script
5. Document expected results

**Test Cases**:

**Test 1: Wrong Namespace**
```bash
# Create test variant
AGENTS=claude SCRIPTS=sh ./scripts/build-templates.sh v0.1.0-test
cp dist/templates/spec-kit-template-claude-sh-v0.1.0-test.zip test-data/

# Modify it
unzip -q test-data/spec-kit-template-claude-sh-v0.1.0-test.zip -d test-data/wrong-namespace/
sed -i 's/agent: blogkit\.specify/agent: speckit.specify/' test-data/wrong-namespace/.claude/commands/blogkit.specify.md
cd test-data/wrong-namespace && zip -r ../invalid-namespace.zip . && cd -

# Test validation
./scripts/validate-templates.sh test-data/invalid-namespace.zip
# Expected: FAIL with "Wrong namespace" error
```

**Test 2: Missing Required File**
```bash
# Create and modify
unzip -q dist/templates/spec-kit-template-claude-sh-v0.1.0-test.zip -d test-data/missing-file/
rm test-data/missing-file/.specify/memory/constitution.md
cd test-data/missing-file && zip -r ../missing-constitution.zip . && cd -

# Test validation
./scripts/validate-templates.sh test-data/missing-constitution.zip
# Expected: FAIL with "Missing required file: .specify/memory/constitution.md"
```

**Test 3: Speckit Reference in Content**
```bash
# Create and modify
unzip -q dist/templates/spec-kit-template-claude-sh-v0.1.0-test.zip -d test-data/speckit-ref/
echo "Run /speckit.plan to continue" >> test-data/speckit-ref/.claude/commands/blogkit.specify.md
cd test-data/speckit-ref && zip -r ../speckit-reference.zip . && cd -

# Test validation
./scripts/validate-templates.sh test-data/speckit-reference.zip
# Expected: FAIL with "Found speckit reference"
```

**Test 4: Wrong Script Directory**
```bash
# Create sh variant but include powershell scripts
AGENTS=claude SCRIPTS=sh ./scripts/build-templates.sh v0.1.0-test
unzip -q dist/templates/spec-kit-template-claude-sh-v0.1.0-test.zip -d test-data/wrong-scripts/
mkdir -p test-data/wrong-scripts/.specify/scripts/powershell
cp test-data/wrong-scripts/.specify/scripts/bash/common.sh test-data/wrong-scripts/.specify/scripts/powershell/common.ps1
cd test-data/wrong-scripts && zip -r ../wrong-scripts.zip . && cd -

# Test validation
./scripts/validate-templates.sh test-data/wrong-scripts.zip
# Expected: WARN or FAIL (depending on strictness)
```

**Test 5: Valid Template**
```bash
# Test with valid template
./scripts/validate-templates.sh dist/templates/spec-kit-template-claude-sh-v0.1.0-test.zip
# Expected: PASS
```

**Test Runner**:
```bash
#!/usr/bin/env bash
# test-validation.sh

run_test() {
  local test_name=$1
  local test_zip=$2
  local expected=$3  # "pass" or "fail"

  echo "Running: $test_name"
  if ./scripts/validate-templates.sh "$test_zip" >/dev/null 2>&1; then
    result="PASS"
  else
    result="FAIL"
  fi

  if [[ "$result" == "$expected" ]]; then
    echo "  ✅ Test passed (expected $expected, got $result)"
    return 0
  else
    echo "  ❌ Test failed (expected $expected, got $result)"
    return 1
  fi
}

# Run all tests
total_errors=0
run_test "Wrong Namespace" "test-data/invalid-namespace.zip" "fail" || ((total_errors++))
run_test "Missing File" "test-data/missing-constitution.zip" "fail" || ((total_errors++))
run_test "Speckit Reference" "test-data/speckit-reference.zip" "fail" || ((total_errors++))
run_test "Wrong Scripts" "test-data/wrong-scripts.zip" "fail" || ((total_errors++))
run_test "Valid Template" "dist/templates/spec-kit-template-claude-sh-v0.1.0-test.zip" "pass" || ((total_errors++))

if [[ $total_errors -eq 0 ]]; then
  echo "✅ All validation tests passed"
  exit 0
else
  echo "❌ $total_errors validation tests failed"
  exit 1
fi
```

**Files to Create**:
- `test-data/` directory with test fixtures
- `test-validation.sh` test runner script

**Acceptance Criteria**:
- ✅ All 4 negative tests (invalid templates) cause validation to fail
- ✅ Positive test (valid template) passes validation
- ✅ Error messages clearly explain what's wrong
- ✅ Test runner can run all tests automatically
- ✅ Tests are reproducible (can run multiple times)

---

### 🔗 Task 2.3: Integrate Validation into Build Script

**ID**: TMPL-007
**Priority**: P0 (Critical Path)
**Estimated Time**: 30 minutes
**Dependencies**: TMPL-005, TMPL-006 (validation script tested)
**Owner**: Dev
**Status**: Not Started

**Description**:
Modify the build script to automatically run validation after generating all templates, failing the build if validation fails.

**Implementation Steps**:
1. Open `scripts/build-templates.sh`
2. After template generation completes, add validation step
3. Exit with error if validation fails
4. Display clear success/failure message

**Code Changes**:
```bash
# In scripts/build-templates.sh, after generate_manifest()

echo ""
echo "Validating templates..."
if ./scripts/validate-templates.sh "$DIST_DIR"; then
  echo "✅ All templates passed validation"
  echo ""
  echo "Build complete! Templates available in $DIST_DIR/"
  exit 0
else
  echo "❌ Validation failed - review errors above"
  echo "Templates were built but did not pass validation."
  echo "Fix errors and rebuild before releasing."
  exit 1
fi
```

**Files to Modify**:
- `scripts/build-templates.sh` (add ~10 lines)

**Testing**:
```bash
# Test that validation runs automatically
./scripts/build-templates.sh v0.1.0-test

# Should see:
# - Build progress messages
# - "Validating templates..." message
# - Individual validation results
# - Final "All templates passed validation" or error
```

**Acceptance Criteria**:
- ✅ Build script calls validate-templates.sh automatically
- ✅ Build exits with code 1 if any validation fails
- ✅ Success message only shown if both build and validation pass
- ✅ Error message guides user to fix issues
- ✅ Validation output is readable and not overwhelming

---

## Phase 3: CI/CD Integration (1 day)

### ⚙️ Task 3.1: Add Validation Step to GitHub Actions Workflow

**ID**: TMPL-008
**Priority**: P0 (Critical Path)
**Estimated Time**: 1 hour
**Dependencies**: TMPL-007 (validation integrated locally)
**Owner**: DevOps/Dev
**Status**: Not Started

**Description**:
Update the GitHub Actions workflow to include template validation after build, before generating release notes.

**Implementation Steps**:
1. Open `.github/workflows/release.yml`
2. Add new step after "Create release package variants"
3. Make step conditional on release not existing (same as build step)
4. Ensure validation failure blocks release creation

**Code Changes**:
```yaml
# In .github/workflows/release.yml

- name: Create release package variants
  if: steps.check_release.outputs.exists == 'false'
  run: |
    chmod +x .github/workflows/scripts/create-release-packages.sh
    .github/workflows/scripts/create-release-packages.sh ${{ steps.get_tag.outputs.new_version }}

# ADD THIS NEW STEP
- name: Validate release packages
  if: steps.check_release.outputs.exists == 'false'
  run: |
    chmod +x scripts/validate-templates.sh
    ./scripts/validate-templates.sh .genreleases/

- name: Generate release notes
  if: steps.check_release.outputs.exists == 'false'
  id: release_notes
  run: |
    chmod +x .github/workflows/scripts/generate-release-notes.sh
    .github/workflows/scripts/generate-release-notes.sh ${{ steps.get_tag.outputs.new_version }} ${{ steps.get_tag.outputs.latest_tag }}
```

**Files to Modify**:
- `.github/workflows/release.yml` (add ~5 lines)

**Acceptance Criteria**:
- ✅ Validation step runs after template generation
- ✅ Validation step only runs if release doesn't already exist
- ✅ Workflow fails if validation fails (blocks release)
- ✅ Subsequent steps (release notes, GitHub release) only run if validation passes
- ✅ Workflow logs show validation output

**Testing**: See Task 3.3 for workflow testing

---

### 📄 Task 3.2: Update Release Notes Script for blog-Kit Branding

**ID**: TMPL-009
**Priority**: P1 (High)
**Estimated Time**: 1 hour
**Dependencies**: None (can run parallel to TMPL-008)
**Owner**: Dev
**Status**: Not Started

**Description**:
Update the release notes generation script to reference "blog CLI" instead of "Specify CLI" and include SHA-256 checksums for all template archives.

**Implementation Steps**:
1. Open `.github/workflows/scripts/generate-release-notes.sh`
2. Update intro text to say "blog CLI" not "Specify CLI"
3. Add section to list all ZIP files with checksums and sizes
4. Verify checksum calculation is correct (SHA-256, not SHA-1)

**Code Changes**:
```bash
# In generate-release-notes.sh

# Update intro (around line 30)
cat > release_notes.md << EOF
This is the latest set of releases that you can use with your agent of choice.
We recommend using the blog CLI to scaffold your projects, however you can
download these independently and manage them yourself.

## Changelog

$COMMITS

## Assets

36 template variants with SHA-256 checksums:

EOF

# Add checksums section
for zip in .genreleases/*.zip; do
  [[ -f "$zip" ]] || continue
  filename=$(basename "$zip")
  size=$(ls -lh "$zip" | awk '{print $5}')
  sha256=$(shasum -a 256 "$zip" | cut -d' ' -f1)

  echo "$filename" >> release_notes.md
  echo "sha256:$sha256" >> release_notes.md
  echo "$size" >> release_notes.md
  echo "" >> release_notes.md
done

echo "Generated release notes:"
cat release_notes.md
```

**Files to Modify**:
- `.github/workflows/scripts/generate-release-notes.sh` (modify ~15 lines)

**Testing**:
```bash
# Test locally (after building templates)
.github/workflows/scripts/generate-release-notes.sh v0.1.0-test v0.0.0
cat release_notes.md

# Verify:
# - Says "blog CLI" not "Specify CLI"
# - Lists all 36 ZIPs
# - Shows SHA-256 checksums (64 hex chars)
# - Shows file sizes in KB
```

**Acceptance Criteria**:
- ✅ Release notes mention "blog CLI" (not "Specify CLI")
- ✅ Changelog section includes commits since last release
- ✅ Assets section lists all 36 ZIP files
- ✅ Each ZIP has SHA-256 checksum (not SHA-1 or MD5)
- ✅ Checksums match actual file checksums
- ✅ File sizes displayed in human-readable format (KB)
- ✅ Release notes are well-formatted markdown

---

### 🧪 Task 3.3: Test GitHub Actions Workflow with Dry Run

**ID**: TMPL-010
**Priority**: P0 (Critical Path)
**Estimated Time**: 2 hours
**Dependencies**: TMPL-008, TMPL-009
**Owner**: DevOps/QA
**Status**: Not Started

**Description**:
Test the complete CI/CD workflow before creating a real release by running it on a test branch or using workflow_dispatch.

**Implementation Steps**:
1. Create test branch: `git checkout -b test-release-workflow`
2. Make minimal change to trigger workflow (e.g., add comment to constitution)
3. Push branch and trigger workflow manually via GitHub UI
4. Monitor workflow execution in GitHub Actions
5. Verify each step completes successfully
6. Check that artifacts are generated (but release not published to main)
7. Review logs for any warnings or errors

**Test Procedure**:
```bash
# 1. Create test branch
git checkout -b test-release-workflow

# 2. Make minimal change
echo "<!-- Test comment -->" >> memory/constitution.md
git add memory/constitution.md
git commit -m "test: Trigger release workflow test"

# 3. Push to GitHub
git push origin test-release-workflow

# 4. Trigger workflow manually
# Go to: https://github.com/YOUR_ORG/blog-kit/actions/workflows/release.yml
# Click "Run workflow" → Select branch: test-release-workflow → Click "Run workflow"

# 5. Monitor workflow
# Watch each step execute in real-time

# 6. Verify steps complete:
# - ✅ Checkout repository
# - ✅ Get next version
# - ✅ Check release exists
# - ✅ Create release packages (36 ZIPs)
# - ✅ Validate release packages
# - ✅ Generate release notes
# - (Skip GitHub release creation for test)

# 7. Clean up
git checkout main
git branch -D test-release-workflow
git push origin --delete test-release-workflow
```

**Validation Checklist**:
- ✅ Workflow triggers correctly via workflow_dispatch
- ✅ Version detection works (increments from latest)
- ✅ All 36 templates build successfully
- ✅ Validation step runs and passes
- ✅ Release notes generated with correct format
- ✅ No errors in workflow logs
- ✅ Workflow completes in under 10 minutes
- ✅ Can download artifacts from workflow run

**Acceptance Criteria**:
- ✅ Workflow executes all steps without errors
- ✅ Can verify generated artifacts without creating production release
- ✅ Logs are clear and indicate progress
- ✅ Validation failures would properly block release
- ✅ Ready to run on main branch for real release

**Blockers**: If workflow fails, review logs and fix issues before proceeding to Phase 4.

---

## Phase 4: First Release & Validation (1 day)

### 🚀 Task 4.1: Create First blog-Kit Release (v0.1.0)

**ID**: TMPL-011
**Priority**: P0 (Critical Path)
**Estimated Time**: 1 hour (mostly waiting for CI)
**Dependencies**: TMPL-010 (workflow tested)
**Owner**: Maintainer
**Status**: Not Started

**Description**:
Merge the feature branch to main and trigger the automated release workflow to publish the first official blog-Kit templates release.

**Implementation Steps**:
1. Ensure all Phase 1-3 tasks are complete
2. Review all changes on branch 002-automated-template-releases
3. Ensure main branch is up to date: `git checkout main && git pull`
4. Merge feature branch: `git merge 002-automated-template-releases`
5. Push to main: `git push origin main`
6. Monitor workflow at: https://github.com/YOUR_ORG/blog-kit/actions
7. Wait for workflow to complete (~5-10 minutes)
8. Verify release at: https://github.com/YOUR_ORG/blog-kit/releases

**Pre-Merge Checklist**:
- ✅ All templates pass validation locally
- ✅ Workflow tested successfully (Task 3.3)
- ✅ Documentation updated (README mentions templates)
- ✅ No outstanding issues or blockers
- ✅ Team aware of upcoming release

**Post-Push Monitoring**:
```bash
# Watch workflow progress
gh run watch

# Or monitor in browser
# Go to: https://github.com/YOUR_ORG/blog-kit/actions

# After workflow completes:
# Check release created
gh release view v0.1.0

# List release assets
gh release view v0.1.0 --json assets --jq '.assets[].name'

# Verify 36 ZIPs present
gh release view v0.1.0 --json assets --jq '.assets | length'
# Should output: 38 (36 ZIPs + 2 source archives)
```

**Acceptance Criteria**:
- ✅ Feature branch merged to main without conflicts
- ✅ Workflow triggers automatically on push
- ✅ Workflow completes successfully (all steps green)
- ✅ Release v0.1.0 appears at: https://github.com/YOUR_ORG/blog-kit/releases/latest
- ✅ Release page shows 36 template ZIP files
- ✅ Release notes include changelog and SHA-256 checksums
- ✅ All assets are downloadable (test 1-2 ZIPs)
- ✅ No errors in workflow logs

**Rollback Plan**: If release has errors, delete with `gh release delete v0.1.0 --yes` and `git push origin :v0.1.0`, fix issues, and retry.

---

### ✅ Task 4.2: Verify CLI Downloads blog-Kit Templates

**ID**: TMPL-012
**Priority**: P0 (Critical Path)
**Estimated Time**: 1 hour
**Dependencies**: TMPL-011 (release published)
**Owner**: QA/Dev
**Status**: Not Started

**Description**:
Verify that the blog CLI successfully downloads templates from the blog-kit repository (not falling back to spec-kit) and that templates work correctly when extracted.

**Implementation Steps**:
1. Install blog CLI from source (or pypi if published)
2. Initialize new project with Claude (bash)
3. Initialize new project with Gemini (PowerShell)
4. Verify downloaded templates have correct structure
5. Check command files use blogkit.* namespace
6. Verify constitution is blog-Kit v1.0.0
7. Test running slash commands in AI agent (manual)

**Test Procedure**:
```bash
# 1. Install CLI
cd /path/to/blog-kit
pip install -e .

# 2. Initialize test project (Claude bash)
blog init test-project-claude --agent claude --script sh

# 3. Verify structure
ls test-project-claude/.specify/
ls test-project-claude/.claude/commands/

# 4. Check namespace
head -10 test-project-claude/.claude/commands/blogkit.specify.md
# Should show: agent: blogkit.specify

# 5. Verify constitution
grep "blog-Kit Constitution" test-project-claude/.specify/memory/constitution.md
grep "Version: 1.0.0" test-project-claude/.specify/memory/constitution.md

# 6. Check scripts
test -d test-project-claude/.specify/scripts/bash && echo "✅ Has bash scripts"
test ! -d test-project-claude/.specify/scripts/powershell && echo "✅ No powershell scripts"

# 7. Initialize with different agent (Gemini PowerShell)
blog init test-project-gemini --agent gemini --script ps

# 8. Verify Gemini structure
ls test-project-gemini/.gemini/commands/blogkit.*.toml
grep "{{args}}" test-project-gemini/.gemini/commands/blogkit.specify.toml

# 9. Check CLI logs to confirm source
# Look for: "Downloading from blog-kit releases..."
# NOT: "Falling back to spec-kit releases..."

# 10. Manual test: Open AI agent and run /blogkit.specify
# (This requires actual AI agent testing - beyond automated scope)
```

**Acceptance Criteria**:
- ✅ CLI successfully downloads templates from blog-kit repository
- ✅ No fallback to spec-kit occurs (check CLI logs)
- ✅ Extracted templates have correct directory structure
- ✅ Command files use blogkit.* namespace (not speckit.*)
- ✅ Constitution is blog-Kit v1.0.0 (not Spec-Kit)
- ✅ Bash variants have bash/ scripts, PowerShell variants have powershell/ scripts
- ✅ All 9 commands present in agent directory
- ✅ Templates work with actual AI agent (manual verification)

**Blockers**: If CLI still falls back to spec-kit, check:
- Release exists at correct URL
- Asset naming matches CLI expectations (spec-kit-template-{agent}-{script}-v{version}.zip)
- CLI version/configuration is correct

---

### 🗑️ Task 4.3: Remove Spec-Kit Fallback Logic from CLI

**ID**: TMPL-013
**Priority**: P1 (High)
**Estimated Time**: 30 minutes
**Dependencies**: TMPL-012 (CLI verified working)
**Owner**: Dev
**Status**: Not Started

**Description**:
Remove the fallback logic that downloads templates from spec-kit when blog-kit templates aren't found, since blog-Kit now has its own releases.

**Implementation Steps**:
1. Open `src/blog_cli/__init__.py`
2. Find `download_template_from_github()` function
3. Remove try/except logic that falls back to spec-kit
4. Keep only direct download from blog-kit
5. Update error messages to guide user to check blog-kit releases
6. Update tests to reflect new behavior

**Code Changes**:
```python
# In src/blog_cli/__init__.py

def download_template_from_github(agent: str, script: str, version: str) -> Path:
    """Download template from blog-Kit releases.

    Args:
        agent: AI agent identifier (e.g., 'claude', 'gemini')
        script: Script type ('sh' for bash, 'ps' for PowerShell)
        version: Release version (e.g., 'v0.1.0')

    Returns:
        Path to extracted template directory

    Raises:
        requests.HTTPError: If template download fails
    """
    template_name = f"spec-kit-template-{agent}-{script}-{version}.zip"
    release_url = (
        f"https://github.com/YOUR_ORG/blog-kit/releases/download/{version}/{template_name}"
    )

    # Download from blog-kit releases (no fallback)
    try:
        response = requests.get(release_url, timeout=30)
        response.raise_for_status()
    except requests.HTTPError as e:
        if e.response.status_code == 404:
            raise ValueError(
                f"Template not found: {template_name}\n"
                f"Version {version} may not exist or agent '{agent}' may not be supported.\n"
                f"Check available releases at: https://github.com/YOUR_ORG/blog-kit/releases"
            ) from e
        raise

    # Extract template
    zip_path = Path(tempfile.mkdtemp()) / template_name
    zip_path.write_bytes(response.content)

    extract_dir = zip_path.parent / agent
    with zipfile.ZipFile(zip_path, 'r') as zip_ref:
        zip_ref.extractall(extract_dir)

    return extract_dir
```

**Files to Modify**:
- `src/blog_cli/__init__.py` (remove ~20 lines, update ~10 lines)
- `tests/test_cli.py` (update tests to not expect fallback)

**Testing**:
```bash
# Test with valid version
blog init test-valid --agent claude --script sh --version v0.1.0
# Should succeed

# Test with invalid version
blog init test-invalid --agent claude --script sh --version v99.99.99
# Should fail with clear error message (not fallback)

# Test with invalid agent
blog init test-invalid-agent --agent nonexistent --script sh
# Should fail with clear error message

# Run unit tests
pytest tests/test_cli.py -v
```

**Acceptance Criteria**:
- ✅ Fallback code completely removed from CLI
- ✅ CLI only attempts to download from blog-kit repository
- ✅ Error message clearly indicates to check blog-kit releases
- ✅ Error message includes URL to releases page
- ✅ Unit tests updated to reflect new behavior
- ✅ All CLI tests pass

---

### 📚 Task 4.4: Update Documentation

**ID**: TMPL-014
**Priority**: P2 (Medium)
**Estimated Time**: 2 hours
**Dependencies**: TMPL-013 (CLI finalized)
**Owner**: Dev/Tech Writer
**Status**: Not Started

**Description**:
Update project documentation to explain blog-Kit templates, release process, and usage.

**Implementation Steps**:
1. Update README.md with template overview
2. Create docs/templates.md with detailed template structure
3. Update docs/installation.md if needed
4. Add template testing section to CONTRIBUTING.md
5. Create docs/releases.md explaining release process for maintainers

**Documentation Structure**:

**1. README.md Updates**:
```markdown
## Templates

blog-Kit provides project templates for 18 AI coding agents, available in both bash and PowerShell variants.

### Supported Agents

- **Claude Code** (.claude/commands/)
- **Cursor Agent** (.cursor/commands/)
- **Windsurf** (.windsurf/workflows/)
- **Google Gemini** (.gemini/commands/, TOML format)
- **GitHub Copilot** (.github/agents/, special structure)
- **Qoder** (.qoder/commands/)
- **Qwen** (.qwen/commands/, TOML format)
- **OpenCode** (.opencode/command/)
- **Codex** (.codex/prompts/)
- **KiloCode** (.kilocode/workflows/)
- **Auggie** (.augment/commands/)
- **CodeBuddy** (.codebuddy/commands/)
- **AMP** (.agents/commands/)
- **Shai** (.shai/commands/)
- **Amazon Q** (.amazonq/prompts/)
- **Bob** (.bob/commands/)
- **Roo** (.roo/commands/)

### What's Included

Each template contains:
- **blog-Kit Constitution** (v1.0.0) with 7 blog-specific principles
- **Workflow templates**: spec.md, plan.md, tasks.md
- **9 slash commands**: /blogkit.specify, /blogkit.plan, /blogkit.tasks, /blogkit.implement, /blogkit.clarify, /blogkit.analyze, /blogkit.checklist, /blogkit.taskstoissues, /blogkit.constitution
- **Scripts**: bash or PowerShell variants for automation
- **Memory system**: constitution.md for project-specific principles

Templates are automatically downloaded when you run `blog init`.

### Manual Download

You can also download templates directly from [GitHub Releases](https://github.com/YOUR_ORG/blog-kit/releases/latest) if you prefer manual installation.
```

**2. NEW FILE: docs/templates.md**:
```markdown
# blog-Kit Templates

## Overview

blog-Kit templates provide a structured starting point for product-market-fit discovery projects using AI coding agents.

## Directory Structure

```
project-root/
├── .specify/                  # Shared toolkit files
│   ├── memory/
│   │   └── constitution.md   # blog-Kit constitution v1.0.0
│   ├── scripts/
│   │   ├── bash/             # Bash scripts (sh variants)
│   │   └── powershell/       # PowerShell scripts (ps variants)
│   └── templates/
│       ├── spec-template.md
│       ├── plan-template.md
│       └── tasks-template.md
└── .{agent}/                  # Agent-specific directory
    └── commands/              # (or prompts/, workflows/)
        ├── blogkit.specify.md
        ├── blogkit.plan.md
        ├── blogkit.tasks.md
        └── ...
```

## Command Reference

| Command | Description | Usage |
|---------|-------------|-------|
| /blogkit.specify | Create or update feature specification | `/blogkit.specify "Add user authentication"` |
| /blogkit.plan | Generate implementation plan | `/blogkit.plan` |
| /blogkit.tasks | Break plan into actionable tasks | `/blogkit.tasks` |
| /blogkit.implement | Execute tasks systematically | `/blogkit.implement` |
| /blogkit.clarify | Identify underspecified areas | `/blogkit.clarify` |
| /blogkit.analyze | Cross-artifact consistency check | `/blogkit.analyze` |
| /blogkit.checklist | Generate custom checklist | `/blogkit.checklist` |
| /blogkit.taskstoissues | Convert tasks to GitHub issues | `/blogkit.taskstoissues` |
| /blogkit.constitution | Manage project principles | `/blogkit.constitution` |

## Agent-Specific Notes

### Claude Code
- Format: Markdown with YAML frontmatter
- Directory: `.claude/commands/`
- Arguments: `$ARGUMENTS`

### GitHub Copilot
- Format: Agent files (`.agent.md`) + prompt files (`.prompt.md`)
- Directory: `.github/agents/` and `.github/prompts/`
- Special: Also includes `.vscode/settings.json`

### Google Gemini / Qwen
- Format: TOML files
- Directory: `.gemini/commands/` or `.qwen/commands/`
- Arguments: `{{args}}`

(... more agent-specific details ...)

## Customizing Templates

See [CONTRIBUTING.md](../CONTRIBUTING.md) for how to modify templates and add new commands.

## Release History

See [GitHub Releases](https://github.com/YOUR_ORG/blog-kit/releases) for full release history and changelogs.
```

**3. CONTRIBUTING.md Addition**:
```markdown
## Testing Templates

Before submitting changes to templates, test them locally:

```bash
# Build all templates
./scripts/build-templates.sh v0.X.Y-test

# Or build specific agent
AGENTS=claude SCRIPTS=sh ./scripts/build-templates.sh v0.X.Y-test

# Validate templates
./scripts/validate-templates.sh dist/templates/

# Test with CLI
blog init test-project --template file://dist/templates/spec-kit-template-claude-sh-v0.X.Y-test.zip
```

## Adding New Commands

To add a new slash command:

1. Create `templates/commands/newcommand.md` with YAML frontmatter:
   ```yaml
   ---
   description: Short description of command
   scripts:
     sh: bash /path/to/script.sh --json $ARGUMENTS
     ps: powershell /path/to/script.ps1 -Json $ARGUMENTS
   ---

   Command body with {SCRIPT} placeholder...
   ```

2. Build and test:
   ```bash
   ./scripts/build-templates.sh v0.X.Y-test
   ```

3. Verify new command appears in all 36 variants

## Adding New Agents

To add support for a new agent:

1. Add agent to `ALL_AGENTS` in `.github/workflows/scripts/create-release-packages.sh`
2. Add case block in `build_variant()` function
3. Update validation script to include new agent
4. Test: `AGENTS=newagent ./scripts/build-templates.sh v0.X.Y-test`
5. Update docs/templates.md with agent details
```

**4. NEW FILE: docs/releases.md**:
```markdown
# Release Process

## Automatic Releases

Releases are created automatically when changes to `memory/`, `scripts/`, or `templates/` are pushed to main.

### Workflow

1. Merge feature branch to main
2. GitHub Actions workflow triggers automatically
3. Version auto-increments (patch version by default)
4. 36 template variants are built and validated
5. Release is published to GitHub Releases with SHA-256 checksums

### Monitoring

Watch workflow progress at: https://github.com/YOUR_ORG/blog-kit/actions

## Manual Release (if needed)

If automatic release fails, you can create a release manually:

```bash
# 1. Build templates locally
./scripts/build-templates.sh v0.X.Y

# 2. Validate
./scripts/validate-templates.sh dist/templates/

# 3. Generate release notes
.github/workflows/scripts/generate-release-notes.sh v0.X.Y v0.X.Y-1

# 4. Create release
gh release create v0.X.Y dist/templates/*.zip \
  --title "blog Kit Templates - 0.X.Y" \
  --notes-file release_notes.md
```

## Version Numbering

- **MAJOR (X.0.0)**: Breaking changes to template structure, constitution principles removed
- **MINOR (0.X.0)**: New commands, new agents, constitution principles added
- **PATCH (0.0.X)**: Bug fixes, documentation updates, script improvements

Patch versions auto-increment on each push to main.
```

**Files to Create/Modify**:
- README.md (update ~30 lines)
- docs/templates.md (new, ~200 lines)
- CONTRIBUTING.md (add ~100 lines)
- docs/releases.md (new, ~100 lines)

**Acceptance Criteria**:
- ✅ README mentions blog-Kit templates (not spec-kit)
- ✅ All 18 agents documented with directory structures
- ✅ Template structure clearly explained
- ✅ Command reference table complete
- ✅ Contributing guide includes template testing instructions
- ✅ Release process documented for maintainers
- ✅ Links to GitHub releases work
- ✅ Documentation is well-formatted and readable

---

## Phase 5: Ongoing Maintenance (Continuous)

### 📋 Task 5.1: Document Template Update Workflow

**ID**: TMPL-015
**Priority**: P3 (Low)
**Estimated Time**: 1 hour
**Dependencies**: All Phase 4 tasks complete
**Owner**: Tech Writer/Maintainer
**Status**: Not Started

**Description**:
Create internal documentation for maintainers on how to update templates, add commands, and manage releases.

**Implementation Steps**:
1. Create `docs/maintainer-guide.md`
2. Document template update workflow
3. Document adding new agents
4. Document adding new commands
5. Document troubleshooting common issues

**Content Outline**:
```markdown
# Maintainer Guide

## Template Updates

### Workflow
1. Create feature branch for template changes
2. Make changes to templates/commands/, memory/, or scripts/
3. Test locally: `./scripts/build-templates.sh v0.X.Y-test`
4. Validate: `./scripts/validate-templates.sh dist/templates/`
5. Test with CLI: `blog init test --template file://...`
6. Create PR
7. After merge to main, workflow auto-creates release

### Adding a New Command

(Step-by-step guide with examples)

### Adding a New Agent

(Step-by-step guide with examples)

### Troubleshooting

Common issues and solutions:
- Build fails for specific agent
- Validation errors
- CLI can't download template
- GitHub Actions workflow fails
```

**Files to Create**:
- `docs/maintainer-guide.md` (new, ~300 lines)

**Acceptance Criteria**:
- ✅ Guide covers all common maintenance tasks
- ✅ Includes examples and commands
- ✅ Troubleshooting section addresses known issues
- ✅ Clear and actionable for new maintainers

---

## Summary

### Task Dependency Graph

```
Phase 1: Local Build
  TMPL-001 (Build Script)
  TMPL-002 (Update Templates) ← parallel
  ↓
  TMPL-003 (Test Single Agent) ← requires 001, 002
  ↓
  TMPL-004 (Test All Variants) ← requires 003

Phase 2: Validation
  TMPL-005 (Validation Script) ← requires 004
  ↓
  TMPL-006 (Test Validation) ← requires 005
  ↓
  TMPL-007 (Integrate Validation) ← requires 005, 006

Phase 3: CI/CD
  TMPL-008 (Update Workflow) ← requires 007
  TMPL-009 (Update Release Notes) ← parallel to 008
  ↓
  TMPL-010 (Test Workflow) ← requires 008, 009

Phase 4: Release
  TMPL-011 (First Release) ← requires 010
  ↓
  TMPL-012 (Verify CLI) ← requires 011
  ↓
  TMPL-013 (Remove Fallback) ← requires 012
  TMPL-014 (Documentation) ← parallel to 013

Phase 5: Maintenance
  TMPL-015 (Maintainer Guide) ← requires all Phase 4
```

### Critical Path

TMPL-001 → TMPL-003 → TMPL-004 → TMPL-005 → TMPL-007 → TMPL-008 → TMPL-010 → TMPL-011 → TMPL-012

**Estimated Total Time**: ~20 hours (2.5 days with full focus, 6 days with interruptions)

### Task Status Tracking

| Phase | Tasks | P0 Tasks | P1 Tasks | P2 Tasks | Status |
|-------|-------|----------|----------|----------|--------|
| 1 | 4 | 3 | 0 | 1 | Not Started |
| 2 | 3 | 1 | 1 | 1 | Not Started |
| 3 | 3 | 1 | 1 | 1 | Not Started |
| 4 | 4 | 2 | 1 | 1 | Not Started |
| 5 | 1 | 0 | 0 | 1 | Not Started |
| **Total** | **15** | **7** | **3** | **5** | **0% Complete** |

### Next Actions

1. ✅ Start with Task TMPL-001 (Create Local Build Script)
2. ✅ Run Task TMPL-002 (Update Command Templates) in parallel
3. ✅ Test with Task TMPL-003 before proceeding to full build

---

**Tasks Document Version**: 1.0
**Last Updated**: 2025-12-04
**Status**: Ready for Implementation
