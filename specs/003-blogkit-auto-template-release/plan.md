# Implementation Plan: Automated Blog-Tech-Kit Template Release Generation

**Feature**: Automated template release generation for multiple AI agents from `.blogkit/` source
**Branch**: 003-blogkit-auto-template-release
**Created**: 2025-12-05
**Status**: Design Phase

---

## Executive Summary

This plan implements automated generation and publication of 36 Blog-Tech-Kit template variants (18 AI agents × 2 script types) to GitHub releases. The system adapts PMF-Kit's proven release infrastructure to generate Blog-Tech-Kit branded templates with `/blogkit.*` commands, sourcing content from `.blogkit/` directory and packaging into `.blogkit/` working directory structure per the Blog-Tech-Kit constitution's multi-kit coexistence strategy.

**Key Objectives**:
1. Generate 36 template ZIP files with Blog-Tech-Kit branding and commands from `.blogkit/` source
2. Automate release creation on main branch pushes affecting `.blogkit/` paths
3. Validate templates ensure no Spec-Kit references remain
4. Publish to GitHub releases with checksums and release notes
5. Enable `blog init` to download from blog-tech-kit repository (no spec-kit fallback)

**Success Criteria**:
- `blog init` downloads templates from blog-tech-kit repository
- All templates pass validation (correct namespace, required files from `.blogkit/`, no spec-kit references)
- Release generation completes in under 10 minutes
- Local build script allows testing before CI

**Critical Distinction**: Templates are sourced from `.blogkit/` and packaged into `.blogkit/` working directory structure (per constitution Namespace Design section), enabling multi-kit coexistence.

---

## Technical Context

### Source Architecture

**Blog-Tech-Kit Source Structure** (`.blogkit/` directory):
```
.blogkit/
├── memory/
│   └── constitution.md           # Blog-Tech-Kit constitution v1.0.0
├── scripts/
│   └── bash/
│       ├── common.sh
│       ├── setup-plan.sh
│       ├── check-prerequisites.sh
│       ├── update-agent-context.sh
│       └── create-new-feature.sh
├── templates/
│   ├── spec-template.md
│   ├── plan-template.md
│   ├── tasks-template.md
│   ├── blog-post-template.md    # Blog-specific template
│   └── commands/
│       ├── blogkit.constitution.md
│       ├── blogkit.specify.md
│       ├── blogkit.plan.md
│       ├── blogkit.tasks.md
│       ├── blogkit.implement.md
│       ├── blogkit.clarify.md
│       ├── blogkit.analyze.md
│       ├── blogkit.checklist.md
│       └── blogkit.taskstoissues.md
```

**Target Template Structure** (extracted by `blog init`):
```
project-root/
├── .blogkit/                      # Shared working directory (per constitution)
│   ├── memory/
│   │   └── constitution.md       # From .blogkit/memory/constitution.md
│   ├── scripts/
│   │   ├── bash/                 # From .blogkit/scripts/bash/
│   │   │   ├── common.sh
│   │   │   ├── setup-plan.sh
│   │   │   └── ...
│   │   └── powershell/           # (for ps variants)
│   └── templates/
│       ├── spec-template.md      # From .blogkit/templates/
│       ├── plan-template.md
│       ├── tasks-template.md
│       └── blog-post-template.md
└── .{agent}/                      # e.g., .claude/
    └── commands/
        ├── blogkit.constitution.md
        ├── blogkit.specify.md
        ├── blogkit.plan.md
        └── ...                   # All from .blogkit/templates/commands/
```

### Existing Infrastructure Analysis

**Current State** (from PMF-Kit reference and codebase):

1. **GitHub Actions Workflow Pattern** (to be created):
   - Triggers on push to main (paths: `.blogkit/**`, `memory/`, `scripts/`, `templates/`)
   - Supports manual workflow_dispatch
   - Calls modular scripts: get-next-version.sh, check-release-exists.sh, create-release-packages.sh, generate-release-notes.sh, create-github-release.sh

