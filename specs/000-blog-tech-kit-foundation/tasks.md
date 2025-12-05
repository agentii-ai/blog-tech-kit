# Tasks: Blog-Tech-Kit Foundation

**Input**: Design documents from `/specs/000-blog-tech-kit-foundation/`
**Prerequisites**: plan.md (complete), spec.md (complete), constitution.md (complete)

**Tests**: Not requested - this is infrastructure/tooling development. Validation via manual multi-kit installation testing.

**Organization**: Tasks are organized by user story (US1-US6) to enable independent implementation and testing of each capability.

---

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

---

## Path Conventions

- **CLI Package**: `src/blog_cli/` (Python package)
- **Shared Working Directory**: `.blogkit/` (blog-tech-kit specific directory)
- **Templates**: `.blogkit/templates/` (blog-specific templates)
- **Scripts**: `.blogkit/scripts/bash/` (blog utilities)
- **Agent Context**: `.claude/commands/`, `.cursor/rules/` (kit-specific files, do not edit .claude/ folder)
- **Reference Docs**: `refs/` (blog-specific examples and guides)

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and verification of existing structure

**Note**: Blog-tech-kit is a fork of spec-kit. Most infrastructure already exists. Setup focuses on verification and preparation.

- [x] T001 Verify existing project structure matches plan.md specifications
- [x] T002 Verify Python 3.11+ environment and `uv` package manager installed
- [x] T003 [P] Verify Git repository initialized and on feature branch `000-blog-tech-kit-foundation`
- [x] T004 [P] Verify `.blogkit/` directory structure exists with memory/, scripts/, templates/ subdirectories
- [x] T005 [P] Verify existing reference documentation in `refs/` directory (5 core files + 5_more/)
- [x] T006 Verify pyproject.toml configured with package name `blog-cli` and command `blog`

**Checkpoint**: Environment validated - blog-tech-kit implementation can begin

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T007 Verify constitution.md contains blog-specific principles (8 Core Blog Principles, Blog-Specific Constraints, Quality Gates)
- [x] T008 Verify namespace strategy documented in constitution.md (CLI separation, slash command namespacing, dedicated .blogkit/ directory)
- [x] T009 [P] Create placeholder blog-specific templates in `.blogkit/templates/` (spec-template.md, plan-template.md, tasks-template.md - will be adapted in Phase 3)
- [x] T010 [P] Create placeholder slash command templates in `.blogkit/templates/commands/` (blogkit.*.md files - will be adapted in Phase 4)
- [x] T011 Verify reference documentation structure complete (`refs/0_overview.md`, `refs/1_principles_for_constitution.md`, `refs/2_define_for_specify.md`, `refs/3_project_mangement_for_plan.md`, `refs/4_pm_tasking_for_tasks.md`, `refs/6_claude_code.md`, `refs/5_more/`)

**Checkpoint**: Foundation ready - user story implementation can now begin

---

## Phase 3: User Story 1 - Install Blog-Tech-Kit Alongside Spec-Kit (Priority: P0) 🎯 MVP

**Goal**: Enable multi-kit coexistence so users can install blog-tech-kit without conflicting with spec-kit

**Independent Test**: Install both spec-kit and blog-tech-kit on same machine. Verify both `specify` and `blog` commands work independently.

### Implementation for User Story 1

- [x] T012 [P] [US1] Verify CLI package name `blog-cli` in `pyproject.toml` (lines 2-3)
- [x] T013 [P] [US1] Verify CLI command `blog` mapped to `blog_cli:main` in `pyproject.toml` (line 16)
- [x] T014 [P] [US1] Verify package dependencies in `pyproject.toml` include `typer`, `rich`, `httpx`, `platformdirs`, `readchar`, `truststore`
- [x] T015 [US1] Update `src/blog_cli/__init__.py` to define `main()` entry point (if not already present from spec-kit fork)
- [x] T016 [US1] Update `src/blog_cli/cli.py` to implement `blog init` and `blog check` commands using typer
- [x] T017 [US1] Update `src/blog_cli/config.py` to detect agent in use (Claude Code, Cursor, Windsurf, etc.)
- [x] T018 [US1] Update `src/blog_cli/utils.py` to handle file operations and git integration
- [x] T019 [US1] Test local installation: `uv tool install blog-cli --from .` and verify `blog --help` works
- [x] T020 [US1] Test namespace isolation: Install both spec-kit and blog-tech-kit, verify no CLI command conflicts (NOTE: Tested in Phase 12 Multi-Kit Validation)

