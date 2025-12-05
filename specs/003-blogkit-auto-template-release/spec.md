# Feature Specification: Automated Template Release Generation for Blog-Tech-Kit

**Feature Branch**: `003-blogkit-auto-template-release`
**Created**: 2025-12-05
**Status**: Draft
**Input**: Automated template release generation for blog-tech-kit with templates from .blogkit/ directory

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Release Manager Creates New Blog-Tech-Kit Release (Priority: P1)

A Blog-Tech-Kit maintainer wants to create a new release with templates for all supported AI agents (Claude, Cursor, Windsurf, Gemini, Copilot, Qoder, etc.) using both bash and PowerShell script variants. They should be able to trigger the release process that automatically generates 36 template ZIP files and publishes them to GitHub releases.

**Why this priority**: This is the core capability that enables Blog-Tech-Kit to have its own releases and stop relying on Spec-Kit template fallback.

**Independent Test**: Can be fully tested by triggering the release workflow, verifying all 36 ZIP files are generated correctly, and confirming the GitHub release is published with proper naming and versioning.

**Acceptance Scenarios**:

1. **Given** the maintainer has merged changes to main branch, **When** they push to main (affecting .blogkit/, memory/, scripts/, or templates/ paths), **Then** the automated workflow triggers and generates all template variants
2. **Given** the workflow is running, **When** it processes each agent/script combination, **Then** it creates correctly structured ZIP files with Blog-Tech-Kit branding and `/blogkit.*` commands
3. **Given** all templates are generated, **When** the workflow publishes the release, **Then** a GitHub release appears with all 36 ZIP files attached and proper release notes
4. **Given** a release is published, **When** users run `blog init my-project`, **Then** the CLI downloads templates from blog-tech-kit releases (not spec-kit fallback)

---

### User Story 2 - Developer Tests Template Generation Locally (Priority: P2)

A developer wants to test template generation locally before pushing changes, ensuring their modifications to templates or scripts work correctly across all agent/script combinations.

**Why this priority**: Enables rapid iteration and validation without waiting for CI/CD, reducing the feedback loop for template development.

**Independent Test**: Can be tested by running the local build script and verifying all template ZIPs are created in the dist/ directory with correct structure and content.

**Acceptance Scenarios**:

1. **Given** a developer has modified templates in .blogkit/, **When** they run `./scripts/build-templates.sh`, **Then** all 36 template variants are generated locally in `dist/templates/`
2. **Given** templates are built locally, **When** the developer inspects a ZIP file, **Then** it contains the correct directory structure with agent-specific commands and Blog-Tech-Kit branding
3. **Given** a build completes, **When** errors occur in any template, **Then** the script reports which template failed and provides actionable error messages
4. **Given** local testing is complete, **When** the developer commits changes, **Then** CI validation runs the same build process to catch issues before release

---

### User Story 3 - CI System Validates Template Integrity (Priority: P2)

The continuous integration system should validate that all templates are correctly formatted, contain required files from .blogkit/, and have proper Blog-Tech-Kit branding before allowing merge to main.

**Why this priority**: Prevents broken or incomplete templates from being released, maintaining quality standards.

**Independent Test**: Can be tested by triggering CI on a pull request and verifying it checks for required files, validates command references, and ensures no Spec-Kit references remain.

**Acceptance Scenarios**:

1. **Given** a pull request modifies templates, **When** CI runs validation, **Then** it verifies all templates contain required files (commands from .blogkit/templates/commands/, scripts, constitution from .blogkit/memory/)
2. **Given** CI is validating templates, **When** it finds `/speckit.*` references that should be `/blogkit.*`, **Then** the build fails with clear error messages
3. **Given** CI validation passes, **When** templates are generated, **Then** automated tests extract and verify the structure of each ZIP file
4. **Given** all validations pass, **When** maintainer merges the PR, **Then** the changes are ready for the next release

---

### Edge Cases

- What happens if a template ZIP fails to generate for one agent but succeeds for others?
- How does the system handle version numbering when multiple releases happen on the same day?
- What if the GitHub API rate limit is exceeded during release publication?
- How are templates validated to ensure no Spec-Kit references remain and all .blogkit/ content is included?
- What happens if the release workflow is triggered but no templates have changed?
- How does the system handle migration if .blogkit/ structure changes in future versions?

## Requirements *(mandatory)*

### Functional Requirements

#### Template Generation

