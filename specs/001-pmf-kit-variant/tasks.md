# Task Breakdown: blog-Kit Variant Implementation

**Branch**: `001-blog-kit-variant` | **Date**: 2025-12-03 | **Plan**: [plan.md](./plan.md)

**Overview**: Transform spec-kit templates and commands to create blog-kit variant through systematic namespace isolation (`speckit` → `blogkit`) and content adaptation (software development → blog discovery), while preserving 100% of spec-kit infrastructure.

**Implementation Strategy**:
- Phase 1: Setup & Infrastructure Verification
- Phase 2: Foundational Namespace Isolation (Category A: Simple Find-and-Replace)
- Phase 3: Command Files Transformation (Category B2: Moderate Content Adaptation)
- Phase 4: Template Content Transformation (Category B1: Heavy Content Adaptation)
- Phase 5: Reference Documentation Creation (Category C: New Files)
- Phase 6: Validation & Testing
- Phase 7: Documentation & Polish

**Success Criteria**: All 14 success criteria from spec.md validated; zero instances of "speckit" in implementation files; multi-kit installation works without conflicts; generated blog specs contain zero technical terms and all required blog sections.

---

## Phase 1: Setup & Infrastructure Verification

**Goal**: Verify project structure, prepare environment, document transformation plan

**Exit Criteria**:
- All files requiring transformation identified and categorized
- Transformation rules verified and documented
- Git branch clean and ready for edits
- Backup created

### Setup Tasks

- [ ] T001 Verify git branch is `001-blog-kit-variant` and working directory is clean
  - File: (shell check)
  - Command: `git status` and `git branch`
  - Deliverable: Clean working tree confirmation

- [ ] T002 Create backup of entire blog-kit repository before transformations begin
  - File: (backup directory outside repo)
  - Command: `tar czf blog-kit-backup-$(date +%s).tar.gz /Users/frank/kits/blog-kit`
  - Deliverable: Backup file created

- [ ] T003 Generate complete inventory of files requiring transformation (Category A, B, C)
  - File: `specs/001-blog-kit-variant/research.md`
  - Command: `grep -r "speckit" /Users/frank/kits/blog-kit --exclude-dir=.git --exclude-dir=specs > /tmp/speckit-instances.txt`
  - Deliverable: research.md with complete file categorization

- [ ] T004 Verify spec-kit CLI installation patterns and entry points
  - File: (verify from spec-kit documentation)
  - Command: `uv tool list | grep specify-cli` and `which specify`
  - Deliverable: Understanding of how CLI namespacing works

- [ ] T005 Create transformation rule reference document from plan.md
  - File: `specs/001-blog-kit-variant/contracts/template-content.md`
  - Command: (manual documentation)
  - Deliverable: Complete mapping of software concepts → blog concepts

---

## Phase 2: Foundational Namespace Isolation (Category A - Simple Find-and-Replace)

**Goal**: Replace all `speckit` references with `blogkit` in command files, templates, and scripts

**Exit Criteria**:
- All Category A files transformed
- Zero "speckit" instances remain in implementation (except docs)
- All changes validated with namespace validation script

### Agent Command Files (.claude/commands/)

- [x] T101 [P] Transform `.claude/commands/constitution.md` - replace speckit with blogkit
  - File: `.claude/commands/constitution.md`
  - Changes: Replace `speckit.specify` with `blogkit.specify` in handoff
  - Validation: `grep speckit .claude/commands/constitution.md` returns zero

- [x] T102 [P] Transform `.claude/commands/specify.md` - replace speckit with blogkit
  - File: `.claude/commands/specify.md`
  - Changes: Replace all `speckit.` references with `blogkit.` in handoffs and content
  - Validation: `grep speckit .claude/commands/specify.md` returns zero

- [x] T103 [P] Transform `.claude/commands/clarify.md` - replace speckit with blogkit
  - File: `.claude/commands/clarify.md`
  - Changes: Replace `/speckit.` with `/blogkit.` in handoffs, notes, and examples
  - Validation: `grep speckit .claude/commands/clarify.md` returns zero

- [x] T104 [P] Transform `.claude/commands/plan.md` - replace speckit with blogkit
  - File: `.claude/commands/plan.md`
  - Changes: Replace `speckit.tasks`, `speckit.checklist`, and other references with `blogkit.*`
  - Validation: `grep speckit .claude/commands/plan.md` returns zero

- [x] T105 [P] Transform `.claude/commands/tasks.md` - replace speckit with blogkit
  - File: `.claude/commands/tasks.md`
  - Changes: Replace `speckit.analyze`, `speckit.implement` with `blogkit.*`
  - Validation: `grep speckit .claude/commands/tasks.md` returns zero

- [x] T106 [P] Transform `.claude/commands/implement.md` - replace speckit with blogkit
  - File: `.claude/commands/implement.md`
  - Changes: Replace `/speckit.tasks`, `/speckit.implement` references with `/blogkit.*`
  - Validation: `grep speckit .claude/commands/implement.md` returns zero

- [x] T107 [P] Transform `.claude/commands/analyze.md` - replace speckit with blogkit
  - File: `.claude/commands/analyze.md`
  - Changes: Replace `/speckit.analyze`, `/speckit.tasks`, `/speckit.implement` with `/blogkit.*`
  - Validation: `grep speckit .claude/commands/analyze.md` returns zero

- [x] T108 [P] Transform `.claude/commands/checklist.md` - replace speckit with blogkit
  - File: `.claude/commands/checklist.md`
  - Changes: Replace `/speckit.checklist` and embedded references with `/blogkit.checklist`
  - Validation: `grep speckit .claude/commands/checklist.md` returns zero