**Checkpoint**: CLI package functional - `blog init` and `blog check` commands work without conflicting with `specify` commands

---

## Phase 4: User Story 2 - Initialize Blog Content Strategy Project (Priority: P1)

**Goal**: Users can bootstrap a blog project with blog-specific templates, constitution, and commands

**Independent Test**: Run `blog init my-ai-blog` in empty directory. Verify blog-specific constitution, templates, and slash commands are present.

### Implementation for User Story 2

- [x] T021 [P] [US2] Update `blog init` command in `src/blog_cli/cli.py` to copy blog-tech-kit constitution to `.blogkit/memory/constitution.md`
- [x] T022 [P] [US2] Update `blog init` command to copy blog-specific templates from `.blogkit/templates/` to new project
- [x] T023 [P] [US2] Update `blog init` command to copy slash command templates from `.blogkit/templates/commands/` to `.claude/commands/` (or appropriate agent directory)
- [x] T024 [P] [US2] Update `blog init` command to copy bash scripts from `.blogkit/scripts/bash/` to new project
- [x] T025 [US2] Update `blog init` command to handle `--here` flag (initialize in current directory)
- [x] T026 [US2] Update `blog init` command to handle `--force` flag (skip confirmation when directory has files)
- [x] T027 [US2] Update `blog init` command to handle `--ai` flag (claude, cursor, windsurf, etc.)
- [x] T028 [US2] Update `blog init` command to initialize Git repository (unless `--no-git` flag provided)
- [x] T029 [US2] Test `blog init my-test-blog` creates complete project structure with blog-specific files
- [x] T030 [US2] Test `blog init --here --force` in existing directory overlays blog-tech-kit files

**Checkpoint**: `blog init` command functional - users can create new blog projects with complete blog-tech-kit infrastructure

---

## Phase 5: User Story 3 - Define Content Strategy with `/blogkit.specify` (Priority: P1)

**Goal**: Users can create blog content strategy specifications (blog type, audience, pillars, success metrics) without implementation details

**Independent Test**: Run `/blogkit.specify` in Claude Code. Verify spec.md is created with blog-specific sections (no CMS/framework mentions).

### Implementation for User Story 3

- [x] T031 [P] [US3] Adapt `spec-template.md` in `.blogkit/templates/` for blog content strategy (replace software sections with blog sections)
- [x] T032 [P] [US3] Update spec-template.md to include: Blog Type Declaration, Target Audience, Content Pillars, Publishing Cadence, Success Criteria, Distribution Requirements
- [x] T033 [P] [US3] Remove software-specific sections from spec-template.md: Technical Architecture, API Specs, Database Schemas, Code Structure
- [x] T034 [P] [US3] Add validation prompts to spec-template.md: "NO technology choices in spec phase" (enforces Content-First principle)
- [x] T035 [US3] Create `/blogkit.specify` slash command in `.blogkit/templates/commands/blogkit.specify.md`
- [x] T036 [US3] Update blogkit.specify.md to reference `refs/2_define_for_specify.md` for guidance on blog writing best practices
- [x] T037 [US3] Update blogkit.specify.md to enforce Content-First principle (reject CMS, framework, hosting mentions)
- [x] T038 [US3] Update blogkit.specify.md to create new feature branch (e.g., `001-authority-blog-ml-engineers`)
- [x] T039 [US3] Update blogkit.specify.md to generate `specs/NNN-feature-name/spec.md` using adapted blog template
- [x] T040 [US3] Test `/blogkit.specify` in Claude Code: verify spec.md is created with blog-specific sections
- [ ] T041 [US3] Validate Content-First gate: spec.md should contain ZERO technology implementation details

**Checkpoint**: `/blogkit.specify` command functional - users can create blog content strategy specifications following blog-tech-kit principles

---

## Phase 6: User Story 4 - Create Editorial Workflow & Technical Plan with `/blogkit.plan` (Priority: P2)