- **FR-001**: System MUST generate template variants for all 18 supported AI agents: claude, cursor-agent, windsurf, gemini, copilot, qoder, qwen, opencode, codex, kilocode, auggie, codebuddy, amp, shai, q (Amazon Q), bob, roo
- **FR-002**: System MUST generate both bash (sh) and PowerShell (ps) script variants for each agent, resulting in 36 total template combinations
- **FR-003**: Each template MUST include agent-specific command directory (e.g., `.claude/commands/`, `.cursor/commands/`, `.windsurf/commands/`)
- **FR-004**: Each template MUST contain Blog-Tech-Kit specific files from .blogkit/ directory: constitution.md from .blogkit/memory/, blog-focused spec/plan/tasks templates from .blogkit/templates/, and blog-specific command files from .blogkit/templates/commands/
- **FR-005**: All agent command files MUST use `/blogkit.*` command prefix (not `/speckit.*`)
- **FR-006**: Template naming MUST follow pattern: `spec-kit-template-{agent}-{script}-v{version}.zip` for compatibility with existing CLI code
- **FR-007**: Each template ZIP MUST contain proper directory structure: `.{agent}/commands/`, `.specify/templates/`, `.specify/scripts/{bash|powershell}/`, `.specify/memory/` (note: uses .specify/ working directory per constitution, not .blogkit/)

#### Build System

- **FR-008**: System MUST provide local build script (`scripts/build-templates.sh`) that generates all 36 template variants in `dist/templates/` directory
- **FR-009**: Build script MUST copy content from .blogkit/ source directory into .specify/ structure in generated templates
- **FR-010**: Build script MUST be idempotent and support incremental rebuilds
- **FR-011**: Build script MUST validate template structure before creating ZIP files
- **FR-012**: Build script MUST report progress and any errors encountered during generation
- **FR-013**: Build script MUST calculate and verify SHA-256 checksums for each generated ZIP file

#### GitHub Actions Workflow

- **FR-014**: System MUST provide GitHub Actions workflow (`.github/workflows/release.yml`) that triggers on push to main when .blogkit/, memory/, scripts/, or templates/ paths are modified
- **FR-015**: Workflow MUST execute the build script to generate all template variants
- **FR-016**: Workflow MUST create a GitHub release with generated templates as release assets
- **FR-017**: Workflow MUST generate release notes that include changelog, template list, and SHA-256 checksums
- **FR-018**: Workflow MUST support manual triggering via `workflow_dispatch` for testing

#### Template Validation

- **FR-019**: System MUST provide validation script (`scripts/validate-templates.sh`) that verifies template integrity
- **FR-020**: Validation MUST check for presence of required files in each template: command files from .blogkit/templates/commands/, templates from .blogkit/templates/, scripts, constitution from .blogkit/memory/
- **FR-021**: Validation MUST scan for unintended `/speckit.*` references that should be `/blogkit.*`
- **FR-022**: Validation MUST verify agent command frontmatter uses correct `agent: blogkit.{command}` format
- **FR-023**: Validation MUST confirm all templates reference Blog-Tech-Kit (not Spec-Kit) in branding and documentation
- **FR-024**: Validation MUST verify Blog-Tech-Kit constitution (v1.0.0) is present in templates

#### CI Integration

- **FR-025**: System MUST provide CI workflow (`.github/workflows/ci.yml`) that runs on pull requests
- **FR-026**: CI MUST execute template validation before allowing merge
- **FR-027**: CI MUST build all templates to ensure they can be generated successfully
- **FR-028**: CI MUST fail if any template contains Spec-Kit references or missing required files from .blogkit/

### Key Entities

- **Template Variant**: A combination of agent type and script type (e.g., claude-sh, cursor-ps), resulting in 36 unique variants
- **Agent Configuration**: Metadata for each supported agent including name, command directory name, and whether it requires CLI tools
- **Template ZIP**: A compressed archive containing all files needed for a specific agent/script combination
- **Release Asset**: A ZIP file attached to a GitHub release with versioned naming and SHA-256 checksum
- **Build Manifest**: JSON file documenting all generated templates with metadata (agent, script, size, checksum, timestamp)
- **Template Base**: Source directory structure (.blogkit/) containing Blog-Tech-Kit specific files before agent/script customization
- **Command File**: Markdown file with YAML frontmatter that defines a `/blogkit.*` slash command for AI agents
- **Blog Constitution**: Blog-Tech-Kit constitution (v1.0.0) from .blogkit/memory/constitution.md defining blog-specific principles

## Success Criteria *(mandatory)*

### Measurable Outcomes

#### Release Automation Success

- **SC-001**: Maintainer can create a new release by pushing changes to main (affecting .blogkit/ paths), with full automation completing in under 10 minutes
- **SC-002**: Each release generates exactly 36 template ZIP files (18 agents × 2 script types) with correct naming and structure
- **SC-003**: GitHub release page displays all templates with proper versioning, release notes, and SHA-256 checksums
- **SC-004**: After release, `blog init` command successfully downloads templates from blog-tech-kit repository (not spec-kit fallback)

#### Template Quality

- **SC-005**: 100% of generated templates pass validation checks: correct structure, required files from .blogkit/ present, no Spec-Kit references
- **SC-006**: All templates contain `/blogkit.*` command references (zero `/speckit.*` references remain)
- **SC-007**: Each template includes Blog-Tech-Kit constitution v1.0.0 with blog-specific principles from .blogkit/memory/constitution.md
- **SC-008**: Templates extract successfully and create functional blog projects when used with `blog init`