- [x] T109 [P] Transform `.claude/commands/taskstoissues.md` - replace speckit with blogkit
  - File: `.claude/commands/taskstoissues.md`
  - Changes: Replace `/speckit.taskstoissues` with `/blogkit.taskstoissues`
  - Validation: `grep speckit .claude/commands/taskstoissues.md` returns zero

### Template Command Files (templates/commands/)

- [x] T110 [P] Transform `templates/commands/constitution.md` - replace speckit with blogkit
  - File: `templates/commands/constitution.md`
  - Changes: Same as T101 (parallel transformation)
  - Validation: `grep speckit templates/commands/constitution.md` returns zero

- [x] T111 [P] Transform `templates/commands/specify.md` - replace speckit with blogkit
  - File: `templates/commands/specify.md`
  - Changes: Same as T102 (parallel transformation)
  - Validation: `grep speckit templates/commands/specify.md` returns zero

- [x] T112 [P] Transform `templates/commands/clarify.md` - replace speckit with blogkit
  - File: `templates/commands/clarify.md`
  - Changes: Same as T103 (parallel transformation)
  - Validation: `grep speckit templates/commands/clarify.md` returns zero

- [x] T113 [P] Transform `templates/commands/plan.md` - replace speckit with blogkit
  - File: `templates/commands/plan.md`
  - Changes: Same as T104 (parallel transformation)
  - Validation: `grep speckit templates/commands/plan.md` returns zero

- [x] T114 [P] Transform `templates/commands/tasks.md` - replace speckit with blogkit
  - File: `templates/commands/tasks.md`
  - Changes: Same as T105 (parallel transformation)
  - Validation: `grep speckit templates/commands/tasks.md` returns zero

- [x] T115 [P] Transform `templates/commands/implement.md` - replace speckit with blogkit
  - File: `templates/commands/implement.md`
  - Changes: Same as T106 (parallel transformation)
  - Validation: `grep speckit templates/commands/implement.md` returns zero

- [x] T116 [P] Transform `templates/commands/analyze.md` - replace speckit with blogkit
  - File: `templates/commands/analyze.md`
  - Changes: Same as T107 (parallel transformation)
  - Validation: `grep speckit templates/commands/analyze.md` returns zero

- [x] T117 [P] Transform `templates/commands/checklist.md` - replace speckit with blogkit
  - File: `templates/commands/checklist.md`
  - Changes: Same as T108 (parallel transformation)
  - Validation: `grep speckit templates/commands/checklist.md` returns zero

- [x] T118 [P] Transform `templates/commands/taskstoissues.md` - replace speckit with blogkit
  - File: `templates/commands/taskstoissues.md`
  - Changes: Same as T109 (parallel transformation)
  - Validation: `grep speckit templates/commands/taskstoissues.md` returns zero

### Supporting Template Files

- [x] T119 [P] Transform `templates/agent-file-template.md` - replace speckit references
  - File: `templates/agent-file-template.md`
  - Changes: Replace `speckit` with `blogkit` in command prefix examples
  - Validation: `grep speckit templates/agent-file-template.md` returns zero

- [x] T120 [P] Update `templates/vscode-settings.json` - check for speckit references
  - File: `templates/vscode-settings.json`
  - Changes: Replace any hardcoded speckit references with blogkit
  - Validation: `grep speckit templates/vscode-settings.json` returns zero

### Script Files

- [x] T121 Transform `scripts/bash/common.sh` - replace speckit references in shared functions
  - File: `scripts/bash/common.sh`
  - Changes: Replace speckit in variable names, comments, and function references
  - Validation: `grep speckit scripts/bash/common.sh` returns zero
  - Dependency: Completes before script-dependent tasks

- [x] T122 Transform `scripts/bash/create-new-feature.sh` - replace speckit in help text
  - File: `scripts/bash/create-new-feature.sh`
  - Changes: Replace speckit with blogkit in help text, examples, template paths
  - Validation: `grep speckit scripts/bash/create-new-feature.sh` returns zero
  - Dependency: T121

- [x] T123 Transform `scripts/bash/setup-plan.sh` - replace speckit in template references
  - File: `scripts/bash/setup-plan.sh`
  - Changes: Replace speckit in template paths and references
  - Validation: `grep speckit scripts/bash/setup-plan.sh` returns zero
  - Dependency: T121

- [x] T124 [P] Transform `scripts/bash/update-*-md.sh` - replace speckit in agent scripts
  - File: `scripts/bash/update-*.sh` (all agent-specific scripts)
  - Changes: Replace speckit references in all update scripts
  - Validation: `grep speckit scripts/bash/update-*.sh` returns zero

### Phase 2 Validation

- [x] T125 Run namespace validation script after Phase 2 completion
  - File: `scripts/validate-namespace.sh`
  - Command: Execute validation script to confirm zero speckit instances
  - Deliverable: Validation report showing pass
  - Dependency: T101-T124 complete

- [x] T126 Commit Phase 2 changes to git
  - File: (git commit)
  - Command: `git add -A && git commit -m "Phase 2: Namespace isolation - Category A simple transformations"`
  - Deliverable: Clean git history checkpoint

---

## Phase 3: Command Files Transformation (Category B2 - Moderate Content Adaptation)

**Goal**: Adapt command file content from software development to blog discovery focus

**Exit Criteria**:
- All command files have blog-appropriate descriptions and workflows
- Workflow descriptions reference blog methodology (not code development)
- All handoffs use blogkit prefix
- Commands remain functionally identical to spec-kit equivalents

### Constitution Command

- [x] T201 Adapt `.claude/commands/constitution.md` - update for blog principles
  - File: `.claude/commands/constitution.md`
  - Changes:
    - Update description to focus on blog-specific principles
    - Reference constitution.md principles (Specification-First, Customer-Evidence-Driven, etc.)
    - Ensure handoff to `/blogkit.specify` is correct
  - Content: Already has blog principles in v1.0.0, minor refinements needed
  - Validation: Description mentions blog principles, no technical terms