**Goal**: Users can define HOW they will execute content strategy (editorial workflow, tech stack, tools, distribution)

**Independent Test**: Run `/blogkit.plan` after creating spec. Verify plan.md includes 4-pass editorial process, tech stack, SEO/AI optimization, distribution strategy.

### Implementation for User Story 4

- [x] T042 [P] [US4] Adapt `plan-template.md` in `.blogkit/templates/` for editorial workflow and blog operations (replace code architecture with content workflow)
- [x] T043 [P] [US4] Update plan-template.md to include: Editorial Process (4-pass), Tech Stack, Tools & Integrations, AI Discoverability, Distribution Strategy, Analytics & Instrumentation
- [x] T044 [P] [US4] Remove software-specific sections from plan-template.md: Code Architecture, Backend Services, Deployment Pipelines, API Design
- [x] T045 [P] [US4] Add Constitution Check section to plan-template.md validating blog-specific principles (Content-First, AI-Native Distribution, Simplicity & Focus)
- [x] T046 [US4] Create `/blogkit.plan` slash command in `.blogkit/templates/commands/blogkit.plan.md`
- [x] T047 [US4] Update blogkit.plan.md to reference `refs/3_project_mangement_for_plan.md` for guidance on blog operations
- [x] T048 [US4] Update blogkit.plan.md to run `.blogkit/scripts/bash/setup-plan.sh` to create plan.md in feature directory
- [x] T049 [US4] Update blogkit.plan.md to enforce Simplicity & Focus principle (no custom CMS before 10 posts, no over-engineering)
- [x] T050 [US4] Update blogkit.plan.md to generate `research.md` if NEEDS CLARIFICATION markers exist in Technical Context
- [x] T051 [US4] Update blogkit.plan.md to generate `quickstart.md` with getting-started guide for first post
- [x] T052 [US4] Test `/blogkit.plan` in Claude Code: verify plan.md includes editorial workflow, tech stack, AI optimization, distribution strategy
- [x] T053 [US4] Validate Simplicity & Focus gate: plan.md should pass "Complexity Review" (no over-engineering detected)

**Checkpoint**: `/blogkit.plan` command functional - users can create technical implementation plans that respect blog-tech-kit principles

---

## Phase 7: User Story 5 - Generate Content Production Tasks with `/blogkit.tasks` (Priority: P2)

**Goal**: Users can break down blog plan into specific, ordered tasks (platform setup, content creation, distribution)

**Independent Test**: Run `/blogkit.tasks` after creating plan. Verify tasks.md is organized by sprint (Sprint 0: Platform, Sprint 1: Post 1, Sprint 2: Post 2, etc.).

### Implementation for User Story 5

- [x] T054 [P] [US5] Adapt `tasks-template.md` in `.blogkit/templates/` for content production workflow (replace software tasks with content tasks)
- [x] T055 [P] [US5] Update tasks-template.md to organize tasks by: Sprint Organization (by content pillar/post), Platform Setup, Content Creation, Distribution, Validation Checkpoints
- [x] T056 [P] [US5] Remove software-specific sections from tasks-template.md: API Integration Tasks, Database Migration Tasks, Backend Service Tasks
- [x] T057 [P] [US5] Add content-specific task groups to tasks-template.md: Research & Outline, Draft, Code Examples (if applicable), Technical Review, Copyedit, SEO Optimization, Publish, Distribution
- [x] T058 [US5] Create `/blogkit.tasks` slash command in `.blogkit/templates/commands/blogkit.tasks.md`
- [x] T059 [US5] Update blogkit.tasks.md to reference `refs/4_pm_tasking_for_tasks.md` and `refs/5_more/tasking_methodology.md` for guidance on task structure
- [x] T060 [US5] Update blogkit.tasks.md to organize tasks by content sprint (Sprint 0: Platform Setup, Sprint 1: Foundation Post 1, Sprint 2: Foundation Post 2, etc.)
- [x] T061 [US5] Update blogkit.tasks.md to include dependencies (e.g., "Post 1 published" before "Post 2 research begins")
- [x] T062 [US5] Update blogkit.tasks.md to include validation checkpoints (sprint-end quality gates: analytics review, SEO ranking check, engagement review)
- [x] T063 [US5] Test `/blogkit.tasks` in Claude Code: verify tasks.md is organized by sprint with clear dependencies
- [x] T064 [US5] Validate task structure: Each post should include all 6 editorial phases (research, draft, review, copyedit, publish, measure)

