# Tasks: Automated Blog-Tech-Kit Template Release Generation

**Feature**: Automated template release generation for multiple AI agents from `.blogkit/` source
**Branch**: 003-blogkit-auto-template-release
**Created**: 2025-12-05
**Status**: Ready for Implementation

---

## Task Organization

Tasks are grouped by implementation phase and ordered by dependencies. Each task includes:
- **ID**: Unique task identifier
- **Phase**: Implementation phase (0-4)
- **Priority**: P0 (critical path), P1 (high), P2 (medium), P3 (low)
- **Estimated Time**: Time to complete
- **Dependencies**: Tasks that must complete first
- **Acceptance Criteria**: How to verify completion

---

## Phase 0: Quick Setup & Verification (0.5 days)

### Task 0.1: Verify .blogkit/ Directory Structure

**ID**: BLOG-001
**Priority**: P0 (Critical Path)
**Estimated Time**: 30 minutes
**Dependencies**: None
**Owner**: Dev
**Status**: Not Started

**Description**:
Verify that all required files exist in .blogkit/ source directory and are ready for template generation.

**Implementation Steps**:
1. Check .blogkit/memory/constitution.md exists and is Blog-Tech-Kit v1.0.0
2. List all files in .blogkit/scripts/bash/
3. List all files in .blogkit/templates/
4. List all command files in .blogkit/templates/commands/
5. Document any missing files or gaps

**Validation Commands**:
```bash
# Verify structure
tree .blogkit/

# Check constitution version
grep "Version:" .blogkit/memory/constitution.md

# Count command files
ls .blogkit/templates/commands/blogkit.*.md | wc -l
# Should output: 9

# Check for speckit references
grep -r "speckit" .blogkit/ && echo "ERROR: Found speckit references"
```

**Files to Verify**:
- `.blogkit/memory/constitution.md`
- `.blogkit/scripts/bash/common.sh`
- `.blogkit/scripts/bash/setup-plan.sh`
- `.blogkit/scripts/bash/check-prerequisites.sh`
- `.blogkit/scripts/bash/update-agent-context.sh`
- `.blogkit/scripts/bash/create-new-feature.sh`
- `.blogkit/templates/spec-template.md`
- `.blogkit/templates/plan-template.md`
- `.blogkit/templates/tasks-template.md`
- `.blogkit/templates/blog-post-template.md`
- `.blogkit/templates/commands/` (9 blogkit.*.md files)

**Acceptance Criteria**:
- ✅ All 5 bash scripts present
- ✅ All 4 template files present (including blog-post-template.md)
- ✅ All 9 command files present with blogkit.* naming
- ✅ Constitution is v1.0.0 and Blog-Tech-Kit branded
- ✅ No speckit or pmfkit references found

---

### Task 0.2: Create PowerShell Script Directory

**ID**: BLOG-002
**Priority**: P1 (High)
**Estimated Time**: 2 hours
**Dependencies**: BLOG-001
**Owner**: Dev
**Status**: Not Started

**Description**:
Create PowerShell equivalents of bash scripts in .blogkit/scripts/powershell/ to enable ps template variants.

**Implementation Steps**:
1. Create `.blogkit/scripts/powershell/` directory
2. Port `common.sh` → `common.ps1`
3. Port `setup-plan.sh` → `setup-plan.ps1`
4. Port `check-prerequisites.sh` → `check-prerequisites.ps1`
5. Port `create-new-feature.sh` → `create-new-feature.ps1`
6. Port `update-agent-context.sh` → `update-agent-context.ps1`
7. Update path references to use `.blogkit/` working directory
8. Test syntax validity (if PowerShell environment available)

**Porting Guidelines**:
- Use `$Args` for positional arguments
- Use `Param()` blocks for named parameters
- Replace `set -euo pipefail` with `$ErrorActionPreference = "Stop"`
- Replace `$(...)` with `$(...)`
- Replace backticks with PowerShell escape characters

**Example Port**:
```bash
# Bash (common.sh)
REPO_ROOT=$(git rev-parse --show-toplevel)
SPECIFY_DIR="$REPO_ROOT/.blogkit"

# PowerShell (common.ps1)
$REPO_ROOT = git rev-parse --show-toplevel
$SPECIFY_DIR = "$REPO_ROOT\.blogkit"
```

**Files to Create**:
- `.blogkit/scripts/powershell/common.ps1`
- `.blogkit/scripts/powershell/setup-plan.ps1`
- `.blogkit/scripts/powershell/check-prerequisites.ps1`
- `.blogkit/scripts/powershell/create-new-feature.ps1`
- `.blogkit/scripts/powershell/update-agent-context.ps1`