- [x] T202 Adapt `templates/commands/constitution.md` - same as T201
  - File: `templates/commands/constitution.md`
  - Changes: Parallel transformation of template version
  - Dependency: T201

### Specify Command

- [x] T203 Adapt `.claude/commands/specify.md` - update workflow for blog specs
  - File: `.claude/commands/specify.md`
  - Changes:
    - Update prompt to guide creation of blog specifications (personas, JTBD, hero workflows)
    - Remove references to software features, user stories for code
    - Add guidance on sharp personas, customer evidence, blog patterns
    - Update handoff to `/blogkit.clarify` or `/blogkit.plan`
  - Content: Full workflow adaptation required (moderate complexity)
  - Validation: Generated spec examples show blog sections, no code architecture

- [x] T204 Adapt `templates/commands/specify.md` - same as T203
  - File: `templates/commands/specify.md`
  - Changes: Parallel transformation of template version
  - Dependency: T203

### Clarify Command

- [x] T205 Adapt `.claude/commands/clarify.md` - update for blog hypothesis clarification
  - File: `.claude/commands/clarify.md`
  - Changes:
    - Update to clarify blog hypotheses (not software requirements)
    - Focus on: persona fit, JTBD clarity, workflow depth, success metrics
    - Update examples to reference blog concerns
    - Update handoff to `/blogkit.plan`
  - Content: Moderate workflow adaptation
  - Validation: Clarification questions focus on blog unknowns

- [x] T206 Adapt `templates/commands/clarify.md` - same as T205
  - File: `templates/commands/clarify.md`
  - Changes: Parallel transformation of template version
  - Dependency: T205

### Plan Command

- [x] T207 Adapt `.claude/commands/plan.md` - update for blog research planning
  - File: `.claude/commands/plan.md`
  - Changes:
    - Update workflow to guide blog execution planning (not technical architecture)
    - Focus on: research methods, evidence collection, validation checkpoints
    - Remove technical stack guidance
    - Update handoff to `/blogkit.tasks` or `/blogkit.checklist`
  - Content: Heavy workflow adaptation (convert from technical to research focus)
  - Validation: Generated plan examples show research methods, no code stacks

- [x] T208 Adapt `templates/commands/plan.md` - same as T207
  - File: `templates/commands/plan.md`
  - Changes: Parallel transformation of template version
  - Dependency: T207

### Tasks Command

- [x] T209 Adapt `.claude/commands/tasks.md` - update for blog task generation
  - File: `.claude/commands/tasks.md`
  - Changes:
    - Update workflow to generate blog discovery tasks (not development tasks)
    - Focus on: research execution, participant recruitment, evidence analysis
    - Remove development phase structure (no "Phase 2: Foundational", "Phase 3: User Story")
    - Update to blog phases (Discovery, Beta, Launch, Scale)
    - Update handoff to `/blogkit.analyze` or `/blogkit.implement`
  - Content: Heavy workflow adaptation
  - Validation: Generated tasks reference research activities, not code development

- [x] T210 Adapt `templates/commands/tasks.md` - same as T209
  - File: `templates/commands/tasks.md`
  - Changes: Parallel transformation of template version
  - Dependency: T209

### Implement Command

- [x] T211 Adapt `.claude/commands/implement.md` - update for blog research execution
  - File: `.claude/commands/implement.md`
  - Changes:
    - Update workflow description to focus on research execution (not code implementation)
    - Emphasize: evidence collection, customer validation, hypothesis testing
    - Update validation checkpoints for blog (not unit tests, not CI/CD)
    - Update handoff references to blogkit commands
  - Content: Moderate workflow adaptation
  - Validation: Execution pattern focuses on research evidence, not code commits

- [x] T212 Adapt `templates/commands/implement.md` - same as T211
  - File: `templates/commands/implement.md`
  - Changes: Parallel transformation of template version
  - Dependency: T211

### Analyze Command

- [x] T213 Adapt `.claude/commands/analyze.md` - update for blog artifact analysis
  - File: `.claude/commands/analyze.md`
  - Changes:
    - Update analysis focus to blog consistency (not technical consistency)
    - Check: spec has sharp personas and evidence-based JTBD
    - Check: plan has research methods aligned with hypotheses
    - Check: tasks include validation checkpoints
    - Update handoff references to blogkit commands
  - Content: Moderate workflow adaptation
  - Validation: Analysis checks blog-specific quality gates

- [x] T214 Adapt `templates/commands/analyze.md` - same as T213
  - File: `templates/commands/analyze.md`
  - Changes: Parallel transformation of template version
  - Dependency: T213

### Checklist Command

- [x] T215 Adapt `.claude/commands/checklist.md` - update for blog quality checklists
  - File: `.claude/commands/checklist.md`
  - Changes:
    - Update to generate blog-specific quality checklists
    - Focus on: persona sharpness, evidence quality, workflow clarity, metric definition
    - Remove code quality criteria
    - Add AI product pattern validation
  - Content: Moderate workflow adaptation
  - Validation: Generated checklists reference blog concepts

- [x] T216 Adapt `templates/commands/checklist.md` - same as T215
  - File: `templates/commands/checklist.md`
  - Changes: Parallel transformation of template version
  - Dependency: T215

### TasksToIssues Command

- [x] T217 Adapt `.claude/commands/taskstoissues.md` - update for blog task conversion
  - File: `.claude/commands/taskstoissues.md`
  - Changes:
    - Update to convert blog research tasks to GitHub issues
    - Focus on: research phase issues, evidence collection issues, validation issues
    - Update handoff references to blogkit commands
  - Content: Light workflow adaptation (mostly namespace changes)
  - Validation: Conversion creates research-focused issues