**Checkpoint**: `/blogkit.tasks` command functional - users can generate actionable task lists for content production

---

## Phase 8: User Story 6 - Execute Content Strategy with `/blogkit.implement` (Priority: P3)

**Goal**: Users can systematically execute content plan (execute tasks in dependency order, validate checkpoints, track progress)

**Independent Test**: Run `/blogkit.implement` after creating tasks. Verify agent executes tasks in correct order, checks quality gates, provides progress updates.

### Implementation for User Story 6

- [x] T065 [US6] Create `/blogkit.implement` slash command in `.blogkit/templates/commands/blogkit.implement.md`
- [x] T066 [US6] Update blogkit.implement.md to read `tasks.md` from feature directory
- [x] T067 [US6] Update blogkit.implement.md to parse task dependencies and execution order
- [x] T068 [US6] Update blogkit.implement.md to execute tasks sequentially respecting dependencies
- [x] T069 [US6] Update blogkit.implement.md to check quality gates before advancing to next task (e.g., "SEO metadata present", "code examples tested", "analytics configured")
- [x] T070 [US6] Update blogkit.implement.md to provide progress updates (e.g., "Sprint 1: 3/5 tasks complete")
- [x] T071 [US6] Update blogkit.implement.md to handle blockers (if quality gate fails, pause and notify user)
- [x] T072 [US6] Test `/blogkit.implement` in Claude Code: verify tasks execute in correct order
- [x] T073 [US6] Validate quality gates: Agent should check SEO metadata, code examples, analytics before marking tasks complete

**Checkpoint**: `/blogkit.implement` command functional - users can systematically execute content production with quality control

---

## Phase 9: Additional Slash Commands - Quality & Analysis (Priority: P3)

**Goal**: Provide additional workflow commands for content quality validation and cross-artifact analysis

**Independent Test**: Run `/blogkit.clarify`, `/blogkit.checklist`, `/blogkit.analyze`, `/blogkit.taskstoissues`, `/blogkit.constitution`. Verify each produces expected output.

### Implementation for Additional Commands

- [x] T074 [P] Create `/blogkit.clarify` slash command in `.blogkit/templates/commands/blogkit.clarify.md` (structured Q&A to resolve underspecified requirements)
- [x] T075 [P] Update blogkit.clarify.md to ask maximum 3 clarification questions prioritized by impact (scope > quality > distribution)
- [x] T076 [P] Update blogkit.clarify.md to document clarifications in spec.md "Clarifications" section
- [x] T077 [P] Create `/blogkit.checklist` slash command in `.blogkit/templates/commands/blogkit.checklist.md` (generate custom quality checklists)
- [x] T078 [P] Update blogkit.checklist.md to generate checklists based on blog type (e.g., SEO optimization checklist, editorial review checklist)
- [x] T079 [P] Create `/blogkit.analyze` slash command in `.blogkit/templates/commands/blogkit.analyze.md` (cross-artifact consistency analysis)
- [x] T080 [P] Update blogkit.analyze.md to check consistency between spec.md, plan.md, tasks.md (identify gaps, inconsistencies)
- [x] T081 [P] Create `/blogkit.taskstoissues` slash command in `.blogkit/templates/commands/blogkit.taskstoissues.md` (convert tasks to GitHub issues)
- [x] T082 [P] Update blogkit.taskstoissues.md to create GitHub issues with dependencies, labels, milestones
- [x] T083 [P] Create `/blogkit.constitution` slash command in `.blogkit/templates/commands/blogkit.constitution.md` (create or update blog governance principles)
- [x] T084 [P] Update blogkit.constitution.md to update `.blogkit/memory/constitution.md` with blog-specific principles
- [x] T085 Test all additional slash commands: verify each produces expected output without errors

**Checkpoint**: All 9 slash commands functional - complete blog-tech-kit workflow available

---

## Phase 10: Reference Documentation & Examples (Priority: P2)