**Acceptance Criteria**:
- ✅ All 5 PowerShell scripts created
- ✅ Scripts use PowerShell conventions (Param blocks, $ErrorActionPreference)
- ✅ Path references use `.blogkit/` working directory
- ✅ Scripts have no syntax errors (verified with PowerShell parser if available)
- ✅ Scripts documented with inline comments

**Note**: If no Windows/PowerShell environment available, create scripts with best-effort porting and document need for Windows testing.

---

## Phase 1: Local Build Infrastructure (2 days)

### Task 1.1: Create GitHub Workflows Scripts Directory

**ID**: BLOG-003
**Priority**: P0 (Critical Path)
**Estimated Time**: 30 minutes
**Dependencies**: BLOG-001, BLOG-002
**Owner**: Dev
**Status**: Not Started

**Description**:
Create directory structure for GitHub Actions workflow scripts, mirroring PMF-Kit structure.

**Implementation Steps**:
1. Create `.github/workflows/scripts/` directory
2. Create empty placeholder scripts:
   - `get-next-version.sh`
   - `check-release-exists.sh`
   - `create-release-packages.sh`
   - `generate-release-notes.sh`
   - `create-github-release.sh`

**Files to Create**:
- `.github/workflows/scripts/get-next-version.sh`
- `.github/workflows/scripts/check-release-exists.sh`
- `.github/workflows/scripts/create-release-packages.sh`
- `.github/workflows/scripts/generate-release-notes.sh`
- `.github/workflows/scripts/create-github-release.sh`

**Acceptance Criteria**:
- ✅ Directory structure created
- ✅ All 5 script files created (can be empty shells initially)
- ✅ Scripts are executable (`chmod +x`)

---

### Task 1.2: Implement create-release-packages.sh

**ID**: BLOG-004
**Priority**: P0 (Critical Path)
**Estimated Time**: 4 hours
**Dependencies**: BLOG-003
**Owner**: Dev
**Status**: Not Started

**Description**:
Implement the core build script that generates 36 template variants from `.blogkit/` source, packaging into `.blogkit/` working directory structure.

**Key Functions to Implement**:
1. use .blogkit/ as source and use .blogkit/ as target

2. **`generate_commands()`**: Transform blogkit.*.md templates for agent
   - Extract YAML frontmatter
   - Replace `__AGENT__` placeholder with `blogkit.{command}`
   - Replace `{SCRIPT}` placeholder with bash or powershell
   - Write to agent directory with correct file extension (.md, .toml, .agent.md)

3. **`main()`**: Loop through all agent/script combinations
   - For each agent in 18 agents
   - For each script type (sh, ps)
   - Call build_variant()
   - Create ZIP archive
   - Calculate SHA-256 checksum

**Agent Configurations** (from PMF-Kit reference):
```bash
ALL_AGENTS=(
  claude cursor-agent windsurf gemini copilot qoder qwen opencode
  codex kilocode auggie roo codebuddy amp shai q bob
)

# Agent-specific directory mappings
case "$agent" in
  claude) mkdir -p "$base_dir/.claude/commands" ;;
  cursor-agent) mkdir -p "$base_dir/.cursor/commands" ;;
  gemini) mkdir -p "$base_dir/.gemini/commands" ;;  # TOML format
  copilot) mkdir -p "$base_dir/.github/agents" "$base_dir/.github/prompts" ;;
  # ... etc for all 18 agents
esac
```