- [x] T218 Adapt `templates/commands/taskstoissues.md` - same as T217
  - File: `templates/commands/taskstoissues.md`
  - Changes: Parallel transformation of template version
  - Dependency: T217

### Phase 3 Validation

- [x] T219 Validate all command files for blog workflow correctness
  - File: (manual review)
  - Check: Each command description focuses on blog (not code)
  - Check: All handoffs use `/blogkit.*` prefix
  - Check: Examples reference blog patterns (personas, workflows, evidence)
  - Deliverable: Review checklist completed

- [x] T220 Commit Phase 3 changes to git
  - File: (git commit)
  - Command: `git add -A && git commit -m "Phase 3: Command transformation - Category B2 moderate content adaptation"`
  - Deliverable: Clean git history checkpoint
  - Dependency: T219

---

## Phase 4: Template Content Transformation (Category B1 - Heavy Content Adaptation)

**Goal**: Adapt core templates from software development focus to blog discovery focus

**Exit Criteria**:
- All templates guide blog methodology (not software development)
- Templates include AI product pattern examples
- Templates produce blog specifications with required sections
- Zero technical terms in generated blog artifacts

### Specification Template

- [x] T301 Adapt `templates/spec-template.md` - transform for blog discovery specs
  - File: `templates/spec-template.md`
  - Changes:
    - Replace software "User Scenarios & Testing" with blog "Personas & Segments"
    - Replace software "Functional Requirements" with blog research questions
    - Add sections: Problems & JTBD (top 3), Hero Workflows (1-2), Success Metrics & blog Signals, Constraints & Risks, Distribution Hypotheses, Open Questions
    - Replace examples from software domain with AI SaaS examples (Cursor, Runway, Harvey, etc.)
    - Add guidance on sharp personas (role, company, tools, environment)
    - Add guidance on hero workflows (intent → AI work → artifact, with guardrails)
    - Add guidance on blog metrics (activation, engagement, AI-specific, business)
  - Content: Heavy transformation - essentially rewrite all sections
  - Validation: Generated spec contains 7+ blog sections, zero technical terms
  - Complexity: High - requires careful mapping of all sections

### Plan Template

- [x] T302 Adapt `templates/plan-template.md` - transform for blog research planning
  - File: `templates/plan-template.md`
  - Changes:
    - Replace "Technical Context" with "Research Context" (methods, evidence collection, analysis)
    - Remove all software stack guidance
    - Replace Phase 0 "Research & Design" with "blog Discovery Design" (hero workflow validation experiments, interview protocols)
    - Replace Phase 1+ with blog phases (Discovery, Beta, Launch, Scale)
    - Add guidance on research methods (interviews, surveys, behavioral experiments)
    - Add guidance on evidence collection instruments
    - Add guidance on validation checkpoints and pivot/persevere criteria
    - Replace technical examples with blog examples (research from successful AI products)
  - Content: Heavy transformation - essentially rewrite all content structure
  - Validation: Generated plan shows research methods, no code architecture
  - Complexity: High - requires complete restructuring

### Tasks Template

- [x] T303 Adapt `templates/tasks-template.md` - transform for blog research execution
  - File: `templates/tasks-template.md`
  - Changes:
    - Replace Phase 1/2 "Setup" and "Foundational" with research prep tasks
    - Replace Phase 3+ "User Story" phases with "Learning Objective" phases
    - Change task structure from code tasks to research tasks:
      - Remove: "T012 Create [Entity] model", "T015 Implement [Service]"
      - Add: "T012 Recruit 10-20 participants from target segment", "T015 Conduct hero workflow validation interviews"
    - Remove unit test phase
    - Add validation checkpoint phase per learning objective
    - Replace examples with blog research task examples (from refs/4_pm_tasking_for_tasks.md)
    - Add guidance on PDCA cycles (Plan-Do-Check-Act) for research
  - Content: Heavy transformation - completely different task structure
  - Validation: Generated tasks reference research activities, not code commits
  - Complexity: High - requires understanding of blog research methodology

### Checklist Template

- [x] T304 Adapt `templates/checklist-template.md` - transform for blog quality validation
  - File: `templates/checklist-template.md`
  - Changes:
    - Replace code quality criteria with blog quality criteria
    - Remove: "Unit test coverage", "Code review", "Performance optimization"
    - Add: "Persona sharpness", "Evidence quality", "Hypothesis clarity", "Success metrics defined"
    - Add checks for AI product patterns (references to successful products)
    - Add checks for research methodology (qualitative vs quantitative, sample sizes documented)
  - Content: Moderate transformation - replace criteria categories
  - Validation: Generated checklists validate blog specifics, not code quality

### CLAUDE-Template

- [x] T305 Update `templates/CLAUDE-template.md` - replace speckit with blogkit references
  - File: `templates/CLAUDE-template.md`
  - Changes:
    - Replace references to /speckit.* with /blogkit.*
    - Update to reference blog workflow (specify → clarify → plan → tasks → implement)
    - Ensure template guides blog discovery, not software development
  - Validation: Template shows blogkit commands, blog-focused guidance

### Phase 4 Validation

- [x] T306 Generate test blog specification using adapted template
  - File: (temporary test spec.md)
  - Test: Create sample blog spec using T301 template to verify output quality
  - Validation:
    - Contains all 7 required blog sections
    - Contains zero technical terms (Python, React, database, API, etc.)
    - Contains sharp personas (role, company, tools)
    - Contains hero workflows with TTFW targets and guardrails
  - Deliverable: Sample spec with validation notes

- [x] T307 Generate test blog plan using adapted template
  - File: (temporary test plan.md)
  - Test: Create sample blog plan using T302 template
  - Validation:
    - References research methods (interviews, surveys, experiments)
    - Contains zero code architecture terms
    - Includes evidence collection instruments
    - Defines validation checkpoints
  - Deliverable: Sample plan with validation notes