**Goal**: Ensure reference documentation is complete and guides users in creating high-quality blog specifications and plans

**Independent Test**: Review all files in `refs/` directory. Verify examples, best practices, and case studies are present.

### Implementation for Reference Documentation

- [x] T086 [P] Verify `refs/0_overview.md` contains overview of successful AI/LLM SaaS blogs (Anthropic, LangChain, Hugging Face)
- [x] T087 [P] Verify `refs/1_principles_for_constitution.md` contains 8 Core Blog Principles with examples and case studies
- [x] T088 [P] Verify `refs/2_define_for_specify.md` contains blog writing best practices and content strategy guidance
- [x] T089 [P] Verify `refs/3_project_mangement_for_plan.md` contains blog operations guide (editorial workflow, distribution, measurement)
- [x] T090 [P] Verify `refs/4_pm_tasking_for_tasks.md` contains tasking methodology for blog execution
- [x] T091 [P] Verify `refs/6_claude_code.md` contains Claude Code integration guide with usage examples
- [x] T092 [P] Verify `refs/5_more/blog_operations_guide.md` contains detailed operational guide
- [x] T093 [P] Verify `refs/5_more/blog_strategy_analysis.md` contains case studies with documented growth data
- [x] T094 [P] Verify `refs/5_more/overview.md` contains comprehensive writing guide (857 lines)
- [x] T095 [P] Verify `refs/5_more/tasking_methodology.md` contains complete tasking framework with PDCA loops

**Checkpoint**: Reference documentation complete - users have comprehensive guides for blog-tech-kit workflow

---

## Phase 11: Blog-Specific Template Content (Priority: P2)

**Goal**: Adapt spec-kit templates with blog-specific content, examples, and validation criteria

**Independent Test**: Review adapted templates. Verify they contain blog-specific sections and NO software development sections.

### Implementation for Template Adaptation

- [x] T096 [US3] Finalize `spec-template.md` in `.blogkit/templates/` with complete blog-specific sections
- [x] T097 [US3] Add example blog specification to spec-template.md (Authority Blog for AI/LLM Developers)
- [x] T098 [US3] Add validation checklist to spec-template.md (10 items from constitution Review & Acceptance Checklist)
- [x] T099 [US4] Finalize `plan-template.md` in `.blogkit/templates/` with complete editorial workflow sections
- [x] T100 [US4] Add example blog plan to plan-template.md (4-pass editorial process, Next.js + MDX, Plausible analytics)
- [x] T101 [US4] Add Constitution Check section to plan-template.md validating all 8 Core Blog Principles
- [x] T102 [US5] Finalize `tasks-template.md` in `.blogkit/templates/` with complete sprint organization sections
- [x] T103 [US5] Add example task breakdown to tasks-template.md (Sprint 0: Platform Setup, Sprint 1: Post 1, Sprint 2: Post 2)
- [x] T104 [US5] Add validation checkpoint examples to tasks-template.md (analytics review, SEO check, engagement review)
- [x] T105 Create `blog-post-template.md` in `.blogkit/templates/` with blog post structure (NEW template not in spec-kit)
- [x] T106 Add blog post template sections: Title & Hook, TLDR, Background, Main Content (H2/H3), Code Examples, Results, Lessons Learned, Conclusion & CTA, FAQ
- [x] T107 Add AI discoverability guidance to blog-post-template.md (JSON-LD schema, heading hierarchy, internal links)

**Checkpoint**: All templates adapted with blog-specific content - users have complete template library

---

## Phase 12: Multi-Kit Coexistence Validation (Priority: P0)

**Goal**: Validate that blog-tech-kit and spec-kit can coexist on same machine without conflicts

**Independent Test**: Install both spec-kit and blog-tech-kit. Run all validation tests from Multi-Kit Installation Test Matrix.

### Implementation for Multi-Kit Validation