**Implementation Pattern**:
```bash
#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-v0.1.0}"
GENRELEASES_DIR="${GENRELEASES_DIR:-.genreleases}"
BLOGKIT_SOURCE=".blogkit"

mkdir -p "$GENRELEASES_DIR"

build_variant() {
  local agent=$1
  local script=$2  # sh or ps
  local version=$3
  
  local variant_name="spec-kit-template-${agent}-${script}-${version}"
  local base_dir="$GENRELEASES_DIR/$variant_name"
  
  echo "Building $variant_name from $BLOGKIT_SOURCE..."
  
  # Create .blogkit/ working directory structure
  mkdir -p "$base_dir/.blogkit/memory"
  mkdir -p "$base_dir/.blogkit/templates"
  mkdir -p "$base_dir/.blogkit/scripts"
  
  # Copy from .blogkit/ source to .blogkit/ target
  cp "$BLOGKIT_SOURCE/memory/constitution.md" "$base_dir/.blogkit/memory/"
  cp -r "$BLOGKIT_SOURCE/templates/"*.md "$base_dir/.blogkit/templates/"
  
  if [[ "$script" == "sh" ]]; then
    cp -r "$BLOGKIT_SOURCE/scripts/bash" "$base_dir/.blogkit/scripts/"
  else
    cp -r "$BLOGKIT_SOURCE/scripts/powershell" "$base_dir/.blogkit/scripts/"
  fi
  
  # Generate agent-specific commands
  generate_commands "$agent" "$script" "$base_dir"
  
  # Create ZIP
  cd "$GENRELEASES_DIR" && zip -r "${variant_name}.zip" "$variant_name" && cd -
  
  # Cleanup
  rm -rf "$base_dir"
}

generate_commands() {
  local agent=$1
  local script=$2
  local base_dir=$3
  
  # Create agent directory
  local agent_dir=$(get_agent_dir "$agent")
  mkdir -p "$base_dir/$agent_dir"
  
  # Process each command template
  for template in "$BLOGKIT_SOURCE/templates/commands/blogkit."*.md; do
    local cmd_name=$(basename "$template" .md)
    local target_file="$base_dir/$agent_dir/${cmd_name}.md"
    
    # Transform template
    sed "s/__AGENT__/blogkit.${cmd_name#blogkit.}/g" "$template" | \
    sed "s/{SCRIPT}/${script}/g" > "$target_file"
  done
}

# Main loop
for agent in "${ALL_AGENTS[@]}"; do
  for script in sh ps; do
    build_variant "$agent" "$script" "$VERSION"
  done
done

echo "Generated $(ls -1 $GENRELEASES_DIR/*.zip | wc -l) template variants"
```

**Files to Create**:
- `.github/workflows/scripts/create-release-packages.sh` (~300 lines)

**Acceptance Criteria**:
- ✅ Script generates 36 ZIP files (18 agents × 2 scripts)
- ✅ Each ZIP contains .blogkit/ working directory structure
- ✅ Constitution copied from .blogkit/memory/ to .blogkit/memory/
- ✅ Templates copied from .blogkit/templates/ to .blogkit/templates/
- ✅ Scripts copied from .blogkit/scripts/{bash|powershell}/ to .blogkit/scripts/
- ✅ Agent commands generated from .blogkit/templates/commands/
- ✅ Blog-specific template (blog-post-template.md) included
- ✅ Script reports progress and errors clearly

---

### Task 1.3: Implement Helper Scripts

**ID**: BLOG-005
**Priority**: P0 (Critical Path)
**Estimated Time**: 2 hours
**Dependencies**: BLOG-004
**Owner**: Dev
**Status**: Not Started

**Description**:
Implement supporting scripts needed by the workflow.

**Scripts to Implement**:

1. **`get-next-version.sh`**: Auto-increment version
   - Get latest git tag
   - Increment patch version
   - Output new version string

2. **`check-release-exists.sh`**: Check if release already published
   - Use `gh release view` to check
   - Output true/false

3. **`generate-release-notes.sh`**: Create release notes
   - Get commits since last release
   - Format changelog
   - List all 36 ZIP files with SHA-256 checksums
   - Mention "Blog CLI" (not "Specify CLI" or "PMF CLI")

4. **`create-github-release.sh`**: Publish release
   - Create release with `gh release create`
   - Upload 36 ZIP files as assets
   - Attach release notes

**Acceptance Criteria**:
- ✅ get-next-version.sh outputs valid semantic version
- ✅ check-release-exists.sh correctly detects existing releases
- ✅ generate-release-notes.sh creates properly formatted markdown
- ✅ Release notes mention "Blog CLI" and list all 36 assets
- ✅ create-github-release.sh successfully publishes test release (dry run)

---

### Task 1.4: Create Local Build Wrapper Script

**ID**: BLOG-006
**Priority**: P0 (Critical Path)
**Estimated Time**: 1 hour
**Dependencies**: BLOG-004, BLOG-005
**Owner**: Dev
**Status**: Not Started

**Description**:
Create `scripts/build-templates.sh` wrapper for local development and testing.

**Implementation**:
```bash
#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-}"
if [[ -z "$VERSION" ]]; then
  echo "Usage: $0 <version>" >&2
  echo "Example: $0 v0.1.0-test" >&2
  exit 1
fi

# Create output directory
DIST_DIR="dist/templates"
mkdir -p "$DIST_DIR"

# Set GENRELEASES_DIR for create-release-packages.sh
export GENRELEASES_DIR="$DIST_DIR"

echo "Building Blog-Tech-Kit templates v$VERSION from .blogkit/ source..."
echo "Output directory: $DIST_DIR"

# Call existing build script
.github/workflows/scripts/create-release-packages.sh "$VERSION"

# Generate manifest
generate_manifest "$VERSION" "$DIST_DIR"

echo "Build complete! Templates available in $DIST_DIR/"
```