- [x] T308 Generate test blog tasks using adapted template
  - File: (temporary test tasks.md)
  - Test: Create sample blog tasks using T303 template
  - Validation:
    - Tasks reference research activities (recruit, interview, analyze)
    - Contains validation checkpoints with pivot/persevere criteria
    - Zero code development tasks present
    - Organized by learning objective, not user story
  - Deliverable: Sample tasks with validation notes

- [x] T309 Verify templates produce blog artifacts (not software development artifacts)
  - File: (automated content scan)
  - Test: Scan generated artifacts from T306-T308 for technical terms
  - Command: Check for terms like "Python", "database", "API", "endpoint", "REST"
  - Validation: Zero matches found in any generated artifact
  - Deliverable: Scan results report

- [x] T310 Commit Phase 4 changes to git
  - File: (git commit)
  - Command: `git add -A && git commit -m "Phase 4: Template content transformation - Category B1 heavy adaptation to blog focus"`
  - Deliverable: Clean git history checkpoint
  - Dependency: T309

---

## Phase 5: Reference Documentation Creation (Category C - New Files)

**Goal**: Create new reference documentation enabling multi-kit coexistence and variant creation

**Exit Criteria**:
- Multi-kit installation guide complete and tested
- Variant creation guide enables others to create pd-kit, marketing-kit, etc.
- All reference docs link correctly to existing material

### Variant Creation Guide

- [x] T401 Create `refs/4_variant_creation_guide.md` - comprehensive guide for kit variants
  - File: `refs/4_variant_creation_guide.md`
  - Content:
    - Step-by-step fork and adaptation process
    - How to change CLI command name (`blog` → `pd`, `specify` → `marketing`)
    - How to change agent namespace (`blogkit.*` → `pdkit.*`)
    - How to adapt templates for new domain
    - Testing and validation process for new variant
    - Examples of variant creation (pd-kit for product design, marketing-kit for marketing)
  - Source material: This tasks.md + plan.md + transformation learnings
  - Complexity: Moderate - synthesize implementation learnings into guide
  - Validation: Guide is clear enough that 80% of users can create minimal variant in 8 hours

### Multi-Kit Namespace Strategy

- [x] T402 Create `refs/5_namespace_strategy.md` - multi-kit installation guide
  - File: `refs/5_namespace_strategy.md`
  - Content:
    - How uv manages multiple tool variants (blog-cli, pd-cli, marketing-cli)
    - Command name uniqueness requirements
    - Agent namespace isolation (.claude/commands/speckit.* vs blogkit.* vs pdkit.*)
    - Troubleshooting common conflicts
    - Examples: installing spec-kit + blog-kit + pd-kit on same system
  - Source material: plan.md CLI namespace contract + testing results
  - Validation: Users can install multiple kits without conflicts

### Installation & Quickstart Guide

- [x] T403 Create `specs/001-blog-kit-variant/quickstart.md` - installation and first workflow
  - File: `specs/001-blog-kit-variant/quickstart.md`
  - Content:
    - Step-by-step installation instructions (`uv tool install blog-cli --from git+...`)
    - First blog discovery workflow walkthrough
    - Troubleshooting section for common issues
    - Multi-kit verification steps
  - Validation: Users can follow guide and complete first workflow in <10 minutes

### Design Documents

- [x] T404 Create `specs/001-blog-kit-variant/contracts/cli-namespace.md` - CLI specifications
  - File: `specs/001-blog-kit-variant/contracts/cli-namespace.md`
  - Content: CLI command mapping (specify → blog), package naming, installation commands
  - Source: plan.md CLI namespace contract section

- [x] T405 Create `specs/001-blog-kit-variant/contracts/agent-namespace.md` - agent command specs
  - File: `specs/001-blog-kit-variant/contracts/agent-namespace.md`
  - Content: Agent command mapping (speckit.* → blogkit.*), file locations, frontmatter format
  - Source: plan.md agent namespace contract section

- [x] T406 Create `specs/001-blog-kit-variant/contracts/validation-rules.md` - test specifications
  - File: `specs/001-blog-kit-variant/contracts/validation-rules.md`
  - Content: Validation scripts, multi-kit testing checklist, success criteria validation per SC-001 to SC-014
  - Source: plan.md validation contract section

### Data Model Documentation

- [x] T407 Create `specs/001-blog-kit-variant/data-model.md` - complete file mapping
  - File: `specs/001-blog-kit-variant/data-model.md`
  - Content: Exhaustive mapping of every file transformed, categorized by type (A, B1, B2, C)
  - Source: research.md file inventory + transformation track record
  - Validation: Data model matches actual transformations completed

### Phase 5 Validation

- [x] T408 Verify all reference documents are complete and cross-linked
  - File: (manual review)
  - Check: No broken links between refs/ documents
  - Check: Guides reference correct file paths and CLI commands
  - Deliverable: Cross-link verification checklist

- [x] T409 Commit Phase 5 changes to git
  - File: (git commit)
  - Command: `git add -A && git commit -m "Phase 5: Reference documentation - Category C new files for multi-kit support"`
  - Deliverable: Clean git history checkpoint
  - Dependency: T408

---

## Phase 6: Validation & Testing

**Goal**: Verify all transformations work correctly; validate success criteria; test multi-kit compatibility

**Exit Criteria**:
- All automated validation scripts pass
- Multi-kit installation verified on test system
- All 14 success criteria validated
- Zero instances of "speckit" in implementation

### Automated Validation

- [x] T501 Create and run namespace validation script
  - File: `scripts/validate-namespace.sh`
  - Command: Scan repository for unintended "speckit" instances
  - Validation: Zero matches outside of documentation and specs
  - Deliverable: Validation report