2. **Build Script Pattern** (to be created, based on PMF-Kit):
   - Generates templates for 18 agents (claude, gemini, copilot, cursor-agent, qwen, opencode, windsurf, codex, kilocode, auggie, roo, codebuddy, amp, shai, q, bob, qoder)
   - Supports both bash (sh) and PowerShell (ps) variants
   - Uses `.genreleases/` directory for build artifacts
   - Implements `generate_commands()` function to transform templates
   - **KEY**: use `.blogkit/` source in generated templates

3. **Template Sources** (existing in `.blogkit/`):
   - `.blogkit/memory/constitution.md` - Blog-Tech-Kit v1.0.0 constitution
   - `.blogkit/templates/` - Template files (spec, plan, tasks, blog-post)
   - `.blogkit/scripts/bash/` - Bash scripts only (no PowerShell variants yet)
   - `.blogkit/templates/commands/*.md` - Command templates with YAML frontmatter

4. **CLI Integration** (assumed, needs verification):
   - `download_template_from_github()` function expects `spec-kit-template-{agent}-{script}.zip` naming
   - Falls back to spec-kit releases when blog-tech-kit releases don't exist
   - Fallback logic should be removed after first Blog-Tech-Kit release

### Technology Stack

- **Build Tool**: Bash (v4.0+) with standard Unix utilities (sed, awk, grep, zip)
- **CI/CD**: GitHub Actions (ubuntu-latest runner)
- **Release Platform**: GitHub Releases API
- **Version Control**: Git with semantic versioning
- **Archive Format**: ZIP with SHA-256 checksums

### Dependencies

**Required**:
- Bash shell with arrays and modern syntax
- `zip` utility for archive creation
- Git for versioning and changelog generation
- GitHub CLI (`gh`) for release creation (available in Actions)
- Standard Unix text processing tools (sed, awk, grep)

**Optional**:
- Python 3.11+ for enhanced validation scripts

### Key Design Decisions (adapted from PMF-Kit)

1. **Keep `spec-kit-template-*` naming**: CLI expects this pattern (cannot change without CLI update)
2. **Use `/blogkit.*` namespace**: Prevents conflicts with spec-kit and pmf-kit
3. **Source from `.blogkit/`, package to `.blogkit/`**: Per constitution multi-kit coexistence strategy
4. **Bash for all scripts**: Matches existing infrastructure
5. **Auto-increment patch versions**: get-next-version.sh handles this
6. **Validate before release**: Multi-phase validation prevents bad releases
7. **Trigger on `.blogkit/` changes**: Watch `.blogkit/**` path in addition to legacy `memory/`, `scripts/`, `templates/` paths

---

## Constitution Check

### Principle I: Content-First, Implementation-Second ✅

**Compliance**: Feature has comprehensive spec.md with blog-focused requirements
**Evidence**: specs/003-blogkit-auto-template-release/spec.md defines automated release infrastructure to support blog content workflow
**Application**: Release automation enables focus on content creation rather than manual template management

### Principle II: Principle-Driven Content Architecture ✅

**Compliance**: Templates sourced from `.blogkit/` contain blog-specific principles and patterns
**Evidence**:
- Constitution from `.blogkit/memory/constitution.md` includes 8 Core Blog Principles
- Templates from `.blogkit/templates/` include blog-post-template.md
- Commands from `.blogkit/templates/commands/` are blog-kit namespaced

### Principle III: Test-First for Content Quality (NON-NEGOTIABLE) ✅

**Compliance**: Implementation includes validation checkpoints after each phase
**Evidence**:
- Phase 1: Local build script testing
- Phase 2: Validation script development
- Phase 3: CI integration testing
- Phase 4: First release validation
- All validation ensures templates from `.blogkit/` are correctly packaged

### Principle VII: Simplicity & Focus ✅

**Compliance**: Reuses PMF-Kit release infrastructure patterns, only modifies source paths
**Evidence**:
- Adapts proven workflow structure from specs/002-automated-template-releases/
- No new external dependencies
- Simple bash scripts instead of complex frameworks
- Source change: swap PMF-Kit paths for `.blogkit/` paths