**Files to Create**:
- `scripts/build-templates.sh` (~100 lines)

**Acceptance Criteria**:
- ✅ Script accepts version argument
- ✅ Outputs to dist/templates/ directory
- ✅ Supports AGENTS and SCRIPTS env vars for filtering
- ✅ Generates build-manifest.json
- ✅ Displays summary with file counts and sizes

---

### Task 1.5: Test Local Build with Single Agent

**ID**: BLOG-007
**Priority**: P0 (Critical Path)
**Estimated Time**: 1 hour
**Dependencies**: BLOG-006
**Owner**: Dev/QA
**Status**: Not Started

**Description**:
Validate build process with a single agent (Claude bash) before attempting all 36 variants.

**Test Procedure**:
```bash
# Build single variant
AGENTS=claude SCRIPTS=sh ./scripts/build-templates.sh v0.1.0-test

# Extract to temp
unzip -d /tmp/test-blogkit-claude dist/templates/spec-kit-template-claude-sh-v0.1.0-test.zip

# Verify structure
ls -la /tmp/test-blogkit-claude/.blogkit/
ls -la /tmp/test-blogkit-claude/.blogkit/commands/

# Check required directories
test -d /tmp/test-blogkit-claude/.blogkit/memory && echo "✅ memory/"
test -d /tmp/test-blogkit-claude/.blogkit/scripts/bash && echo "✅ scripts/bash/"
test -d /tmp/test-blogkit-claude/.blogkit/templates && echo "✅ templates/"
test -d /tmp/test-blogkit-claude/.claude/commands && echo "✅ .claude/commands/"

# Check for speckit references
grep -r "speckit" /tmp/test-blogkit-claude/ && echo "❌ Found speckit references" || echo "✅ No speckit references"

# Verify frontmatter
head -5 /tmp/test-blogkit-claude/.claude/commands/blogkit.specify.md
# Should show: agent: blogkit.specify

# Count command files
ls /tmp/test-blogkit-claude/.claude/commands/blogkit.*.md | wc -l
# Should output: 9

# Verify Blog-Tech-Kit constitution
grep "Blog-Tech-Kit Constitution" /tmp/test-blogkit-claude/.blogkit/memory/constitution.md
grep "Version: 1.0.0" /tmp/test-blogkit-claude/.blogkit/memory/constitution.md

# Check blog-specific template
test -f /tmp/test-blogkit-claude/.blogkit/templates/blog-post-template.md && echo "✅ Blog template present"
```

**Acceptance Criteria**:
- ✅ ZIP file extracts without errors
- ✅ Directory structure matches expected layout (.blogkit/ and .claude/)
- ✅ All 9 command files present with blogkit.* naming
- ✅ Constitution is Blog-Tech-Kit v1.0.0
- ✅ Zero occurrences of "speckit" or "pmfkit" in extracted files
- ✅ Scripts directory contains only bash/ (not powershell/)
- ✅ All template files present (including blog-post-template.md)
- ✅ Path references use .blogkit/ prefix

**Blockers**: If this test fails, do NOT proceed to Task 1.6. Fix issues first.

---

### Task 1.6: Test Full Build (All 36 Variants)

**ID**: BLOG-008
**Priority**: P0 (Critical Path)
**Estimated Time**: 2 hours
**Dependencies**: BLOG-007 (must pass)
**Owner**: Dev/QA
**Status**: Not Started

**Description**:
Validate that all 36 template variants (18 agents × 2 script types) generate correctly from .blogkit/ source.