- [ ] T108 Test CLI Installation: Install both `specify-cli` and `blog-cli` using `uv tool install`
- [ ] T109 Verify both commands available: `specify --help` and `blog --help` both work
- [ ] T110 Test project initialization: Create 3 projects (`specify init test-1`, `blog init test-2`, `pm init test-3` when pm-kit available)
- [ ] T111 Verify dedicated directory structure: blog-tech-kit uses `.blogkit/` (separate from spec-kit's `.specify/`)
- [ ] T112 Verify constitution coexistence: `.blogkit/memory/constitution.md` contains correct constitution based on active kit (identified by header comment)
- [ ] T113 Test slash command isolation: In Claude Code, verify `/speckit.plan` and `/blogkit.plan` both available in autocomplete
- [ ] T114 Test workflow trigger: Verify `/speckit.plan` triggers software plan, `/blogkit.plan` triggers blog plan (distinct workflows)
- [ ] T115 Verify agent context files: `.claude/commands/` contains both `speckit.*` and `blogkit.*` files without collision
- [ ] T116 Test kit switching: Run `blog init --here --force` in existing spec-kit project, verify constitution and slash commands update cleanly
- [ ] T117 Document multi-kit coexistence test results in `specs/000-blog-tech-kit-foundation/validation-report.md`

**Checkpoint**: Multi-kit coexistence validated - spec-kit and blog-tech-kit work together without conflicts

---

## Phase 13: Polish & Cross-Cutting Concerns

**Purpose**: Final improvements, documentation, and validation

- [ ] T118 [P] Update README.md with blog-tech-kit overview, installation instructions, and workflow guide
- [ ] T119 [P] Create comprehensive CHANGELOG.md documenting changes from spec-kit to blog-tech-kit
- [ ] T120 [P] Update pyproject.toml metadata (description, keywords, author, repository URL)
- [ ] T121 [P] Add LICENSE file (MIT license from spec-kit)
- [ ] T122 [P] Create CONTRIBUTING.md with guidelines for future kit variant creators
- [ ] T123 [P] Document namespace strategy in README.md (CLI separation, slash command namespacing, dedicated `.blogkit/` directory)
- [ ] T124 [P] Add troubleshooting section to README.md (common issues, solutions)
- [ ] T125 [P] Create quickstart guide in README.md (5-step process: install → constitution → specify → plan → tasks → implement)
- [ ] T126 Validate all slash commands work in Claude Code (test each `/blogkit.*` command)
- [ ] T127 Validate all templates generate correct output (test spec, plan, tasks generation)
- [ ] T128 Validate constitution principles are enforced (test Content-First gate, Simplicity & Focus gate)
- [ ] T129 Run final integration test: Complete end-to-end workflow (blog init → constitution → specify → plan → tasks → implement)
- [ ] T130 Generate validation report documenting all tests passed

**Checkpoint**: Blog-tech-kit ready for release - all features functional, documentation complete, multi-kit coexistence validated

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately (verification of existing structure)
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-9)**: All depend on Foundational phase completion
  - US1 (CLI Package): Can start after Foundational - No dependencies on other stories
  - US2 (Project Init): Depends on US1 completion (requires functional CLI)
  - US3 (Specify): Depends on US2 completion (requires project initialization)
  - US4 (Plan): Depends on US3 completion (requires specification)
  - US5 (Tasks): Depends on US4 completion (requires plan)
  - US6 (Implement): Depends on US5 completion (requires tasks)
  - US7-9 (Additional Commands): Can run in parallel after US2 completion
- **Reference Docs (Phase 10)**: Can run in parallel with US3-9 (independent work)
- **Template Adaptation (Phase 11)**: Depends on US3, US4, US5 (integrates with specify, plan, tasks commands)
- **Multi-Kit Validation (Phase 12)**: Depends on US1, US2, US3, US4 (requires core workflow functional)
- **Polish (Phase 13)**: Depends on all user stories and validation complete

### User Story Dependencies

```
US1 (CLI Package)
    ↓
US2 (Project Init)
    ↓
US3 (Specify) ←→ US7-9 (Additional Commands - parallel)
    ↓
US4 (Plan)
    ↓
US5 (Tasks)
    ↓
US6 (Implement)

Reference Docs (US10) - parallel with US3-9
Template Adaptation (US11) - after US3, US4, US5
Multi-Kit Validation (US12) - after US1, US2, US3, US4
```

### Within Each User Story

- CLI commands before project initialization
- Project initialization before content workflow commands
- Specify before plan before tasks before implement
- Templates before slash commands that use them
- Validation after implementation

