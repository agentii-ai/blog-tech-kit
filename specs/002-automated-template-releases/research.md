# Research: Automated Template Release Generation

**Feature**: Automated template release generation for multiple AI agents
**Branch**: 002-automated-template-releases
**Date**: 2025-12-04

## Executive Summary

This research document resolves technical unknowns and documents technology decisions for implementing automated template release generation for blog-Kit. The system will generate 36 template variants (18 agents × 2 script types) and publish them to GitHub releases, enabling blog-Kit to have its own releases instead of relying on Spec-Kit fallback.

## Technology Decisions

### Decision 1: Template Archive Format

**Decision**: Use ZIP format with `spec-kit-template-{agent}-{script}-v{version}.zip` naming convention

**Rationale**:
- Existing CLI code (`download_template_from_github()`) expects this exact naming pattern
- ZIP is universally supported across all platforms (macOS, Linux, Windows)
- GitHub releases support ZIP files natively
- Size is well within GitHub's 2GB asset limit (templates are ~50-55KB each)
- Maintains backward compatibility with existing `blog init` command

**Alternatives Considered**:
- **tar.gz format**: More common in Unix environments, but requires additional handling on Windows
- **blog-kit-template-* naming**: Would require changing CLI code unnecessarily; keeping spec-kit naming maintains compatibility
- **Single mega-archive**: Would be harder to manage and require CLI changes to extract specific variants

**Implementation Impact**: None - existing scripts already use this format

---

### Decision 2: Build Script Language

**Decision**: Use Bash for all build and validation scripts

**Rationale**:
- Existing blog-Kit infrastructure uses Bash (setup-plan.sh, create-new-feature.sh, etc.)
- GitHub Actions runners (ubuntu-latest) include Bash by default
- Spec-Kit reference implementation uses Bash successfully
- Team has existing Bash expertise from current scripts
- Can generate PowerShell templates from Unix systems (just file copying, no execution needed)

**Alternatives Considered**:
- **Python**: More readable and testable, but adds dependency and complexity for simple file operations
- **Node.js**: Would require npm install step in CI, adds build time
- **Make**: Less portable, harder to read for complex logic
- **PowerShell**: Not available by default on GitHub Actions ubuntu-latest runners

**Implementation Impact**:
- Build scripts at `.github/workflows/scripts/` remain Bash
- Validation scripts can use Bash utilities (grep, sed, awk)
- No additional CI setup required

---

### Decision 3: Agent Support List

**Decision**: Support 18 agents matching Spec-Kit's current list

**Agents**: claude, cursor-agent, windsurf, gemini, copilot, qoder, qwen, opencode, codex, kilocode, auggie, codebuddy, amp, shai, q (Amazon Q), bob, roo

**Rationale**:
- Matches Spec-Kit's proven agent support matrix
- Each agent has established directory structure patterns
- Reference implementation (create-release-packages.sh:226) provides complete list
- No custom agents needed for blog-Kit's use case

**Alternatives Considered**:
- **Subset of agents**: Would reduce testing surface but limit user choice unnecessarily
- **Extended agent list**: No new agents identified that need support yet
- **Configurable agent list**: Over-engineering for current needs; hard-coding is simpler

**Implementation Impact**:
- AGENTS array in build script contains all 18 agents
- Each agent gets specific command directory structure (e.g., `.claude/commands/`, `.cursor/commands/`)
- Validation must check all 18 × 2 = 36 variants

---

### Decision 4: Command Namespace Strategy

**Decision**: Use `/blogkit.*` prefix for all slash commands (not `/speckit.*`)