**Test Procedure**:
```bash
# Full build
./scripts/build-templates.sh v0.1.0-test

# Count ZIPs
ZIP_COUNT=$(ls dist/templates/*.zip | wc -l)
echo "ZIP files created: $ZIP_COUNT"
test $ZIP_COUNT -eq 36 && echo "✅ Correct count" || echo "❌ Expected 36, got $ZIP_COUNT"

# Check manifest
cat dist/templates/build-manifest.json | jq '.variants | length'
# Should output: 36

# Check for failures
FAILED=$(cat dist/templates/build-manifest.json | jq '.failed_variants | length')
test $FAILED -eq 0 && echo "✅ No failures" || echo "❌ $FAILED variants failed"

# Spot-check different agents
# 1. Claude (sh) - Markdown
unzip -q -d /tmp/spot-claude dist/templates/spec-kit-template-claude-sh-v0.1.0-test.zip
ls /tmp/spot-claude/.claude/commands/blogkit.*.md | wc -l
# Should output: 9

# 2. Gemini (ps) - TOML format
unzip -q -d /tmp/spot-gemini dist/templates/spec-kit-template-gemini-ps-v0.1.0-test.zip
ls /tmp/spot-gemini/.gemini/commands/blogkit.*.toml | wc -l
# Should output: 9

# 3. Copilot (sh) - Special structure
unzip -q -d /tmp/spot-copilot dist/templates/spec-kit-template-copilot-sh-v0.1.0-test.zip
test -d /tmp/spot-copilot/.github/agents && echo "✅ Has agents/"
test -d /tmp/spot-copilot/.github/prompts && echo "✅ Has prompts/"

# 4. Cursor (ps) - PowerShell scripts
unzip -q -d /tmp/spot-cursor dist/templates/spec-kit-template-cursor-agent-ps-v0.1.0-test.zip
test -d /tmp/spot-cursor/.blogkit/scripts/powershell && echo "✅ Has powershell/"
test ! -d /tmp/spot-cursor/.blogkit/scripts/bash && echo "✅ No bash/ directory"

# Verify total size
du -sh dist/templates/
# Should be around 2-3 MB

# Check checksums are unique
cat dist/templates/build-manifest.json | jq -r '.variants[].sha256' | sort | uniq -d
# Should output nothing (no duplicates)
```

**Acceptance Criteria**:
- ✅ Exactly 36 ZIP files generated
- ✅ build-manifest.json shows all 36 variants with status "completed"
- ✅ Zero variants in failed_variants array
- ✅ Each agent has correct directory structure sourced from .blogkit/
- ✅ Bash variants have bash/ scripts, PowerShell variants have powershell/ scripts
- ✅ All templates include Blog-Tech-Kit constitution v1.0.0
- ✅ Total archive size is reasonable (~2-3 MB for all 36)
- ✅ All SHA-256 checksums are unique
- ✅ Blog-specific template present in all variants

**Blockers**: If failures occur, check build-manifest.json for which variants failed and fix those specific agent configurations.

---

## Phase 2: Validation Infrastructure (2 days)

### Task 2.1: Create Template Validation Script

**ID**: BLOG-009
**Priority**: P0 (Critical Path)
**Estimated Time**: 4 hours
**Dependencies**: BLOG-008 (full build works)
**Owner**: Dev
**Status**: Not Started

**Description**:
Create automated validation script that verifies template quality from .blogkit/ source packaging.

**Validation Functions to Implement**:

1. **`check_frontmatter_namespace()`**: Verify all commands use `agent: blogkit.*`
2. **`check_required_files()`**: Verify files from .blogkit/ are in .blogkit/
3. **`check_content_references()`**: Scan for unintended `/speckit.` or `/pmfkit.` references
4. **`check_directory_structure()`**: Verify .blogkit/ working directory exists (not .speckit/)
5. **`check_constitution_version()`**: Verify Blog-Tech-Kit constitution v1.0.0
6. **`check_script_consistency()`**: Ensure sh has bash/, ps has powershell/
7. **`check_command_count()`**: Verify 9 required commands present
8. **`check_zip_integrity()`**: Test ZIP extracts without errors
9. **`check_blog_specific_files()`**: Verify blog-post-template.md present