### Multi-Kit Namespace Isolation ✅

**Compliance**: **CRITICAL FOR THIS FEATURE** - Uses `/blogkit.*` namespace throughout
**Evidence**:
- FR-005: "All agent command files MUST use `/blogkit.*` command prefix"
- FR-022: "Validation MUST verify agent command frontmatter uses correct `agent: blogkit.{command}` format"
- FR-021: "Validation MUST scan for unintended `/speckit.*` references"
- FR-009: "Build script MUST copy content from .blogkit/ source directory into .specify/ structure"

**Validation Gate**: Templates MUST pass namespace validation before release

### Versioning & Breaking Changes ✅

**Compliance**: Implementation demonstrates how to version blog-tech-kit releases
**Evidence**:
- Documents release versioning process
- Tracks `.blogkit/` structure changes
- Provides pattern for future blog-tech-kit variants

---

## Architecture Overview

### System Components

```
                                                             
 GitHub Actions Workflow (.github/workflows/release.yml)    
 Trigger: Push to main (.blogkit/**, memory/, scripts/, templates/)      
            ,                                                
             
               > Step 1: Get Next Version
                 Script: get-next-version.sh
                 Output: NEW_VERSION (e.g., v0.1.0)
             
               > Step 2: Check Release Exists
                 Script: check-release-exists.sh
                 Output: exists=true/false
             
               > Step 3: Build Template Variants
                 Script: create-release-packages.sh
                                                      
                  For each agent in 18 agents:       
                    For each script in [sh, ps]:     
                      1. Create .specify/ structure  
                      2. Copy from .blogkit/memory/,
                         .blogkit/scripts/, .blogkit/templates/
                      3. Generate command files      
                      4. Create agent directory      
                      5. ZIP the structure           
                      6. Calculate SHA-256           
                                                      
                 Output: 36 ZIP files in .genreleases/
             
               > Step 4: Validate Templates
                 Script: validate-templates.sh (NEW)
                 Checks:
                   - Frontmatter uses blogkit.* namespace
                   - No /speckit.* references in content
                   - Required files from .blogkit/ present
                   - Directory structure correct (.specify/ working dir)
                 Output: PASS/FAIL
             
               > Step 5: Generate Release Notes
                 Script: generate-release-notes.sh
                                                      
                  1. Get commits since last release  
                  2. Format changelog                
                  3. List all 36 assets with SHA-256 
                                                      
                 Output: release_notes.md
             
               > Step 6: Create GitHub Release
                  Script: create-github-release.sh
                                                       
                   1. Create release with gh CLI      
                   2. Upload 36 ZIP files as assets   
                   3. Attach release notes            
                                                       
                  Output: GitHub Release URL
```

### Build Process Detail

```
Template Build Flow (per variant):

Source Files                    Build Process                    Output
                                                                        

.blogkit/
  memory/
    constitution.md        
                          
  templates/                                      
    spec-template.md
    plan-template.md                   ,         
    tasks-template.md                   
    blog-post-template.md               
    ...                                   
                                         
  scripts/                                        .blogkit/
    bash/                                           memory/
      common.sh                                     scripts/
      create-new-feature.sh               $          templates/
      setup-plan.sh                       
      ...                                 
  (no powershell/ yet)                    
                            <             

  templates/commands/
    blogkit.constitution.md             
    blogkit.plan.md                                          
    blogkit.tasks.md                    > generate_commands()
    blogkit.implement.md                  - Extract frontm.  
    blogkit.clarify.md                    - Replace {SCRIPT} 
    blogkit.analyze.md                    - Rewrite paths    
    blogkit.checklist.md                  - Set namespace    
    blogkit.taskstoissues.md                     ,           
    blogkit.specify.md                            
                                         
                                         4
                               .{agent}/commands/
                                 blogkit.specify.md
                                 blogkit.plan.md
                                 blogkit.tasks.md
                                 blogkit.implement.md
                                 blogkit.clarify.md
                                 blogkit.analyze.md
                                 blogkit.checklist.md
                                 blogkit.taskstoissues.md
                                 blogkit.constitution.md

                                         
                                         4
                                                       
                           zip -r spec-kit-template-   
                             {agent}-{script}-{ver}.zip
                                      ,                
                                       
                                       4
                       spec-kit-template-claude-sh-v0.1.0.zip
                                (55.4 KB)
                    sha256:25a65e13d93e74295c9b7dba3dcaf9a2...
```