- [x] T502 Create and run blog content validation script
  - File: `scripts/validate-blog-content.sh`
  - Command: Scan generated artifacts for technical terms
  - Test: Generate sample spec/plan/tasks and verify zero technical terms
  - Validation: All generated blog artifacts contain zero code architecture terms
  - Deliverable: Validation report

- [x] T503 Create multi-kit installation test script
  - File: `scripts/test-multi-kit-install.sh`
  - Test: Simulate installation of both spec-kit and blog-kit
  - Validation: Both tools coexist without conflicts
  - Deliverable: Test results

### Manual Validation

- [x] T504 Manually verify each success criterion from spec.md
  - File: (validation checklist)
  - Test: SC-001 through SC-014 each with specific test procedure
  - Checklist:
    - SC-001: Multi-kit installation (specify check + blog check both work)
    - SC-002: Initialization time (<2 minutes)
    - SC-003: Command distinction (95% correct selection)
    - SC-004: blog spec sections (all 7 present)
    - SC-005: Sharp personas (all fields present)
    - SC-006: Hero workflows (TTFW, guardrails present)
    - SC-007: Time reduction (70% less than baseline)
    - SC-008: AI-specific metrics (all categories present)
    - SC-009: AI product references (3+ present)
    - SC-010: Variant creation (test creating pd-kit)
    - SC-011: 8-hour creation time (measure actual time)
    - SC-012: Zero collisions (multi-kit testing)
    - SC-013: 90% workflow completion
    - SC-014: Research artifacts (not code artifacts)
  - Deliverable: Validation checklist with results

### Multi-Kit Testing

- [x] T505 Install spec-kit on test system and verify functionality
  - File: (test environment setup)
  - Command: `uv tool install specify-cli --from git+https://github.com/github/spec-kit.git`
  - Validation: `specify check` works correctly
  - Deliverable: Installation verification

- [x] T506 Install blog-kit on same test system alongside spec-kit
  - File: (test environment setup)
  - Command: `uv tool install blog-cli --from git+https://github.com/agentii-ai/blog-kit.git`
  - Validation: `blog check` works, both tools listed in `uv tool list`
  - Deliverable: Multi-kit installation verification

- [x] T507 Test agent command isolation (Claude Code)
  - File: (Claude Code interactive test)
  - Test: In a blog-kit project, verify `/blogkit.*` commands are available
  - Test: Type `/` and verify both `/speckit.*` and `/blogkit.*` in autocomplete
  - Validation: Commands don't interfere
  - Deliverable: Agent compatibility test results

- [x] T508 Create sample blog spec and validate structure
  - File: `test-output/sample-spec.md`
  - Test: Run `/blogkit.specify` with sample input (e.g., "AI video generation for creators")
  - Validation:
    - Spec contains all 7 required sections
    - Personas are sharp (role, company, tools)
    - JTBD include job stories with current workarounds
    - Hero workflows include TTFW targets and guardrails
    - Success metrics include activation, engagement, AI-specific, business metrics
    - Zero technical terms (Python, React, database, API, etc.)
  - Deliverable: Sample spec with validation notes

- [x] T509 Create sample blog plan and validate structure
  - File: `test-output/sample-plan.md`
  - Test: Run `/blogkit.plan` with sample input describing research methodology
  - Validation:
    - Plan references research methods (interviews, surveys, experiments)
    - Contains zero code architecture terms
    - Includes evidence collection instruments
    - Defines validation checkpoints
    - References successful AI product patterns
  - Deliverable: Sample plan with validation notes

- [x] T510 Create sample blog tasks and validate structure
  - File: `test-output/sample-tasks.md`
  - Test: Run `/blogkit.tasks` to generate task breakdown from sample plan
  - Validation:
    - Tasks reference research activities (recruit, interview, analyze)
    - Organized by learning objective with validation checkpoints
    - Pivot/persevere decision criteria defined
    - Zero code development tasks present
  - Deliverable: Sample tasks with validation notes

### Documentation Validation

- [x] T511 Verify README.md is updated for blog-kit
  - File: `README.md`
  - Check: References blog-kit (not spec-kit)
  - Check: Installation instructions show `blog init` (not `specify init`)
  - Check: Examples show `/blogkit.*` commands (not `/speckit.*`)
  - Deliverable: README verification checklist

- [x] T512 Verify all internal links work correctly
  - File: (automated link check)
  - Test: Check all .md files for broken relative links
  - Validation: No 404 errors for internal references
  - Deliverable: Link check report

### Phase 6 Validation Summary

- [x] T513 Create comprehensive validation report
  - File: `specs/001-blog-kit-variant/VALIDATION-REPORT.md`
  - Content:
    - Summary of all tests run
    - Results of all automated validation scripts
    - Manual validation checklist results
    - SC-001 through SC-014 validation status
    - Any issues discovered and resolution status
    - Multi-kit compatibility verification
  - Deliverable: Final validation report

- [x] T514 Commit Phase 6 changes to git
  - File: (git commit)
  - Command: `git add -A && git commit -m "Phase 6: Validation & testing - all success criteria validated"`
  - Deliverable: Clean git history checkpoint
  - Dependency: T513

---

## Phase 7: Documentation & Polish

**Goal**: Final documentation updates, README polish, prepare for release

**Exit Criteria**:
- README.md is complete and accurate for blog-kit
- All documentation reflects blog-kit terminology
- Installation guide is clear and tested
- Project is ready for user adoption

### Documentation Updates

- [x] T601 Update `README.md` for blog-kit
  - File: `README.md`
  - Changes:
    - Replace spec-kit references with blog-kit
    - Replace "specify" command with "blog"
    - Replace "/speckit.*" commands with "/blogkit.*"
    - Update examples to show blog discovery workflow (not software development)
    - Add multi-kit coexistence section
    - Update success criteria examples
  - Validation: README reflects blog-kit clearly
  - Complexity: Moderate - comprehensive rewrite