#### Developer Experience

- **SC-009**: Developers can build all templates locally in under 5 minutes using `./scripts/build-templates.sh`
- **SC-010**: Local builds produce identical results to CI builds (byte-for-byte reproducible)
- **SC-011**: CI validation catches template issues before merge, with 95% of problems detected before release
- **SC-012**: Build script provides clear progress indicators and actionable error messages when failures occur

#### Maintainability

- **SC-013**: Adding a new AI agent requires modifying only the AGENTS array in build script (under 5 lines of code)
- **SC-014**: Template structure changes in .blogkit/ automatically propagate to all 36 variants without manual editing
- **SC-015**: Release process is fully automated with zero manual steps required after push to main
- **SC-016**: All workflows and scripts are documented with inline comments explaining each step

## Out of Scope *(optional)*

- Automated testing of templates with actual AI agents (manual testing required)
- Generating templates for agents not listed in the 18 supported agents
- Creating separate blog-tech-kit-template naming convention (keeping spec-kit naming for CLI compatibility)
- Hosting templates outside GitHub releases (S3, CDN, etc.)
- Automatic version bumping in pyproject.toml (manual version management)
- Rollback mechanism for failed releases (manual deletion/recreation required)
- Template customization per agent beyond command directory names (all agents use same blog templates)
- Docker-based build environment (assumes standard Unix/Windows environments)
- Migration tools for users switching from spec-kit to blog-tech-kit

## Assumptions *(optional)*

- GitHub Actions is available and workflows can be enabled in the repository
- Repository has proper permissions to create releases and upload assets
- Build environment has bash, zip, and standard Unix utilities available
- PowerShell templates can be generated on Unix systems (script copying only, no execution needed)
- Maximum template ZIP size will not exceed GitHub's 2GB release asset limit
- Template generation completes within GitHub Actions timeout (6 hours max)
- Version tags follow semantic versioning (v{major}.{minor}.{patch})
- All AI agents use similar directory structures (`.{agent}/commands/` pattern)
- Templates will be used with uv package manager for installation
- Local builds run on macOS or Linux (Windows support via Git Bash or WSL)
- .blogkit/ directory structure is stable and won't require breaking changes in v1.x
- CLI download function expects spec-kit-template-* naming (cannot be changed without CLI update)

## Dependencies *(optional)*

- **GitHub Actions**: Required for automated releases and CI validation
- **GitHub Releases API**: For publishing releases and uploading assets
- **Bash**: Required for build and validation scripts
- **zip utility**: Required for creating template archives
- **Git**: Required for versioning and tag-based triggering
- **sed/awk/grep**: Required for text processing during template generation
- **Python 3.11+**: May be used for validation scripts (optional)
- **.blogkit/ directory**: Source for all Blog-Tech-Kit specific content (constitution, templates, commands)

## Constraints *(optional)*

- Must maintain CLI compatibility by using `spec-kit-template-` naming convention
- Must support all 18 agents that Spec-Kit supports
- Must generate both bash and PowerShell variants for each agent
- Build scripts must work on Unix-like systems (macOS, Linux)
- GitHub Actions free tier limits: 2000 minutes/month for private repos
- Template ZIPs must be under 2GB each (GitHub release asset limit)
- Must not require Docker or containerization for local builds
- Must preserve .specify/ working directory structure (per Blog-Tech-Kit constitution namespace strategy)
- Must copy content from .blogkit/ source into .specify/ in generated templates
- Cannot modify .blogkit/ directory during build (read-only source)

## Related Features or Documentation *(optional)*

- **Spec-Kit Release Process**: https://github.com/github/spec-kit/blob/main/.github/workflows/release.yml - Reference implementation for template generation workflow
- **PMF-Kit Release Implementation**: `specs/002-automated-template-releases/` - Sister implementation for pmf-kit showing proven patterns
- **Blog-Tech-Kit Constitution**: `.blogkit/memory/constitution.md` - Blog-specific principles (v1.0.0) to include in all templates
- **Blog-Tech-Kit Templates**: `.blogkit/templates/` directory - Source templates for spec, plan, tasks that need to be included in each variant
- **Blog-Tech-Kit Commands**: `.blogkit/templates/commands/` - Command templates that define `/blogkit.*` slash commands
- **CLI Template Downloader**: `/src/blog_cli/__init__.py` - `download_template_from_github()` function that expects `spec-kit-template-{agent}-{script}.zip` naming
- **Template Fallback Logic**: Currently implemented fallback to spec-kit templates when blog-tech-kit releases don't exist (to be removed after first release)
- **Multi-Kit Coexistence Strategy**: Blog-Tech-Kit constitution Section "Preamble: Multi-Kit Architecture & Coexistence Strategy" - Explains .specify/ vs .blogkit/ directory usage