---

## Phase 0: Research & Design

**Status**: NOT STARTED
**Duration**: 0.5 days (already have PMF-Kit reference)
**Outputs**: research.md (simplified), data-model.md (minimal)

### Research Tasks

✅ **R1: Review PMF-Kit release process**
- Read specs/002-automated-template-releases/ thoroughly
- Identify adaptable patterns
- Document Blog-Tech-Kit specific changes needed

✅ **R2: Verify .blogkit/ directory contents**
- Confirm all required files present
- Check for PowerShell script variants (create if missing)
- Validate blogkit.* command files

✅ **R3: Document Blog-Tech-Kit constitution requirements**
- Read .blogkit/memory/constitution.md v1.0.0
- Identify multi-kit coexistence requirements
- Document .blogkit/ → .specify/ packaging strategy

✅ **R4: Define data model** (minimal)
- Reuse PMF-Kit entity definitions
- Document Blog-Tech-Kit specific variations
- Focus on .blogkit/ source path changes

**Deliverables**:
- ✅ research.md: Technology decisions and PMF-Kit adaptations
- ✅ data-model.md: Entity definitions (largely reused from PMF-Kit)

---

## Phase 1: Local Build Infrastructure

**Goal**: Enable local template generation for testing before CI integration
**Duration**: 2 days
**Dependencies**: Phase 0 complete

### Tasks

#### Task 1.1: Create PowerShell Script Variants

**File**: `.blogkit/scripts/powershell/` (new directory)
**Purpose**: Enable ps variants by creating PowerShell equivalents of bash scripts

**Requirements**:
- Port `.blogkit/scripts/bash/common.sh` to `common.ps1`
- Port `.blogkit/scripts/bash/setup-plan.sh` to `setup-plan.ps1`
- Port `.blogkit/scripts/bash/check-prerequisites.sh` to `check-prerequisites.ps1`
- Port `.blogkit/scripts/bash/create-new-feature.sh` to `create-new-feature.ps1`
- Port `.blogkit/scripts/bash/update-agent-context.sh` to `update-agent-context.ps1`

**Acceptance Criteria**:
- ✅ All 5 bash scripts have PowerShell equivalents
- ✅ Scripts use PowerShell conventions ($Args, Param blocks)
- ✅ Path references use .specify/ working directory
- ✅ Scripts tested on Windows (or deferred if no Windows environment available)

#### Task 1.2: Create Local Build Script

**File**: `scripts/build-templates.sh`
**Purpose**: Wrapper around create-release-packages.sh for local development

**Key Adaptations from PMF-Kit**:
- Source files from `.blogkit/` instead of `templates/`, `memory/`, `scripts/`


**Requirements**:
- Accept version as argument (e.g., `v0.1.0-test`)
- Support AGENTS and SCRIPTS env vars for subset building
- Output to `dist/templates/` directory (not .genreleases/)
- Provide verbose progress output
- Calculate and display checksums
- Generate build manifest JSON

**Implementation Pattern**:
```bash
#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-}"
if [[ -z "$VERSION" ]]; then
  echo "Usage: $0 <version>" >&2
  exit 1
fi

DIST_DIR="dist/templates"
mkdir -p "$DIST_DIR"

export GENRELEASES_DIR="$DIST_DIR"

echo "Building Blog-Tech-Kit templates v$VERSION from .blogkit/ source..."
echo "Output directory: $DIST_DIR"

# Call existing build script (to be created)
.github/workflows/scripts/create-release-packages.sh "$VERSION"

# Generate manifest
generate_manifest "$VERSION" "$DIST_DIR"

echo "Build complete! Templates available in $DIST_DIR/"
```