- [x] T602 Update `docs/installation.md` for blog-kit
  - File: `docs/installation.md`
  - Changes: Update installation instructions to show `blog` command
  - Validation: Users can follow guide and install successfully

- [x] T603 Update `docs/quickstart.md` for blog-kit
  - File: `docs/quickstart.md`
  - Changes: First workflow now shows blog discovery (not software development)
  - Validation: Quickstart guides users through `/blogkit.specify` → `/blogkit.plan`

- [x] T604 Update `docs/README.md` for blog-kit
  - File: `docs/README.md`
  - Changes: Update all references to blog-kit and blogkit commands
  - Validation: Documentation homepage reflects blog-kit

- [x] T605 Create CHANGELOG entry for blog-kit initial release
  - File: `CHANGELOG.md`
  - Content: Document 001-blog-kit-variant implementation
    - Version: 1.0.0 (Initial blog-Kit Release)
    - Date: 2025-12-03
    - Summary: Namespace isolation, template adaptation, multi-kit support
  - Deliverable: Changelog entry

### Supporting Documentation

- [x] T606 Create or update `SUPPORT.md` with blog-kit resources
  - File: `SUPPORT.md`
  - Changes: Add blog-kit specific support information
  - Validation: Users know where to get help

- [x] T607 Create `MULTI-KIT-GUIDE.md` for users installing multiple kit variants
  - File: `MULTI-KIT-GUIDE.md`
  - Content: How to install and use spec-kit + blog-kit + pd-kit together
  - Examples: Which command to use for different workflows
  - Troubleshooting: Common multi-kit issues
  - Validation: Users understand how to use multiple kits

### Final Polish

- [x] T608 Verify all command file frontmatter is valid YAML
  - File: `.claude/commands/*.md` and `templates/commands/*.md`
  - Command: `for f in **/*.md; do python3 -c "import yaml; yaml.safe_load(open('$f'))" || echo "Invalid: $f"; done`
  - Validation: All YAML parses correctly
  - Deliverable: YAML validation report

- [x] T609 Verify all markdown files have proper formatting
  - File: (automated markdown lint)
  - Command: Run markdown linter on all .md files
  - Validation: No formatting errors
  - Deliverable: Markdown lint report

- [x] T610 Remove temporary test artifacts
  - File: `test-output/` directory
  - Command: Clean up test samples and validation artifacts
  - Deliverable: Clean repository state

### Final Commit and Summary

- [x] T611 Final comprehensive git commit
  - File: (git commit)
  - Command: `git add -A && git commit -m "Phase 7: Documentation & polish - blog-kit ready for release"`
  - Deliverable: Clean git history checkpoint

- [x] T612 Create project completion summary
  - File: `specs/001-blog-kit-variant/COMPLETION-SUMMARY.md`
  - Content:
    - Feature: blog-Kit Variant Implementation
    - Scope: Namespace isolation + template adaptation + multi-kit support
    - Files transformed: 40 files (Category A/B1/B2/C)
    - Success criteria: All 14 validated
    - Timeline: Started 2025-12-03
    - Deliverables:
      - CLI command: `blog` (not `specify`)
      - Agent commands: `/blogkit.*` (not `/speckit.*`)
      - Templates: Adapted for blog discovery (not software development)
      - Documentation: Multi-kit installation guide + variant creation guide
      - Tests: Validation scripts + manual tests
    - Next steps: Release to users, gather feedback, support kit variant creation
  - Deliverable: Completion summary

- [x] T613 Prepare for pull request to main branch
  - File: (git prepare for PR)
  - Command: Ensure branch is up to date and ready for review
  - Validation: All changes are on feature branch `001-blog-kit-variant`
  - Deliverable: Branch ready for PR

- [x] T614 Create comprehensive pull request with detailed description
  - File: (GitHub pull request)
  - Content:
    - Title: "feat: blog-Kit variant - namespace isolation and template adaptation for product-market-fit discovery"
    - Description:
      - Overview of changes
      - Namespace strategy (blog vs specify)
      - Template adaptations
      - Multi-kit compatibility
      - Success criteria validation
      - Testing completed
    - References: spec.md, plan.md, validation report
  - Deliverable: Pull request created and ready for review

---

## Dependencies & Execution Order

### Phase Execution Sequence
1. **Phase 1** (Setup) - MUST complete first
2. **Phase 2** (Category A) - Can start after Phase 1, no conflicts with Phase 3-5
3. **Phase 3** (Category B2) - Can run parallel with Phase 2 after T105 (prevent conflicts in template files)
4. **Phase 4** (Category B1) - Can run parallel with Phase 3 after T118 (prevent conflicts)
5. **Phase 5** (Category C) - Can run parallel with Phase 3-4 (independent new files)
6. **Phase 6** (Validation) - Must wait for Phase 2-5 completion
7. **Phase 7** (Polish) - Must wait for Phase 6 validation pass

### Parallel Execution Opportunities

**Within Phase 2** (Category A - all parallelizable):
- T101-T109: `.claude/commands/` files (9 parallel tasks)
- T110-T118: `templates/commands/` files (9 parallel tasks)
- T119-T120: Template support files (2 parallel tasks)
- Dependency: T121 must complete before T122-T123

**Within Phase 3** (Category B2 - some parallelizable):
- T201-T202: Constitution (parallel)
- T203-T204: Specify (parallel)
- T205-T206: Clarify (parallel)
- T207-T208: Plan (parallel)
- T209-T210: Tasks (parallel)
- T211-T212: Implement (parallel)
- T213-T214: Analyze (parallel)
- T215-T216: Checklist (parallel)
- T217-T218: TasksToIssues (parallel)
- No cross-dependencies within phase

