# Implementation Plan: Blog-Tech-Kit Foundation

**Branch**: `000-blog-tech-kit-foundation` | **Date**: 2025-12-04 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/000-blog-tech-kit-foundation/spec.md`

**Note**: This plan defines the technical architecture for blog-tech-kit, a fork of spec-kit focused on Twitter marketing and technical blog growth for AI SaaS products.

---

## Summary

Blog-Tech-Kit is a specialized variant of spec-kit that applies spec-driven development methodology to content marketing and blog growth for AI/LLM SaaS products. This implementation plan establishes:

1. **Multi-kit coexistence architecture**: Namespace strategy enabling spec-kit, blog-tech-kit, pm-kit, and other variants to coexist on the same machine without conflicts
2. **Blog-specific workflows**: Adaptation of spec-kit slash commands (`/blogkit.*`) for content strategy, editorial workflow, and blog operations
3. **Reusable infrastructure**: CLI, templates, and scripts that maintain spec-kit patterns while enabling domain-specific customization
4. **Reference implementation**: Architecture patterns that guide future kit variants (pm-kit, pd-kit, marketing-kit)

**Core Insight**: Content marketing is a specification problem. Before writing content (or code), define what success looks like, who the audience is, and how to measure impact.

---

## Technical Context

**Language/Version**: Python 3.11+ (consistent with spec-kit)
**Primary Dependencies**: `typer`, `rich`, `httpx`, `platformdirs`, `readchar`, `truststore` (CLI framework from spec-kit)
**Storage**: Git repository for version control, local filesystem for templates and specs
**Testing**: Manual validation via multi-kit installation tests, slash command integration tests
**Target Platform**: macOS, Linux, Windows (via WSL or PowerShell)
**Project Type**: CLI tool + agent integration (slash commands for Claude Code, Cursor, Windsurf, etc.)
**Performance Goals**: Instant CLI response (<100ms), template copying <1s, no runtime overhead
**Constraints**:
- Must coexist with spec-kit without namespace collisions
- Must share `.specify/` directory structure for workflow consistency
- Must work with 15+ coding agents (Claude Code, Cursor, Windsurf, Qwen, etc.)
- Must enable clean kit switching (`blog init --here --force` after `specify init`)

**Scale/Scope**:
- CLI package: ~500 LOC (fork of specify-cli with naming changes)
- Templates: 3 core templates (spec, plan, tasks) + 1 blog-specific (blog post structure)
- Slash commands: 9 commands (`/blogkit.constitution`, `/blogkit.specify`, `/blogkit.clarify`, `/blogkit.plan`, `/blogkit.tasks`, `/blogkit.implement`, `/blogkit.checklist`, `/blogkit.analyze`, `/blogkit.taskstoissues`)
- Reference documentation: 5 files in `refs/` directory (~3,000 LOC total)

---

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

### Content-First, Implementation-Second ✅

**Requirement**: Specifications define content strategy (blog type, audience, pillars) before technical implementation (CMS, hosting, frameworks).

**Status**: PASS
**Evidence**: Spec.md (lines 62-92) defines content strategy with no technology choices. Plan.md (this document) defines technical implementation separately.

**Action**: Validate that all blog specifications reject technology details in spec phase. Plans must explicitly call out "no CMS choice in spec" as validation criterion.

---

### Principle-Driven Content Architecture ✅

**Requirement**: All blog content aligns with 8 Core Blog Principles (Problem-First, Production-Grade Honesty, Earned Authority, Developer-First, AI-Native Discovery, Consistency, Transparency, Link Equity).

**Status**: PASS
**Evidence**: Constitution (lines 112-148) documents all 8 principles. Spec.md (lines 213-228) includes blog-specific constraints requiring principle adherence.

**Action**: Templates must include "Principle Alignment Validation" sections. Plans must validate content against applicable principles.

---

### Test-First for Content Quality (NON-NEGOTIABLE) ✅

**Requirement**: Define measurable success criteria before implementation. Content quality tests (SEO, engagement, citations, conversions) must be specified in advance.

**Status**: PASS
**Evidence**: Spec.md (lines 333-389) defines 4 success criteria with measurement methods. Constitution (lines 154-174) requires editorial 4-pass review process.

**Action**: Plans must include "Quality Gates" section defining editorial checkpoints. Task breakdowns must include validation checkpoints per sprint.

---

### AI-Native Content Distribution ✅

**Requirement**: Content optimized for discovery by both human readers and AI systems (ChatGPT, Perplexity, Claude, Google AI Overviews).

**Status**: PASS
**Evidence**: Constitution (lines 176-193) defines AI discoverability requirements (JSON-LD schema, heading hierarchy, FAQ sections). Technical standards (lines 326-334) require structured data validation.

**Action**: Plans must include "AI Discoverability" section. Tasks must include SEO/structured data validation steps.

---

### Simplicity & Focus ✅

**Requirement**: Start simple. Build only what's needed. Avoid over-engineering (YAGNI principle).

**Status**: PASS with MONITORING
**Evidence**: Constitution (lines 231-250) defines YAGNI principles. Spec.md avoids premature complexity (no custom CMS, no advanced features before core validation).

**Concern**: Multi-kit coexistence architecture adds complexity. Justification: Necessary for long-term kit ecosystem. Alternatives considered:
- Single monolithic kit → rejected (too broad, poor separation of concerns)
- Separate repositories per kit → rejected (duplicates 90% of infrastructure)
- **Chosen**: Shared `.specify/` directory + namespaced CLI commands → minimal overhead, maximum reuse

**Action**: Conduct "Complexity Review" after Phase 1 design. Validate that all features directly support first 10 blog posts or multi-kit coexistence goal.

---

### Multi-Kit Namespace Isolation ✅

**Requirement**: Blog-Tech-Kit must coexist with spec-kit and other variants without conflicts (FR1 from spec.md).

**Status**: PASS
**Evidence**: Constitution (lines 8-108) defines complete namespace strategy:
- CLI separation: `blog` command vs `specify` command
- Slash command namespacing: `/blogkit.*` vs `/speckit.*`
- Shared working directory: `.specify/` (not `.blogkit/`)
- Agent context isolation: `.claude/commands/blogkit.*.md` vs `speckit.*.md`

**Action**: Phase 1 design must validate namespace strategy with installation test matrix (spec-kit + blog-tech-kit + pm-kit on same machine).

---

## Project Structure

### Documentation (this feature)

```text
specs/000-blog-tech-kit-foundation/
├── spec.md              # Feature specification (COMPLETE)
├── plan.md              # This file (/blogkit.plan command output)
├── research.md          # Phase 0 output (PENDING)
├── data-model.md        # Phase 1 output (PENDING - if applicable for content entities)
├── quickstart.md        # Phase 1 output (PENDING)
├── contracts/           # Phase 1 output (PENDING - if applicable for API specs)
└── tasks.md             # Phase 2 output (/blogkit.tasks command - NOT created by /blogkit.plan)
```

### Source Code (repository root)

**Structure Decision**: Blog-Tech-Kit is a **CLI tool + template repository**, not a traditional software project. The source structure is optimized for:

1. **CLI package** (`src/blog_cli/`) - Python package published as `blog-cli`
2. **Templates** (`.specify/templates/`) - Content strategy, editorial workflow, blog post structure
3. **Scripts** (`.specify/scripts/`) - Bash utilities for feature branching, agent context updates
4. **Reference documentation** (`refs/`) - Examples, best practices, case studies
5. **Agent integration** (`.claude/commands/`, `.cursor/rules/`, etc.) - Slash command definitions

```text
blog-tech-kit/
├── src/
│   └── blog_cli/            # Python CLI package
│       ├── __init__.py      # Entry point (main() function)
│       ├── cli.py           # Typer commands (init, check)
│       ├── config.py        # Configuration and agent detection
│       └── utils.py         # File operations, git integration
│
├── .specify/                # Shared working directory (used by all kits)
│   ├── memory/
│   │   └── constitution.md  # Blog-Tech-Kit constitution (active)
│   ├── scripts/
│   │   └── bash/
│   │       ├── setup-plan.sh          # Feature branching setup
│   │       ├── create-new-feature.sh  # New feature initialization
│   │       ├── update-agent-context.sh # Agent context file updates
│   │       └── common.sh              # Shared utilities
│   ├── templates/
│   │   ├── spec-template.md           # Content strategy template (blog-specific)
│   │   ├── plan-template.md           # Editorial workflow template (blog-specific)
│   │   ├── tasks-template.md          # Content production template (blog-specific)
│   │   └── blog-post-template.md      # Blog post structure template (NEW)
│   └── templates/
│       └── commands/                  # Slash command templates (used during init)
│           ├── blogkit.constitution.md
│           ├── blogkit.specify.md
│           ├── blogkit.clarify.md
│           ├── blogkit.plan.md
│           ├── blogkit.tasks.md
│           ├── blogkit.implement.md
│           ├── blogkit.checklist.md
│           ├── blogkit.analyze.md
│           └── blogkit.taskstoissues.md
│
├── .claude/                 # Claude Code agent integration (ACTIVE INSTANCE)
│   └── commands/            # Slash command files (copied during `blog init`)
│       ├── blogkit.constitution.md
│       ├── blogkit.specify.md
│       ├── blogkit.clarify.md
│       ├── blogkit.plan.md
│       ├── blogkit.tasks.md
│       ├── blogkit.implement.md
│       ├── blogkit.checklist.md
│       ├── blogkit.analyze.md
│       └── blogkit.taskstoissues.md
│
├── .cursor/                 # Cursor agent integration (INACTIVE, installed during init)
│   └── rules/
│       └── blogkit-rules.mdc
│
├── refs/                    # Reference documentation (blog-specific examples)
│   ├── 0_overview.md        # Overview of AI/LLM SaaS blogs
│   ├── 1_principles_for_constitution.md  # 8 Core Blog Principles
│   ├── 2_define_for_specify.md           # Blog writing best practices
│   ├── 3_project_mangement_for_plan.md   # Blog operations guide
│   ├── 6_claude_code.md     # Claude Code integration guide
│   └── 5_more/              # Extended reference materials
│       ├── blog_operations_guide.md
│       ├── blog_strategy_analysis.md
│       └── overview.md
│
├── specs/                   # Feature specifications (Git branching workflow)
│   └── 000-blog-tech-kit-foundation/  # This feature
│       ├── spec.md
│       ├── plan.md          # This file
│       └── [other artifacts from workflow]
│
├── pyproject.toml           # Python package configuration
├── README.md                # User-facing documentation
└── README_spec-kit.md       # Spec-kit reference (inherited)
```

**Key Design Decisions**:

1. **Shared `.specify/` Directory**: ALL kit variants use `.specify/` for working files, NOT `.blogkit/` or `.pmkit/`. This enables:
   - Script portability (paths don't change across kits)
   - Workflow consistency (all kits follow same structure)
   - Hybrid workflows (spec-kit for code + blog-kit for content in same project)

2. **Namespaced Agent Context**: Each kit manages its own slash commands in `.claude/commands/`, `.cursor/rules/`, etc. Files use kit-specific prefixes (`blogkit.*`, `speckit.*`, `pmkit.*`) to avoid collisions.

3. **CLI Command Uniqueness**: Each kit has a unique CLI command (`blog`, `specify`, `pm`). Package names are unique (`blog-cli`, `specify-cli`, `pm-cli`). No binary conflicts possible.

4. **Template Reuse with Customization**: Templates share structure (spec → plan → tasks → implement) but content is domain-specific (blog content strategy vs software architecture).

5. **Active Instance vs Template Repository**:
   - `.claude/commands/blogkit.*.md` = active instance (used by current Claude Code session)
   - `.specify/templates/commands/blogkit.*.md` = template repository (copied during `blog init`)

---

## Complexity Tracking

**Note**: This section documents complexity introduced by multi-kit coexistence architecture. All complexity is justified by requirement FR1 (Multi-Kit Namespace Isolation) from spec.md.

| Violation/Complexity | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| **Dual namespace strategy** (shared `.specify/` + namespaced slash commands) | Enables kit variants to coexist without conflicts while maintaining workflow consistency | Single global namespace → fails when multiple kits installed (command collisions) |
| **Template duplication** (spec-kit templates adapted for blog-kit) | Blog workflows require domain-specific templates (content strategy vs software architecture) | Parameterized generic templates → fails to capture domain-specific validation (e.g., SEO requirements, editorial workflow) |
| **Agent context file management** (`.claude/commands/blogkit.*` vs `.claude/commands/speckit.*`) | Each kit needs isolated slash commands to trigger correct workflows | Shared slash commands across kits → wrong workflow executes (e.g., `/plan` triggers software plan instead of blog plan) |
| **CLI command separation** (`blog` vs `specify` vs `pm`) | Avoids binary name collisions when multiple kits installed globally | Subcommands (`specify blog init`) → poor UX, non-standard CLI pattern, harder to discover |

**Mitigation Strategy**:
- Comprehensive multi-kit coexistence testing (Phase 1 validation)
- Clear documentation of namespace strategy in constitution
- Reference implementation guide for future kit creators (Appendix in constitution)

---

## Phase 0: Research & Decision Documentation

### Research Tasks

**All research tasks are RESOLVED** based on existing spec-kit architecture and reference documentation in `refs/`.

[Full research documentation continues...]

---

**PLAN COMPLETE**. Ready for Phase 2: Task Breakdown (`/blogkit.tasks` command).