**Acceptance Criteria**:
- ✅ Script runs without errors
- ✅ Generates all 36 templates by default
- ✅ Supports AGENTS and SCRIPTS filters
- ✅ Creates build-manifest.json
- ✅ Displays summary with file sizes and checksums

#### Task 1.3: Verify .blogkit/ Command Templates

**Files**: `.blogkit/templates/commands/*.md`
**Purpose**: Ensure all command templates use blogkit.* namespace

**Verification**:
- All command files already use `/blogkit.*` naming
- Frontmatter uses `agent: __AGENT__` placeholder (will be replaced with blogkit.specify, etc.)
- Body text uses `/blogkit.*` when referencing commands
- Path references use `.blogkit/` prefix
- Scripts use `.blogkit/scripts/bash/` or `.blogkit/scripts/powershell/`

**Validation Commands**:
```bash
# Check for spec-kit references
grep -r "speckit\." .blogkit/templates/commands/ && echo "ERROR: Found speckit references"

# Check for correct agent placeholder
grep -L "__AGENT__" .blogkit/templates/commands/*.md && echo "WARNING: Missing agent placeholder"

# Verify path references use .specify/
grep -r ".blogkit/" .blogkit/templates/commands/ && echo "WARNING: Found .blogkit/ path references (should use .specify/)"
```

**Acceptance Criteria**:
- ✅ All templates use __AGENT__ placeholder
- ✅ No hardcoded "speckit" or "pmfkit" references
- ✅ Paths use .specify/ prefix
- ✅ Script commands point to bash/ or powershell/ directories

#### Task 1.4: Test Local Build with Single Agent

**Purpose**: Validate build process works before generating all variants

**Test Steps**:
1. Run: `AGENTS=claude SCRIPTS=sh ./scripts/build-templates.sh v0.1.0-test`
2. Verify ZIP file created in dist/templates/
3. Extract ZIP to temporary directory
4. Manually inspect structure:
   - Check .blogkit/ contains memory/, scripts/bash/, templates/
   - Check .claude/commands/ contains 9 blogkit.*.md files
   - Verify constitution.md is Blog-Tech-Kit v1.0.0
   - Confirm no speckit references in command files
   - Verify blog-post-template.md is present

**Validation Commands**:
```bash
# Extract and inspect
unzip -d /tmp/test-template dist/templates/spec-kit-template-claude-sh-v0.1.0-test.zip

# Check structure
ls -la /tmp/test-template/.blogkit/
ls -la /tmp/test-template/.claude/commands/

# Check for spec-kit references
grep -r "speckit" /tmp/test-template/ && echo "ERROR: Found speckit references"

# Check frontmatter
head -5 /tmp/test-template/.claude/commands/blogkit.specify.md
# Should show: agent: blogkit.specify

# Check blog-specific files
test -f /tmp/test-template/.blogkit/templates/blog-post-template.md && echo "✅ Blog template present"
```

**Acceptance Criteria**:
- ✅ ZIP extracts without errors
- ✅ Directory structure matches expected layout
- ✅ All 9 command files present with blogkit.* names
- ✅ Constitution is Blog-Tech-Kit v1.0.0
- ✅ No speckit references found
- ✅ Scripts directory contains only bash/ (not powershell/)
- ✅ Blog-specific template (blog-post-template.md) present

**Blockers**: If this test fails, do NOT proceed to Task 1.5. Fix issues first.

#### Task 1.5: Test Full Build (All 36 Variants)

**Purpose**: Ensure all agent/script combinations generate correctly

**Test Steps**:
1. Run: `./scripts/build-templates.sh v0.1.0-test`
2. Verify 36 ZIP files created
3. Check build-manifest.json contains all variants
4. Verify no failed variants in manifest
5. Spot-check 3-4 variants for correctness