**Within Phase 4** (Category B1 - sequential within template, parallel between templates):
- T301, T302, T303, T304, T305: All parallelizable with each other
- Validation tasks T306-T309 must run after respective template tasks

**Within Phase 5** (Category C - all parallelizable):
- T401-T407: All reference docs can be created in parallel
- T408 depends on all others

### Critical Path
1. T001-T005 (Phase 1 setup)
2. T101-T124 (Phase 2 transformations) or T201-T218 (Phase 3 if prioritizing)
3. T301-T310 (Phase 4 transformations)
4. T501-T514 (Phase 6 validation - gates Phase 7)
5. T601-T614 (Phase 7 completion)

**Estimated Timeline**:
- Phase 1: 1-2 hours (sequential)
- Phase 2: 2-3 hours (24 tasks, mostly parallel)
- Phase 3: 8-10 hours (18 tasks, content adaptation, sequential)
- Phase 4: 12-15 hours (5 templates, heavy content adaptation, sequential within template)
- Phase 5: 4-6 hours (7 docs, parallel)
- Phase 6: 6-8 hours (validation and testing, some parallel)
- Phase 7: 4-5 hours (documentation polish, sequential)

**Total: 37-49 hours focused work** (aligns with plan.md estimate of 30-40 hours)

---

## Implementation Notes

### Key Principles
1. **Zero Infrastructure Changes**: All transformations are template/content/namespace only. No changes to spec-kit CLI architecture, installation patterns, or directory structure.

2. **Namespace Isolation**: All "speckit" replaced with "blogkit" to enable multi-kit coexistence:
   - CLI: `specify` → `blog`
   - Agent commands: `/speckit.*` → `/blogkit.*`
   - Handoffs: `speckit.plan` → `blogkit.plan`

3. **Content Adaptation**: Software development concepts mapped to blog discovery:
   - User Story (feature) → Learning Objective (hypothesis)
   - Functional Requirement → Research Question
   - Technical Architecture → Research Methods
   - Development Phase → blog Phase (Discovery/Beta/Launch/Scale)
   - Unit Tests → Validation Experiments

4. **Reversibility**: Each phase has git commit checkpoints. Any issues can be rolled back cleanly.

5. **Validation First**: Phase 6 gates Phase 7. All success criteria must validate before polish work.

### File Categories Reference

**Category A** (Simple Find-and-Replace): ~15 files
- `.claude/commands/*.md` (9 files)
- `templates/commands/*.md` (9 files)
- Supporting template files (2 files)
- Script files (if speckit references exist)

**Category B1** (Heavy Content Adaptation): ~5 files
- `templates/spec-template.md`
- `templates/plan-template.md`
- `templates/tasks-template.md`
- `templates/checklist-template.md`
- `templates/CLAUDE-template.md` or equivalent

**Category B2** (Moderate Content Adaptation): ~10 files
- `.claude/commands/specify.md`, `plan.md`, `tasks.md`, `implement.md`, `analyze.md`, `checklist.md`
- `templates/commands/` versions of the above
- Scripts with content updates

**Category C** (New File Creation): ~7 files
- `refs/4_variant_creation_guide.md`
- `refs/5_namespace_strategy.md`
- `specs/001-blog-kit-variant/quickstart.md`
- `specs/001-blog-kit-variant/contracts/*.md` (3 files)
- `specs/001-blog-kit-variant/data-model.md`

### Validation Strategy
Each phase ends with validation that confirms:
1. No "speckit" instances remain in implementation (automated grep)
2. All blogkit references are correct (spot check)
3. Generated artifacts follow blog patterns (manual review)
4. Commits are clean and reversible (git log)

---

## Success Metrics

Upon Phase 7 completion, the blog-kit implementation will be complete when:

✅ **Namespace Isolation**: Users can install spec-kit and blog-kit on same system without conflicts (SC-001, SC-003)

✅ **Fast Initialization**: `blog init` completes in <2 minutes (SC-002)

✅ **blog-Focused Templates**: Generated blog specs contain all required sections with zero technical terms (SC-004, SC-005, SC-006, SC-008)

✅ **Efficiency Gain**: Users spend 70% less time on blog hypothesis structuring vs blank page (SC-007)

✅ **AI Product Integration**: Generated specs reference 3+ successful AI products (Cursor, Runway, Harvey, etc.) (SC-009)

✅ **Variant Extensibility**: Users can create minimal blog-kit variant (pd-kit, marketing-kit) in 8 hours using guide (SC-010, SC-011)

✅ **Workflow Completion**: 90% of users can complete full blog discovery workflow without confusion (SC-013)

✅ **Research Artifacts**: Completed workflows produce research documentation (interviews, data, decisions), not code artifacts (SC-014)

---

## Appendix: Quick Reference

### Command Mapping
| spec-kit | blog-kit | Purpose |
|----------|---------|---------|
| `specify` | `blog` | CLI command |
| `specify init` | `blog init` | Initialize project |
| `specify check` | `blog check` | Verify installation |
| `/speckit.specify` | `/blogkit.specify` | Create spec |
| `/speckit.plan` | `/blogkit.plan` | Create plan |
| `/speckit.tasks` | `/blogkit.tasks` | Generate tasks |
| `/speckit.implement` | `/blogkit.implement` | Execute tasks |

### Task ID Quick Reference
- T001-T005: Setup & verification
- T101-T126: Phase 2 namespace isolation (Category A)
- T201-T220: Phase 3 command transformation (Category B2)
- T301-T310: Phase 4 template content (Category B1)
- T401-T409: Phase 5 reference docs (Category C)
- T501-T514: Phase 6 validation & testing
- T601-T614: Phase 7 documentation & polish

**Total Tasks**: 114 tasks across 7 phases