**Implementation Pattern**:
```bash
#!/usr/bin/env bash
set -euo pipefail

# Global counters
TOTAL_VARIANTS=0
PASSED_VARIANTS=0
FAILED_VARIANTS=0

check_required_files() {
  local extract_dir=$1
  local errors=0

  # Required files from .blogkit/ source
  local required_files=(
    ".blogkit/memory/constitution.md"
    ".blogkit/templates/spec-template.md"
    ".blogkit/templates/plan-template.md"
    ".blogkit/templates/tasks-template.md"
    ".blogkit/templates/blog-post-template.md"  # Blog-specific
  )

  for file in "${required_files[@]}"; do
    if [[ ! -f "$extract_dir/$file" ]]; then
      echo "    ❌ Missing required file: $file"
      ((errors++))
    fi
  done

  # Verify constitution content
  if ! grep -q "Blog-Tech-Kit Constitution" "$extract_dir/.blogkit/memory/constitution.md"; then
    echo "    ❌ Constitution is not Blog-Tech-Kit branded"
    ((errors++))
  fi

  return $errors
}

check_content_references() {
  local extract_dir=$1
  local errors=0

  # Scan for speckit or pmfkit references
  if grep -r "speckit\." "$extract_dir" >/dev/null 2>&1; then
    echo "    ❌ Found /speckit.* references in template"
    grep -rn "speckit\." "$extract_dir" | head -5
    ((errors++))
  fi

  if grep -r "pmfkit\." "$extract_dir" >/dev/null 2>&1; then
    echo "    ❌ Found /pmfkit.* references in template"
    grep -rn "pmfkit\." "$extract_dir" | head -5
    ((errors++))
  fi

  return $errors
}

validate_variant() {
  local variant_path=$1
  local variant_name=$(basename "$variant_path" .zip)
  local errors=0

  echo "Validating $variant_name..."

  # Extract ZIP to temp directory
  local temp_dir=$(mktemp -d)
  trap "rm -rf $temp_dir" EXIT

  if ! unzip -q "$variant_path" -d "$temp_dir"; then
    echo "  ❌ ZIP extraction FAILED"
    return 1
  fi

  # Detect agent directory
  local agent_dir=$(find "$temp_dir" -maxdepth 1 -type d -name ".*" ! -name ".blogkit" | head -1)

  # Run all validation checks
  check_frontmatter_namespace "$temp_dir" "$agent_dir" || ((errors++))
  check_required_files "$temp_dir" || ((errors++))
  check_content_references "$temp_dir" || ((errors++))
  check_directory_structure "$temp_dir" "$agent_dir" || ((errors++))
  check_constitution_version "$temp_dir" || ((errors++))
  check_script_consistency "$temp_dir" "$variant_name" || ((errors++))
  check_command_count "$temp_dir" "$agent_dir" || ((errors++))
  check_blog_specific_files "$temp_dir" || ((errors++))

  if [[ $errors -gt 0 ]]; then
    echo "  ⛔ VALIDATION FAILED ($errors errors)"
    return 1
  else
    echo "  ✅ VALIDATION PASSED"
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
- `scripts/validate-templates.sh` (~400 lines)

**Acceptance Criteria**:
- ✅ Script accepts directory path or single ZIP file
- ✅ Implements all 9 validation checks
- ✅ Returns exit code 0 if all variants pass, non-zero if any fail
- ✅ Provides clear error messages indicating which check failed
- ✅ Supports --verbose flag for detailed output
- ✅ Can validate 36 variants in under 2 minutes
- ✅ Catches missing blog-post-template.md
- ✅ Detects any speckit or pmfkit references

---

### Task 2.2: Create Validation Test Cases

**ID**: BLOG-010
**Priority**: P1 (High)
**Estimated Time**: 2 hours
**Dependencies**: BLOG-009
**Owner**: QA/Dev
**Status**: Not Started

**Description**:
Create test cases with intentionally broken templates to verify validation script catches errors.

**Test Cases to Create**:

1. **Wrong namespace**: Edit command to use `agent: speckit.specify`
2. **Missing blog file**: Remove blog-post-template.md
3. **Speckit reference**: Add `/speckit.plan` to command body
4. **Wrong scripts**: Include both bash/ and powershell/ in sh variant
5. **Valid template**: Use cleanly built template

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
run_test "Missing Blog File" "test-data/missing-blog-template.zip" "fail" || ((total_errors++))
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
- ✅ All 4 negative tests (invalid templates) cause validation failure
- ✅ Positive test (valid template) passes validation
- ✅ Error messages clearly explain issues
- ✅ Test runner can run all tests automatically

---

### Task 2.3: Integrate Validation into Build Script

**ID**: BLOG-011
**Priority**: P0 (Critical Path)
**Estimated Time**: 30 minutes
**Dependencies**: BLOG-009, BLOG-010 (validation script tested)
**Owner**: Dev
**Status**: Not Started

**Description**:
Modify build script to automatically run validation after generating templates.

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

**Acceptance Criteria**:
- ✅ Build script calls validate-templates.sh automatically
- ✅ Build exits with code 1 if any validation fails
- ✅ Success message only shown if both build and validation pass

---

## Phase 3: CI/CD Integration (1 day)

### Task 3.1: Create GitHub Actions Release Workflow

**ID**: BLOG-012
**Priority**: P0 (Critical Path)
**Estimated Time**: 2 hours
**Dependencies**: BLOG-011 (validation integrated)
**Owner**: DevOps/Dev
**Status**: Not Started

**Description**:
Create GitHub Actions workflow to automate releases on main branch pushes affecting .blogkit/ paths.

**Workflow Configuration**:
```yaml
name: Release Blog-Tech-Kit Templates

on:
  push:
    branches: [main]
    paths:
      - '.blogkit/**'
      - 'memory/**'
      - 'scripts/**'
      - 'templates/**'
  workflow_dispatch:

jobs:
  release:
    runs-on: ubuntu-latest
    permissions:
      contents: write
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Get next version
        id: get_tag
        run: |
          chmod +x .github/workflows/scripts/get-next-version.sh
          .github/workflows/scripts/get-next-version.sh

      - name: Check if release exists
        id: check_release
        run: |
          chmod +x .github/workflows/scripts/check-release-exists.sh
          .github/workflows/scripts/check-release-exists.sh ${{ steps.get_tag.outputs.new_version }}

      - name: Create release package variants
        if: steps.check_release.outputs.exists == 'false'
        run: |
          chmod +x .github/workflows/scripts/create-release-packages.sh
          .github/workflows/scripts/create-release-packages.sh ${{ steps.get_tag.outputs.new_version }}

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

      - name: Create GitHub release
        if: steps.check_release.outputs.exists == 'false'
        run: |
          chmod +x .github/workflows/scripts/create-github-release.sh
          .github/workflows/scripts/create-github-release.sh ${{ steps.get_tag.outputs.new_version }}
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

**Files to Create**:
- `.github/workflows/release.yml` (~80 lines)

**Acceptance Criteria**:
- ✅ Workflow triggers on .blogkit/ changes
- ✅ Workflow triggers on main branch push
- ✅ Supports manual workflow_dispatch
- ✅ Validation step blocks release if errors
- ✅ All steps have proper error handling

---

### Task 3.2: Update Release Notes Script for Blog-Tech-Kit Branding

**ID**: BLOG-013
**Priority**: P1 (High)
**Estimated Time**: 1 hour
**Dependencies**: BLOG-012
**Owner**: Dev
**Status**: Not Started

**Description**:
Update release notes generation to reference "Blog CLI" and Blog-Tech-Kit branding.

**Code Changes**:
```bash
# In generate-release-notes.sh

cat > release_notes.md << EOF
This is the latest set of Blog-Tech-Kit template releases for all supported AI agents.
We recommend using the Blog CLI to scaffold your blog projects, however you can
download these independently and manage them yourself.

## Changelog

$COMMITS

## Assets

36 template variants with SHA-256 checksums:

EOF

# Append checksums for all ZIPs
for zip in .genreleases/*.zip; do
  filename=$(basename "$zip")
  size=$(ls -lh "$zip" | awk '{print $5}')
  sha256=$(shasum -a 256 "$zip" | cut -d' ' -f1)

  echo "$filename" >> release_notes.md
  echo "sha256:$sha256" >> release_notes.md
  echo "$size" >> release_notes.md
  echo "" >> release_notes.md
done
```

**Files to Modify**:
- `.github/workflows/scripts/generate-release-notes.sh` (modify ~15 lines)

**Acceptance Criteria**:
- ✅ Release notes say "Blog CLI" (not "Specify CLI" or "PMF CLI")
- ✅ All 36 ZIP files listed with checksums
- ✅ Checksums match actual file checksums
- ✅ File sizes displayed in human-readable format

---

### Task 3.3: Test Workflow with Dry Run

**ID**: BLOG-014
**Priority**: P0 (Critical Path)
**Estimated Time**: 2 hours
**Dependencies**: BLOG-012, BLOG-013
**Owner**: DevOps/QA
**Status**: Not Started

**Description**:
Test complete CI/CD workflow before creating real release.

**Test Procedure**:
```bash
# 1. Create test branch
git checkout -b test-release-workflow

# 2. Make minimal change
echo "<!-- Test comment -->" >> .blogkit/memory/constitution.md
git add .blogkit/memory/constitution.md
git commit -m "test: Trigger release workflow test"

# 3. Push to GitHub
git push origin test-release-workflow

# 4. Trigger workflow manually via GitHub UI
# Go to: Actions → Release Blog-Tech-Kit Templates → Run workflow

# 5. Monitor workflow execution

# 6. Verify steps complete:
# - ✅ Checkout repository
# - ✅ Get next version
# - ✅ Check release exists
# - ✅ Create release packages (36 ZIPs from .blogkit/)
# - ✅ Validate release packages
# - ✅ Generate release notes
# - (Skip GitHub release creation for test)

# 7. Clean up
git checkout main
git branch -D test-release-workflow
git push origin --delete test-release-workflow
```

**Acceptance Criteria**:
- ✅ Workflow triggers correctly via workflow_dispatch
- ✅ Version detection works
- ✅ All 36 templates build successfully from .blogkit/ source
- ✅ Validation passes
- ✅ Release notes generated correctly with Blog CLI branding
- ✅ No errors in workflow logs
- ✅ Workflow completes in under 10 minutes