### Parallel Opportunities

- **Phase 1 (Setup)**: All verification tasks marked [P] can run in parallel
- **Phase 2 (Foundational)**: Constitution verification and template placeholder creation can run in parallel
- **Phase 3-9**: Within each user story, tasks marked [P] can run in parallel (e.g., T012-T014 in US1)
- **Phase 10 (Reference Docs)**: All reference doc verification tasks can run in parallel
- **Phase 11 (Templates)**: Template finalization tasks can run in parallel (T096-T107)
- **Phase 13 (Polish)**: Documentation tasks (T118-T125) can run in parallel

---

## Parallel Example: User Story 1 (CLI Package)

```bash
# Launch CLI package verification tasks together:
Task: "Verify CLI package name `blog-cli` in pyproject.toml"
Task: "Verify CLI command `blog` mapped to `blog_cli:main` in pyproject.toml"
Task: "Verify package dependencies include typer, rich, httpx, ..."
```

---

## Implementation Strategy

### MVP First (User Stories 1-2 Only)

1. Complete Phase 1: Setup (verification)
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1 (CLI Package functional)
4. Complete Phase 4: User Story 2 (Project initialization functional)
5. **STOP and VALIDATE**: Test `blog init` creates complete project
6. Deploy/demo if ready

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test CLI independently → `blog --help` works (MVP!)
3. Add User Story 2 → Test project init → `blog init` works
4. Add User Story 3 → Test specify → `/blogkit.specify` works
5. Add User Story 4 → Test plan → `/blogkit.plan` works
6. Add User Story 5 → Test tasks → `/blogkit.tasks` works
7. Add User Story 6 → Test implement → `/blogkit.implement` works
8. Add User Stories 7-9 → Additional commands functional
9. Complete Reference Docs + Template Adaptation → Complete workflow
10. Complete Multi-Kit Validation → Coexistence confirmed
11. Each phase adds capability without breaking previous phases

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Stories 1-2 (CLI + Project Init)
   - Developer B: User Stories 3-4 (Specify + Plan)
   - Developer C: User Stories 5-6 (Tasks + Implement)
   - Developer D: Reference Docs + Template Adaptation
3. Stories complete and integrate independently
4. Final validation together (Multi-Kit Validation + Polish)

---

## Task Summary

**Total Tasks**: 130 tasks across 13 phases
**MVP Scope** (US1-2): 20 tasks (T001-T020)
**Core Workflow** (US1-6): 73 tasks (T001-T073)
**Complete Implementation**: 130 tasks (T001-T130)

**Task Breakdown by Phase**:
- Phase 1 (Setup): 6 tasks
- Phase 2 (Foundational): 5 tasks
- Phase 3 (US1 - CLI Package): 9 tasks
- Phase 4 (US2 - Project Init): 10 tasks
- Phase 5 (US3 - Specify): 11 tasks
- Phase 6 (US4 - Plan): 12 tasks
- Phase 7 (US5 - Tasks): 11 tasks
- Phase 8 (US6 - Implement): 9 tasks
- Phase 9 (Additional Commands): 12 tasks
- Phase 10 (Reference Docs): 10 tasks
- Phase 11 (Template Adaptation): 12 tasks
- Phase 12 (Multi-Kit Validation): 10 tasks
- Phase 13 (Polish): 13 tasks

**Parallel Opportunities**: 45 tasks marked [P] can run in parallel within their phase

**Independent Test Criteria**:
- US1: Both `specify` and `blog` commands work independently
- US2: `blog init` creates complete blog project structure
- US3: `/blogkit.specify` generates blog spec without technology details
- US4: `/blogkit.plan` generates editorial workflow with tech stack
- US5: `/blogkit.tasks` generates sprint-organized task list
- US6: `/blogkit.implement` executes tasks with quality gates

**Suggested MVP**: Complete Phases 1-4 (User Stories 1-2) for functional CLI and project initialization (20 tasks, ~2-3 days)

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Multi-kit coexistence is P0 priority - test early and often
- Blog-tech-kit reuses spec-kit infrastructure - most work is adaptation, not creation
- Namespace strategy (CLI separation, slash command namespacing, shared `.specify/`) is critical for coexistence