**Validation**:
```bash
# Count ZIPs
ls dist/templates/*.zip | wc -l
# Should output: 36

# Check manifest
cat dist/templates/build-manifest.json | jq '.variants | length'
# Should output: 36

# Verify no failures
cat dist/templates/build-manifest.json | jq '.failed_variants'
# Should output: []
```

**Acceptance Criteria**:
- ✅ Exactly 36 ZIP files generated
- ✅ All variants have "completed" status in manifest
- ✅ No failed variants
- ✅ Total size is reasonable (~2MB for all 36)
- ✅ Checksums are 64-character hex strings

---

## Phase 2: Validation Infrastructure

**Goal**: Create automated validation to prevent publishing bad templates
**Duration**: 2 days
**Dependencies**: Phase 1 complete

### Tasks

#### Task 2.1: Create Validation Script

**File**: `scripts/validate-templates.sh`
**Purpose**: Automated validation of template quality before release

**Validation Checks** (adapted from PMF-Kit):

1. **Frontmatter Namespace Check**: Verify all commands use `agent: blogkit.*`
2. **Required Files Check**: Verify files from .blogkit/ are present in .specify/
3. **Content Scanning**: Search for `/speckit.` or `/pmfkit.` references
4. **Directory Structure Validation**: Verify .specify/ working directory exists
5. **Constitution Version Check**: Verify Blog-Tech-Kit constitution v1.0.0
6. **Script Consistency**: Ensure sh has bash/, ps has powershell/
7. **Command Count**: Verify 9 required commands present
8. **ZIP Integrity**: Test ZIP extracts without errors
9. **Blog-Specific Files**: Verify blog-post-template.md present

**Implementation**: See PMF-Kit reference `scripts/validate-templates.sh` pattern

**Acceptance Criteria**:
- ✅ Script validates all required checks
- ✅ Returns exit code 0 on success, non-zero on failure
- ✅ Provides clear error messages
- ✅ Supports validating single ZIP or directory of ZIPs
- ✅ Generates validation report JSON

#### Task 2.2: Create Validation Test Cases

**Purpose**: Verify validation script catches common errors

**Test Cases**:
1. Wrong namespace (agent: speckit.specify)
2. Missing file (remove constitution.md)
3. Speckit reference in content
4. Wrong scripts (both bash/ and powershell/ in sh variant)
5. Valid template

**Acceptance Criteria**:
- ✅ Negative tests cause validation failure
- ✅ Positive test passes validation
- ✅ Error messages clearly explain issues

#### Task 2.3: Integrate Validation into Build Script

**Purpose**: Run validation automatically after build

**Acceptance Criteria**:
- ✅ Build script calls validation automatically
- ✅ Build fails if validation fails
- ✅ Success message only shown if both build and validation pass

---

## Phase 3: CI/CD Integration

**Goal**: Integrate template generation into GitHub Actions workflow
**Duration**: 1 day
**Dependencies**: Phase 2 complete

### Tasks

#### Task 3.1: Create GitHub Actions Workflow

**File**: `.github/workflows/release.yml` (new)
**Purpose**: Automate release process on main branch pushes

**Key Configuration**:
```yaml
on:
  push:
    branches: [main]
    paths:
      - '.blogkit/**'
      - 'memory/**'
      - 'scripts/**'
      - 'templates/**'
  workflow_dispatch:
```

**Acceptance Criteria**:
- ✅ Workflow triggers on .blogkit/ changes
- ✅ Validation runs after template generation
- ✅ Release created only if validation passes

#### Task 3.2: Update Release Notes Script

**Purpose**: Reference "Blog CLI" instead of "Specify CLI" or "PMF CLI"

**Acceptance Criteria**:
- ✅ Release notes say "Blog CLI"
- ✅ All 36 ZIP files listed with checksums

#### Task 3.3: Test Workflow with Dry Run

**Purpose**: Validate CI workflow before real release

**Acceptance Criteria**:
- ✅ Workflow completes without errors
- ✅ Artifacts can be verified without creating production release

---

## Phase 4: First Release & Validation

**Goal**: Create first Blog-Tech-Kit release and verify CLI integration
**Duration**: 1 day
**Dependencies**: Phase 3 complete