**Rationale**:
- Constitution Principle VI (Kit Namespace Isolation) requires unique namespaces
- Enables users to install both spec-kit and blog-kit simultaneously
- Prevents command conflicts when multiple kit variants are installed
- Already implemented in existing command templates (templates/commands/*.md)

**Alternatives Considered**:
- **Keep /speckit.* prefix**: Would cause conflicts with spec-kit; violates constitution
- **Use /blog.* prefix**: Too short, potential conflicts with other tools
- **Use /specify.* prefix**: Conflicts with spec-kit's namespace

**Implementation Impact**:
- Validate all generated templates use `agent: blogkit.{command}` in frontmatter
- Scan for any remaining `/speckit.*` references and flag as errors
- Update template generation to ensure correct namespace

---

### Decision 5: GitHub Release Automation Approach

**Decision**: Use GitHub Actions workflow triggered on main branch push with automatic version detection

**Rationale**:
- Existing `.github/workflows/release.yml` already implements this pattern
- No manual tag creation required - version auto-increments
- Checks for existing releases to prevent duplicates
- Runs only when relevant files change (memory/, scripts/, templates/)
- Supports manual triggering via workflow_dispatch for testing

**Alternatives Considered**:
- **Manual tag-based triggering**: Requires maintainer to create tags, more error-prone
- **Scheduled releases**: Would create releases even when nothing changed
- **PR-based releases**: Would create releases for every PR, too noisy
- **External CI (CircleCI, Travis)**: GitHub Actions is free and integrated

**Implementation Impact**:
- Keep existing release.yml workflow structure
- Modify `create-release-packages.sh` to use blog-Kit templates
- Ensure version numbering respects existing releases

---

### Decision 6: Template Structure Organization

**Decision**: Use `.specify/` directory for shared content, agent-specific directories for commands

**Structure**:
```
template-root/
├── .specify/
│   ├── memory/
│   │   └── constitution.md (blog-Kit v1.0.0)
│   ├── scripts/
│   │   ├── bash/ (for sh variants)
│   │   └── powershell/ (for ps variants)
│   └── templates/
│       ├── spec-template.md
│       ├── plan-template.md
│       └── tasks-template.md
└── .{agent}/
    └── commands/ (or prompts/, workflows/ - agent-specific)
        ├── blogkit.specify.md
        ├── blogkit.plan.md
        ├── blogkit.tasks.md
        └── ...
```

**Rationale**:
- Matches existing template structure from Spec-Kit
- `.specify/` is recognized by existing CLI code
- Agent directories follow established conventions (e.g., `.claude/`, `.cursor/`)
- Separates shared content from agent-specific commands

**Alternatives Considered**:
- **Flat structure**: Would mix shared and agent-specific files, harder to maintain
- **Different directory name (.blogkit/)**: Would require CLI changes
- **Per-agent constitution**: Would duplicate content unnecessarily

**Implementation Impact**:
- Build script copies memory/, scripts/, templates/ to `.specify/`
- Commands are generated per-agent with proper path references
- Validation checks both `.specify/` and agent directories

---

### Decision 7: Template Validation Strategy

**Decision**: Multi-phase validation: frontmatter check, content scan, structure verification

**Validation Phases**:
1. **Frontmatter validation**: Ensure `agent: blogkit.*` in all command files
2. **Content scanning**: Search for any `/speckit.*` references that should be `/blogkit.*`
3. **Structure verification**: Check for required files (constitution, templates, scripts)
4. **ZIP integrity**: Verify archives extract correctly and contain expected structure

**Rationale**:
- Prevents publishing templates with wrong namespace
- Catches copy-paste errors from Spec-Kit templates
- Ensures all templates meet constitution requirements
- Early error detection before release

**Alternatives Considered**:
- **Manual validation**: Error-prone, doesn't scale
- **Post-release validation**: Too late - errors already published
- **Runtime validation in CLI**: Doesn't prevent bad releases from being created
- **Schema-based validation**: Over-engineering for simple checks

**Implementation Impact**:
- Create `scripts/validate-templates.sh` with grep/sed checks
- Run validation in CI before allowing merge
- Fail fast on validation errors with clear messages

---

### Decision 8: Release Notes Generation

**Decision**: Auto-generate release notes from git commits since last release

**Format**:
```markdown
This is the latest set of releases that you can use with your agent of choice.
We recommend using the blog CLI to scaffold your projects, however you can
download these independently and manage them yourself.

## Changelog
- commit message 1
- commit message 2
...

## Assets
36 template variants with SHA-256 checksums
```

**Rationale**:
- Existing `generate-release-notes.sh` already implements this
- Provides transparency on what changed
- Includes checksums for security verification
- Matches Spec-Kit's release note format

**Alternatives Considered**:
- **Manual release notes**: Time-consuming, inconsistent
- **Conventional commits parsing**: Requires commit format discipline
- **Changelog file**: Must be maintained manually
- **AI-generated summaries**: Adds complexity and API dependencies

**Implementation Impact**:
- Keep existing generate-release-notes.sh script
- Update text to reference "blog CLI" instead of "Specify CLI"
- Ensure SHA-256 checksums are calculated for all ZIPs

---

## Technical Unknowns Resolved

### Unknown 1: How to prevent Spec-Kit references from leaking into blog-Kit templates?

**Resolution**: Multi-layered prevention strategy

1. **Source Control**: Keep templates/ directory with blog-Kit specific content only
2. **Build-time Substitution**: Use sed/awk in generate_commands() to rewrite paths
3. **Validation**: Grep for `/speckit.` patterns and fail if found
4. **Frontmatter Check**: Ensure all commands use `agent: blogkit.*`

**Evidence**: Existing create-release-packages.sh:33-38 shows rewrite_paths() function that handles path substitution

---

### Unknown 2: How to test template generation locally without publishing?

**Resolution**: Local build script that mirrors CI behavior

**Approach**:
- Create `scripts/build-templates.sh` that wraps create-release-packages.sh
- Generates all templates to `dist/templates/` directory
- Provides verbose output showing progress
- Allows AGENTS and SCRIPTS env vars to build subset for faster iteration

**Example Usage**:
```bash
# Build all templates
./scripts/build-templates.sh v0.1.0-test

# Build only Claude templates for testing
AGENTS=claude ./scripts/build-templates.sh v0.1.0-test

# Build only bash variants
SCRIPTS=sh ./scripts/build-templates.sh v0.1.0-test
```

---

### Unknown 3: How to handle version numbering when multiple releases happen rapidly?

**Resolution**: Semantic versioning with automatic patch increment

**Strategy**:
- Major.Minor versions bumped manually (e.g., 0.1.0 → 0.2.0 for new features)
- Patch version auto-increments on each release (e.g., 0.1.0 → 0.1.1)
- Existing `get-next-version.sh` handles this logic
- Checks for duplicate releases and skips if already exists

**Edge Case Handling**:
- Same-day releases: Patch version increments (0.1.0 → 0.1.1 → 0.1.2)
- Failed releases: Delete release tag, re-run workflow
- Hot fixes: Manual version bump in release notes if needed

---

### Unknown 4: How to ensure templates work with actual AI agents after generation?

**Resolution**: Structured testing approach

**Manual Testing Required** (out of scope for automation):
- Extract template ZIP to test directory
- Run `blog init my-test-project --agent=claude --script=sh`
- Verify CLI downloads blog-Kit template (not Spec-Kit fallback)
- Test each `/blogkit.*` command works in agent
- Verify scripts execute correctly

**Automated Testing** (in scope):
- ZIP integrity check (can extract without errors)
- Directory structure validation (expected files present)
- Frontmatter parsing (YAML is valid)
- Content validation (no Spec-Kit references)

**Testing Plan**:
- Test matrix: Pick 2-3 representative agents (Claude, Cursor, Gemini)
- Test both bash and PowerShell variants
- Document testing results in release notes

---

## Dependencies & Prerequisites

### Required Tools
- **Bash 4.0+**: For scripts with arrays and modern syntax
- **zip utility**: For creating archives (available on all platforms)
- **git**: For version detection and changelog generation
- **GitHub CLI (gh)**: For release creation (available in Actions)
- **sed/awk/grep**: For text processing (standard Unix tools)

### GitHub Configuration
- **Repository permissions**: Contents: write (for releases)
- **Secrets**: GITHUB_TOKEN (automatically provided by Actions)
- **Branch protection**: Optional - main branch should be stable

### Local Development
- **macOS or Linux**: Build scripts assume Unix environment
- **Git Bash or WSL**: For Windows local development
- **Python 3.11+**: Optional - for enhanced validation scripts

---

## Implementation Patterns

### Pattern 1: Idempotent Build Script

**Principle**: Build script can be run multiple times without side effects

**Implementation**:
```bash
# Clean before build
GENRELEASES_DIR=".genreleases"
rm -rf "$GENRELEASES_DIR"/* || true
mkdir -p "$GENRELEASES_DIR"

# Build fresh each time
for agent in "${AGENT_LIST[@]}"; do
  build_variant "$agent" "$script"
done
```

**Benefit**: Safe to re-run on failures, no stale artifacts

---

### Pattern 2: Fail-Fast Validation

**Principle**: Catch errors early before expensive operations

**Implementation**:
```bash
set -euo pipefail  # Exit on error, undefined vars, pipe failures

# Validate version format
if [[ ! $NEW_VERSION =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Version must look like v0.0.0" >&2
  exit 1
fi

# Validate agent list
validate_subset agent ALL_AGENTS "${AGENT_LIST[@]}" || exit 1
```

**Benefit**: Fast feedback, prevents partial releases

---

### Pattern 3: Progressive Disclosure in Output

**Principle**: Provide high-level progress, detailed logs on errors

**Implementation**:
```bash
echo "Building release packages for $NEW_VERSION"
echo "Agents: ${AGENT_LIST[*]}"
echo "Scripts: ${SCRIPT_LIST[*]}"

for agent in "${AGENT_LIST[@]}"; do
  echo "Building $agent ($script) package..."
  # Detailed operations...
  echo "Created spec-kit-template-${agent}-${script}-${NEW_VERSION}.zip"
done
```

**Benefit**: Users see progress, can debug failures

---

## Risks & Mitigations

### Risk 1: Templates contain Spec-Kit references

**Likelihood**: Medium (copy-paste errors)
**Impact**: High (breaks blog-Kit identity)
**Mitigation**:
- Automated validation in CI
- Grep for `/speckit.` patterns
- Frontmatter checks for `agent: blogkit.*`
- Manual review of first release

---

### Risk 2: CLI still falls back to Spec-Kit releases

**Likelihood**: Low (already tested)
**Impact**: High (defeats purpose of separate releases)
**Mitigation**:
- Test CLI with actual release
- Verify download URLs in CLI code
- Check fallback logic triggers only when blog-Kit release missing

---

### Risk 3: Template structure changes break CLI extraction

**Likelihood**: Low (structure is standardized)
**Impact**: High (CLI can't extract templates)
**Mitigation**:
- Match Spec-Kit structure exactly
- Test extraction with CLI locally
- Validate ZIP structure in CI

---

### Risk 4: GitHub Actions rate limits or failures

**Likelihood**: Low (free tier has generous limits)
**Impact**: Medium (release delayed)
**Mitigation**:
- Workflow checks for existing releases first
- Supports manual workflow_dispatch trigger
- Can run build script locally and upload manually

---

## Open Questions

### Q1: Should we support customizing which agents are included in a release?

**Answer**: Not initially. Keep it simple - all 36 variants every release.

**Rationale**:
- Simplifies CI logic
- Users expect consistent releases
- Build time is fast enough (~2-3 minutes for all)
- Can add filtering later if needed

---

### Q2: How often should releases be created?

**Answer**: On-demand when templates or constitution change.

**Rationale**:
- Workflow triggers on changes to memory/, scripts/, templates/
- Avoids empty releases
- Maintainer can review changes before merge

**Recommended Cadence**:
- After constitution updates (rare)
- After template improvements (monthly)
- After bug fixes in scripts (as needed)

---

### Q3: Should we version templates independently from CLI?

**Answer**: No - use single version number for both.

**Rationale**:
- Simpler mental model (one blog-Kit version)
- Templates and CLI should stay in sync
- Matches Spec-Kit's approach

**Version Strategy**:
- Template releases and CLI releases use same version
- Major version change when constitution principles change
- Minor version change when new features added
- Patch version change for bug fixes

---

## References

- **Spec-Kit Release Process**: https://github.com/github/spec-kit/blob/main/.github/workflows/release.yml
- **Spec-Kit Templates**: https://github.com/github/spec-kit/releases/latest
- **blog-Kit Constitution**: `/memory/constitution.md` (v1.0.0)
- **Existing Build Script**: `.github/workflows/scripts/create-release-packages.sh`
- **CLI Template Downloader**: `/src/blog_cli/__init__.py`

---

**Research Complete**: All unknowns resolved, ready for design phase.