---

## Phase 4: First Release & Validation (1 day)

### Task 4.1: Create First Blog-Tech-Kit Release (v0.1.0)

**ID**: BLOG-015
**Priority**: P0 (Critical Path)
**Estimated Time**: 1 hour (mostly waiting for CI)
**Dependencies**: BLOG-014 (workflow tested)
**Owner**: Maintainer
**Status**: Not Started

**Description**:
Merge feature branch to main and trigger first official Blog-Tech-Kit release.

**Implementation Steps**:
1. Ensure all Phase 0-3 tasks complete
2. Review all changes on branch 003-blogkit-auto-template-release
3. Ensure main branch is up to date
4. Merge feature branch to main
5. Push to main
6. Monitor workflow execution
7. Verify release created

**Monitoring Commands**:
```bash
# Watch workflow progress
gh run watch

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
- ✅ Workflow completes successfully
- ✅ Release v0.1.0 appears on GitHub
- ✅ 36 template ZIP files present
- ✅ Release notes include changelog and SHA-256 checksums
- ✅ All assets are downloadable

---

### Task 4.2: Update Documentation

**ID**: BLOG-016
**Priority**: P2 (Medium)
**Estimated Time**: 2 hours
**Dependencies**: BLOG-015
**Owner**: Dev/Tech Writer
**Status**: Not Started

**Description**:
Update project documentation to explain Blog-Tech-Kit templates and release process.

**Documentation Updates**:

1. **README.md**: Add templates section
2. **docs/templates.md** (new): Template structure and command reference
3. **CONTRIBUTING.md**: Add template testing instructions
4. **docs/releases.md** (new): Release process for maintainers

**Acceptance Criteria**:
- ✅ README mentions Blog-Tech-Kit templates
- ✅ Template structure documented
- ✅ All 18 agents listed with directory structures
- ✅ Command reference table complete
- ✅ Contributing guide includes template testing
- ✅ Release process documented

---

## Summary

### Task Dependency Graph

```
Phase 0: Verification
  BLOG-001 (Verify .blogkit/)
  ↓
  BLOG-002 (Create PowerShell scripts) ← requires 001

Phase 1: Build
  BLOG-003 (Create workflow scripts dir) ← requires 001, 002
  ↓
  BLOG-004 (Implement create-release-packages.sh) ← requires 003
  ↓
  BLOG-005 (Implement helper scripts) ← requires 004
  ↓
  BLOG-006 (Create local build wrapper) ← requires 004, 005
  ↓
  BLOG-007 (Test single agent) ← requires 006
  ↓
  BLOG-008 (Test all variants) ← requires 007

Phase 2: Validation
  BLOG-009 (Create validation script) ← requires 008
  ↓
  BLOG-010 (Create test cases) ← requires 009
  ↓
  BLOG-011 (Integrate validation) ← requires 009, 010

Phase 3: CI/CD
  BLOG-012 (Create workflow) ← requires 011
  BLOG-013 (Update release notes) ← parallel to 012
  ↓
  BLOG-014 (Test workflow) ← requires 012, 013

Phase 4: Release
  BLOG-015 (First release) ← requires 014
  BLOG-016 (Documentation) ← parallel to 015
```

### Critical Path

BLOG-001 → BLOG-002 → BLOG-003 → BLOG-004 → BLOG-006 → BLOG-007 → BLOG-008 → BLOG-009 → BLOG-011 → BLOG-012 → BLOG-014 → BLOG-015

**Estimated Total Time**: ~18-20 hours (2.5 days with full focus, 5-6 days with interruptions)

### Task Status Tracking

| Phase | Tasks | P0 Tasks | P1 Tasks | P2 Tasks | Status |
|-------|-------|----------|----------|----------|--------|
| 0 | 2 | 1 | 1 | 0 | Not Started |
| 1 | 6 | 5 | 0 | 1 | Not Started |
| 2 | 3 | 1 | 1 | 1 | Not Started |
| 3 | 3 | 1 | 1 | 1 | Not Started |
| 4 | 2 | 1 | 0 | 1 | Not Started |
| **Total** | **16** | **9** | **3** | **4** | **0% Complete** |

### Next Actions

1. ✅ Start with Task BLOG-001 (Verify .blogkit/ directory)
2. ✅ Create PowerShell scripts (Task BLOG-002)
3. ✅ Implement core build script (Task BLOG-004)
4. ✅ Test with single agent before full build

---

**Tasks Document Version**: 1.0
**Last Updated**: 2025-12-05
**Status**: Ready for Implementation