### Tasks

#### Task 4.1: Create First Blog-Tech-Kit Release (v0.1.0)

**Purpose**: Publish v0.1.0 with all 36 templates

**Acceptance Criteria**:
- ✅ Release v0.1.0 created on GitHub
- ✅ 36 template ZIPs present
- ✅ Release notes include changelog and checksums

#### Task 4.2: Verify CLI Downloads Blog-Tech-Kit Templates

**Purpose**: Confirm CLI uses blog-tech-kit releases

**Acceptance Criteria**:
- ✅ CLI downloads from blog-tech-kit repository
- ✅ No fallback to spec-kit occurs
- ✅ Templates have correct structure

#### Task 4.3: Remove Spec-Kit Fallback Logic

**Purpose**: Remove fallback after first release

**Acceptance Criteria**:
- ✅ Fallback code removed
- ✅ CLI only downloads from blog-tech-kit

#### Task 4.4: Update Documentation

**Purpose**: Document Blog-Tech-Kit templates and release process

**Acceptance Criteria**:
- ✅ README mentions Blog-Tech-Kit templates
- ✅ Template structure documented
- ✅ Release process documented

---

## Phase 5: Ongoing Maintenance

**Goal**: Establish processes for future template updates
**Duration**: Ongoing

### Processes

#### Process 5.1: Template Update Workflow

**When**: After changes to .blogkit/ directory

**Steps**:
1. Make changes on feature branch
2. Run local build from .blogkit/ source
3. Run validation
4. Test with CLI
5. Create PR
6. CI runs validation automatically
7. After merge to main, workflow creates new release

#### Process 5.2: Version Numbering Strategy

**Semantic Versioning** for template releases:
- **MAJOR (X.0.0)**: Breaking changes to .blogkit/ structure, constitution principles removed
- **MINOR (0.X.0)**: New commands added, new agents supported, constitution principles added
- **PATCH (0.0.X)**: Bug fixes, documentation updates, script improvements

---

## Complexity Tracking

### Known Complexities

1. **Dual Directory Structure** (Medium Complexity)
   - **Issue**: Source in `.blogkit/`, package to `.specify/` working directory, which is wrong
   - **Impact**: Build script must handle directory mapping
   - **Mitigation**: Clear documentation of multi-kit coexistence strategy
   - **Rationale**: Per Blog-Tech-Kit constitution namespace design

2. **PowerShell Script Creation** (Low Complexity)
   - **Issue**: .blogkit/ currently only has bash scripts
   - **Impact**: Must create PowerShell equivalents for ps variants
   - **Mitigation**: Port bash logic to PowerShell, test on Windows if available
   - **Future**: Could generate PowerShell from bash automatically

3. **Path Rewriting** (Medium Complexity)
   - **Issue**: Command templates reference .specify/ but sourced from .blogkit/
   - **Impact**: Path validation must account for source/target mismatch
   - **Mitigation**: Document clearly, validate both source and generated templates

4. **Namespace Consistency** (High Importance, Low Complexity)
   - **Issue**: Critical that no speckit or pmfkit references leak
   - **Impact**: Would break Blog-Tech-Kit identity
   - **Mitigation**: Multi-phase validation, automated scanning

---

## Success Metrics

### Quantitative Metrics

1. **Build Success Rate**: >99% of builds complete without errors
2. **Validation Pass Rate**: 100% of templates pass validation before release
3. **Release Generation Time**: <10 minutes from push to published release
4. **CLI Download Success**: >95% of blog init commands succeed
5. **Template Consistency**: 100% use blogkit.* namespace

---

## Future Enhancements (Out of Scope)

1. **Automated PowerShell Generation**: Generate .ps1 from .sh automatically
2. **Template Customization UI**: Allow users to customize templates before download
3. **Differential Updates**: Only regenerate templates that changed
4. **Template Analytics**: Track which agents are most popular

---

**Plan Version**: 1.0
**Last Updated**: 2025-12-05
**Status**: Ready for Task Generation
