# Feature Specification: blog-Kit Variant

**Feature Branch**: `001-blog-kit-variant`
**Created**: 2025-12-03
**Status**: Draft
**Input**: User description: "blog-Kit: Spec-driven development variant for product-market-fit discovery of AI SaaS products with CLI and agent command namespace isolation"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Install blog-Kit Without Conflicts (Priority: P1)

A product manager or founder who already has spec-kit installed wants to install blog-kit to work on blog discovery for their AI SaaS product. They should be able to install both kits on the same system without naming conflicts or command collisions.

**Why this priority**: This is the foundational capability that enables all other blog-Kit usage. Without conflict-free installation, users cannot adopt the tool.

**Independent Test**: Can be fully tested by installing both spec-kit and blog-kit on the same system, then successfully running commands from both kits (e.g., `specify init` vs `blog init` and `/speckit.specify` vs `/blogkit.specify`) and verifying they invoke different workflows.

**Acceptance Scenarios**:

1. **Given** a system with spec-kit already installed, **When** user installs blog-kit using `uv tool install blog-cli --from git+https://github.com/agentii-ai/blog-kit.git`, **Then** both `specify` and `blog` commands are available and functional
2. **Given** both kits are installed, **When** user runs `specify check` and `blog check`, **Then** each command shows its respective kit's configuration and tools
3. **Given** a Claude Code session in a blog-kit project, **When** user types `/`, **Then** both `/speckit.*` and `/blogkit.*` commands are visible in autocomplete
4. **Given** a project initialized with blog-kit, **When** user runs `/blogkit.specify`, **Then** blog-specific templates and workflows are triggered, not spec-kit's software development templates

---

### User Story 2 - Initialize blog Discovery Project (Priority: P1)

A founder wants to start a structured blog discovery initiative for their AI SaaS product. They should be able to quickly bootstrap a project with blog-specific templates, constitution, and workflows.

**Why this priority**: This is the entry point for all blog discovery work. Without project initialization, users cannot begin using the blog methodology.

**Independent Test**: Can be tested by running `blog init my-ai-product` and verifying that the resulting directory structure contains blog-specific templates, constitution, and agent commands (not software development templates).

**Acceptance Scenarios**:

1. **Given** an empty directory, **When** user runs `blog init my-ai-product`, **Then** a new project structure is created with blog-specific constitution, templates, and commands
2. **Given** a new blog project, **When** user launches Claude Code in the project directory, **Then** `/blogkit.*` commands are available (constitution, specify, plan, tasks, implement, clarify, analyze, checklist)
3. **Given** a blog project, **When** user opens `memory/constitution.md`, **Then** blog-specific principles are present (Customer-Evidence-Driven, Iterative Validation, etc.)
4. **Given** initialization with `--ai claude` flag, **When** project is created, **Then** `.claude/commands/` directory contains blogkit.* command files

---

### User Story 3 - Create blog Discovery Specification (Priority: P2)

A product manager wants to define a blog discovery initiative following modern AI SaaS patterns (e.g., "Validate demand for AI-powered contract review among solo lawyers, similar to Harvey's approach"). They should be able to create a structured specification that captures:
- Sharp persona and segment definition (role, tools, environment)
- Top 3 jobs-to-be-done with current workarounds
- 1-2 hero workflows (intent → AI work → artifact)
- blog signals and success metrics (behavioral + business)
- Constraints, risks, and distribution hypotheses

**Why this priority**: This enables users to apply spec-driven methodology to blog discovery with the same rigor that Cursor, Runway, Harvey, and other successful AI products used, ensuring systematic hypothesis testing rather than ad-hoc experimentation.

**Independent Test**: Can be tested by running `/blogkit.specify "Validate willingness to pay for AI video generation among YouTube creators"` and verifying that the generated spec.md contains:
- Specific persona (e.g., "YouTube creators with 10k-100k subs making tutorial content")
- JTBD with current workarounds (e.g., "When I need to produce weekly videos, I want to cut editing time by 80%, so I can focus on content strategy")
- Hero workflow (e.g., "Upload rough footage → AI edits with style templates → creator reviews and tweaks → export")
- Workflow-level metrics (time-to-first-wow, completion rate, retention curves)
- No technical implementation details

**Acceptance Scenarios**:

1. **Given** a blog project, **When** user runs `/blogkit.specify` with a blog discovery description, **Then** a new feature branch and spec.md are created with blog-specific sections: Personas & Segments, Problems & JTBD (top 3), Hero Workflows (1-2), Success Metrics & blog Signals, Constraints & Risks, Distribution Hypotheses
2. **Given** a blog specification, **When** reviewing the Personas section, **Then** it includes role/skill level, company size/type, current tool stack, environment constraints (not generic "small business owner")
3. **Given** a blog specification, **When** reviewing JTBD section, **Then** each job includes: job story format ("When [situation], I want to [job], so I can [outcome]"), current workaround with specific tools/processes, key frustrations, and "10x better" definition
4. **Given** a blog specification, **When** reviewing Hero Workflows section, **Then** each workflow includes: name, trigger/intention, inputs, step-by-step (user vs AI responsibilities), guardrails/approvals, output destination, TTFW target (e.g., "under 10 minutes"), minimum quality bar
5. **Given** a blog specification, **When** reviewing Success Metrics section, **Then** it includes activation metrics (% completing hero workflow in 7 days, TTFW median/p90), engagement metrics (runs per user per week, retention curves), AI-specific metrics (task completion rate, edit effort, prompt-to-output time), and business metrics (conversion to paid, ARPU/NRR)
6. **Given** a blog specification, **When** checking for implementation details, **Then** no technical stack, programming languages, or code architecture are present (only research tools like Calendly, Typeform, Notion for coordination)
7. **Given** a blog specification, **When** reviewing Constraints & Risks section, **Then** it explicitly lists: domain/compliance constraints, technical/UX constraints (latency expectations, integration needs), business constraints (pricing bands, unit economics), and top 3-5 blog risks (e.g., "wrapper risk", "autonomy theater", "trust/hallucination risk") with mitigation hypotheses

---

### User Story 4 - Plan blog Discovery Execution (Priority: P2)

A founder wants to define HOW they will execute their blog discovery initiative (research methods, sample sizes, tools, data collection instruments). They should be able to create an execution plan that specifies the concrete research approach.

**Why this priority**: Bridges the gap between what we want to learn (spec) and actionable tasks, ensuring clear methodology before execution.

**Independent Test**: Can be tested by running `/blogkit.plan` after creating a blog spec and verifying that the generated plan.md contains research methods, sample sizes, interview scripts, survey designs, and analysis approaches (not code architecture or database schemas).

**Acceptance Scenarios**:

1. **Given** a blog specification, **When** user runs `/blogkit.plan` with research methodology details, **Then** a plan.md is created with research methods, sample sizes, recruitment criteria, and data collection instruments
2. **Given** a blog plan, **When** reviewing the plan.md, **Then** it contains sections for research approach, participant recruitment, interview/survey designs, and analysis methods
3. **Given** a blog plan, **When** checking technical context, **Then** tools mentioned are research tools (Calendly, Typeform, Notion) not development tools (databases, APIs, frameworks)
4. **Given** a blog plan, **When** reviewing Constitution Check section, **Then** gates validate blog-specific principles (Customer-Evidence-Driven, Minimal Viable Process) not software engineering principles

---

### User Story 5 - Generate Actionable blog Tasks (Priority: P3)

A product manager wants to break down their blog discovery plan into specific, ordered tasks (recruit participants, conduct interviews, analyze results, validate findings). They should be able to generate a task list organized by learning objective.

**Why this priority**: Enables systematic execution of blog discovery with clear dependencies and validation checkpoints.

**Independent Test**: Can be tested by running `/blogkit.tasks` after creating spec and plan, and verifying that tasks.md contains research execution tasks (schedule interviews, prepare discussion guides, analyze transcripts) not development tasks (write code, create APIs, deploy servers).

**Acceptance Scenarios**:

1. **Given** a blog plan, **When** user runs `/blogkit.tasks`, **Then** a tasks.md is created with research tasks grouped by learning objective
2. **Given** blog tasks, **When** reviewing task list, **Then** tasks include participant recruitment, research execution, data analysis, and validation checkpoints
3. **Given** blog tasks, **When** checking task descriptions, **Then** they reference research artifacts (interview transcripts, survey responses, validation data) not code files
4. **Given** blog tasks, **When** reviewing dependencies, **Then** order reflects research workflow (recruit before interview, interview before analysis) not software dependencies (models before services)

---

### User Story 6 - Execute blog Discovery Tasks (Priority: P3)

A founder wants to systematically execute their blog discovery tasks with AI agent assistance. They should be able to run `/blogkit.implement` and have the agent help with research execution, data analysis, and validation while maintaining human oversight.

**Why this priority**: Completes the end-to-end blog discovery workflow, enabling systematic execution with AI assistance.

**Independent Test**: Can be tested by running `/blogkit.implement` and verifying that the agent executes research tasks (not development tasks) with appropriate validation checkpoints and evidence collection.

**Acceptance Scenarios**:

1. **Given** blog tasks, **When** user runs `/blogkit.implement`, **Then** the agent begins executing research tasks in dependency order with progress tracking
2. **Given** task execution, **When** agent completes a task, **Then** evidence is documented (interview notes, survey data, validation results) not code commits
3. **Given** task execution, **When** reaching validation checkpoints, **Then** agent prompts for human review of findings and pivot/continue decisions
4. **Given** completed tasks, **When** reviewing implementation artifacts, **Then** research documentation and evidence are present (not deployed software or APIs)

---

### Edge Cases

- What happens when a user has multiple *-kit variants installed (spec-kit, blog-kit, pd-kit, marketing-kit) and tries to use commands?
- How does the system handle when user accidentally types `/speckit.specify` in a blog-kit project?
- What happens if user tries to install blog-kit when the `blog` command name is already taken by another tool?
- How does the system differentiate between software development specs and blog discovery specs when reviewing templates?
- What happens when user wants to convert a blog discovery initiative into a software implementation project?

## Requirements *(mandatory)*

### Functional Requirements

#### CLI Namespace Isolation

- **FR-001**: System MUST provide a CLI command named `blog` (not `specify`) for all blog-Kit operations
- **FR-002**: System MUST support `blog init <project>` to initialize blog discovery projects
- **FR-003**: System MUST support `blog check` to verify blog-Kit installation and dependencies
- **FR-004**: CLI package MUST be named `blog-cli` (not `specify-cli`) to avoid conflicts with spec-kit
- **FR-005**: System MUST allow concurrent installation with spec-kit without command name collisions

#### Agent Command Namespace Isolation

- **FR-006**: System MUST provide agent commands with `blogkit.*` prefix (not `speckit.*`)
- **FR-007**: System MUST support `/blogkit.constitution` command for establishing blog-specific project principles
- **FR-008**: System MUST support `/blogkit.specify` command for creating blog discovery specifications
- **FR-009**: System MUST support `/blogkit.plan` command for defining research execution plans
- **FR-010**: System MUST support `/blogkit.tasks` command for generating actionable research task lists
- **FR-011**: System MUST support `/blogkit.implement` command for executing blog discovery tasks
- **FR-012**: System MUST support `/blogkit.clarify` command for structured clarification of blog hypotheses
- **FR-013**: System MUST support `/blogkit.analyze` command for cross-artifact consistency analysis
- **FR-014**: System MUST support `/blogkit.checklist` command for generating blog validation checklists

#### Template Adaptation for AI SaaS blog Discovery

- **FR-015**: spec-template.md MUST include structured sections based on modern AI SaaS blog patterns: 1) Personas & Segments (role/skill, company size/type, tools, environment), 2) Problems & Jobs-to-Be-Done (top 3 ranked with job stories, current workarounds, "10x better" definitions), 3) Hero Workflows (1-2 max, with name, trigger, inputs, steps, TTFW target, quality bar), 4) Success Metrics & blog Signals (activation, engagement, AI-specific, business metrics), 5) Constraints & Risks (domain/compliance, technical/UX, business, top 3-5 blog risks), 6) Distribution & Adoption Hypotheses (channels, shareable artifacts, team expansion), 7) Open Questions (persona fit, workflow depth, pricing, model sufficiency)
- **FR-016**: spec-template.md MUST use hero workflow structure from successful AI products: Cursor/Claude Code-style (intent → AI edits → review → merge), Runway/Pika-style (input → AI generation → iterate → export), Harvey/Writer-style (template → AI draft → redline → approve), PhotoRoom/Canva-style (upload → transform → apply template → export)
- **FR-017**: spec-template.md MUST capture AI-specific blog metrics: task completion rate (% of workflows reaching satisfactory outcome), edit distance/effort (time spent correcting AI output), prompt-to-output time (median and p90), autonomy rate (% of end-to-end completion), trust indicators (ratings, error reports, escalations)
- **FR-018**: plan-template.md MUST focus on blog discovery research methods (not code architecture): customer interview protocols, survey design, behavioral experiment design, evidence collection instruments, analysis frameworks, validation checkpoints
- **FR-019**: plan-template.md MUST include blog-specific risk mitigation strategies based on common failure modes: avoiding "thin wrapper" risk (workflow + data moats), avoiding "feature sprawl" (depth before breadth), avoiding "autonomy theater" (explicit scope/limits, checkpoints), avoiding persona dilution (flag-planting persona for 12-18 months)
- **FR-020**: tasks-template.md MUST organize research tasks by learning objective (not user story for features): recruit participants from target segment, execute hero workflow research (interviews, observations, prototypes), analyze evidence (transcripts, behavioral data), validate hypotheses (pivot/persevere decisions), document learnings
- **FR-021**: Constitution MUST include blog-specific principles adapted from AI SaaS best practices: I) Specification-First Approach (hypotheses before experiments), II) Customer-Evidence-Driven (direct evidence, not opinions), III) Iterative Validation (build-measure-learn cycles), IV) Minimal Viable Process (simplest method for learning), V) Cross-Functional Integration (product, eng, GTM insights), VI) Kit Namespace Isolation (coexist with spec-kit, pd-kit, etc.), VII) Template Extensibility (reference for other kit variants)
- **FR-022**: All templates MUST reference `blogkit.*` commands consistently, not `speckit.*` commands
- **FR-023**: Templates MUST include examples from successful AI products: developer tools (Cursor, Claude Code, Devin, Lovable), creative tools (Runway, Pika, HeyGen, Descript, PhotoRoom), vertical tools (Harvey, Writer), PLG icons (Canva, Figma, Notion)

#### Installation Compatibility

- **FR-024**: System MUST install via `uv tool install blog-cli --from git+https://github.com/agentii-ai/blog-kit.git`
- **FR-025**: System MUST support same AI agent integrations as spec-kit (Claude Code, Cursor, Windsurf, Gemini, etc.)
- **FR-026**: System MUST use same CLI flags and options as spec-kit (--ai, --script, --here, --force, etc.)
- **FR-027**: System MUST maintain same directory structure patterns as spec-kit (.specify/, specs/, templates/, memory/)
- **FR-028**: System MUST support multi-kit installation documentation explaining namespace strategy

#### blog-Specific Workflow Features

- **FR-029**: Specifications MUST prioritize learning objectives over feature development (what to learn, who to learn from, how to measure success)
- **FR-030**: Hero workflows MUST be AI-native (primary interaction is intent → AI draft → user edits, not manual creation + optional AI)
- **FR-031**: Hero workflows MUST include explicit guardrails and approval checkpoints (following patterns from Harvey's legal review, Cursor's diff views, Runway's preview-before-render)
- **FR-032**: Plans MUST specify evidence collection methods that prioritize behavioral data over stated preferences (following "customers who pay" > "customers who say" principle)
- **FR-033**: Tasks MUST include customer validation checkpoints with pivot/persevere decision criteria (not just "collect feedback")
- **FR-034**: Success criteria MUST measure workflow-level adoption (depth of usage, "default tool" status, replacement of incumbents) not just signups or feature clicks

### Key Entities

- **blog-Kit Project**: A structured workspace for blog discovery initiatives with blog-specific templates, constitution, and workflows adapted from spec-kit architecture
- **Target Persona**: A specific user role with defined skill level, company context, current tool stack, and environment constraints (not generic segments like "small business owners")
- **Target Segment**: Company size/type, vertical, geography combination that defines the initial market wedge (e.g., "US Series A-C B2B SaaS companies with 50-500 employees")
- **Job-to-Be-Done (JTBD)**: Structured as "When [situation], I want to [job], so I can [outcome]" with documented current workaround, frustrations, and "10x better" definition
- **Hero Workflow**: End-to-end AI-native flow from user intent to finished artifact, with explicit steps, user/AI responsibilities, guardrails, TTFW target, and quality bar (inspired by Cursor's coding loops, Runway's video creation, Harvey's contract drafting)
- **blog Specification**: A learning-focused document structured around: Personas & Segments, Problems & JTBD (top 3), Hero Workflows (1-2), Success Metrics & blog Signals, Constraints & Risks, Distribution Hypotheses, Open Questions
- **blog Plan**: An execution document specifying blog discovery research methods: customer interview protocols, behavioral experiment designs, evidence collection instruments, analysis frameworks, validation checkpoints (not technical architecture)
- **blog Tasks**: Actionable research tasks organized by learning objective: recruit participants from target segment, execute hero workflow research, analyze evidence, validate hypotheses with pivot/persevere criteria, document learnings
- **Learning Objective**: A prioritized, falsifiable hypothesis about customer behavior, willingness to pay, or workflow value that can be validated or refuted with direct evidence
- **Evidence**: Documented artifacts proving or disproving hypotheses: timestamped interview transcripts with verbatim quotes, behavioral data (usage logs, retention curves), willingness-to-pay signals (upgrades, expansions, reference customers)
- **blog Signal**: Quantitative or qualitative indicator of product-market fit: retention curves flattening >20-30% at 3-6 months, workflow completion rates, time-in-product, "very disappointed if lost" responses, organic word-of-mouth, replacement of incumbent tools
- **blog Risk**: Known failure mode for AI SaaS products with mitigation strategy: thin wrapper risk (build workflow + data moats), feature sprawl (depth before breadth), autonomy theater (explicit limits + checkpoints), persona dilution (flag-planting for 12-18 months), trust/hallucination risk (governance + audit trails)
- **Distribution Hypothesis**: Testable assumption about how users discover, adopt, and expand usage: channel-persona fit, shareable artifacts strategy, template ecosystem, integration-driven growth, team expansion mechanisms
- **Kit Variant**: A domain-specific adaptation of spec-kit with unique CLI command and agent namespace (blog-kit for blog discovery, pd-kit for product design, marketing-kit for marketing workflows, biz-writing-kit for business writing)

## Success Criteria *(mandatory)*

### Measurable Outcomes

#### Installation & Tooling Success

- **SC-001**: Users can install both spec-kit and blog-kit on the same system without conflicts, verified by successfully running `specify check` and `blog check` commands side-by-side
- **SC-002**: Users can initialize a blog project in under 2 minutes using `blog init my-product` command, measured from command execution to Claude Code showing `/blogkit.*` commands
- **SC-003**: Users can distinguish between spec-kit and blog-kit commands with zero confusion, validated by 95% correct command selection in mixed-use scenarios (measured via command usage logs)

#### Specification Quality & blog Focus

- **SC-004**: Generated blog specifications contain all required blog-specific sections with zero technical implementation details:
  - MUST include: Personas & Segments, Problems & JTBD (3), Hero Workflows (1-2), Success Metrics, Constraints & Risks, Distribution Hypotheses
  - MUST NOT include: programming languages, frameworks, databases, API designs, code architecture
  - Validated by automated scan for technical terms (Python, React, PostgreSQL, REST, GraphQL, etc.)
- **SC-005**: Personas in generated specs are sharp and actionable (not generic):
  - Include role/skill level (e.g., "Senior backend engineer at 50-500 person SaaS")
  - Include company context (size/type/vertical)
  - Include current tool stack (specific tools, not "various tools")
  - Validated by presence of all required fields in persona section
- **SC-006**: Hero workflows in generated specs follow AI-native patterns with measurable quality bars:
  - Include step-by-step breakdown with explicit user vs AI responsibilities
  - Include guardrails/approval checkpoints (like Cursor diffs, Harvey redlines, Runway previews)
  - Include TTFW target in minutes (e.g., "under 10 minutes for first-time users")
  - Include minimum quality bar for outputs
  - Validated by checklist completion rate >90%

#### blog Discovery Efficiency

- **SC-007**: Users creating blog specs with `/blogkit.specify` spend 70% less time on hypothesis structuring compared to blank-page blog discovery (baseline: 4 hours unstructured → target: 1.2 hours with blog-Kit), measured via user time tracking or self-reported duration
- **SC-008**: Generated blog specs include AI-specific metrics that successful products use:
  - Activation: % completing hero workflow in 7 days, TTFW (median/p90)
  - Engagement: workflow runs per user per week, retention curves at 4/12 weeks
  - AI-specific: task completion rate (%), edit effort (qualitative + proxies), prompt-to-output time
  - Business: conversion to paid for workflow completers, ARPU/NRR by workflow
  - Validated by presence of all metric categories in Success Metrics section
- **SC-009**: blog-Kit-generated specs reference successful AI product patterns 3+ times per spec (Cursor, Runway, Harvey, Writer, Canva, Figma, Notion, etc.), demonstrating connection to proven blog approaches

#### Template Extensibility & Variant Creation

- **SC-010**: blog-Kit serves as reference implementation for creating 3+ additional kit variants (pd-kit, marketing-kit, biz-writing-kit) within 6 months of launch, each with unique namespace and domain-specific templates
- **SC-011**: Documentation in /refs/ directory enables users to create their own kit variant in under 8 hours, validated by 80% of test users successfully creating a minimal viable kit variant (unique CLI command, unique agent namespace, 3+ adapted templates) within this time
- **SC-012**: Multi-kit installation documentation reduces namespace collision issues to zero reported incidents in first 3 months post-launch

#### Workflow Completion & Adoption

- **SC-013**: 90% of users can complete a full blog discovery workflow (constitution → specify → clarify → plan → tasks → implement) without confusion between spec-kit and blog-kit commands, measured via workflow completion telemetry and support ticket analysis
- **SC-014**: Users completing full blog workflow produce research artifacts (not code artifacts):
  - Evidence: interview transcripts, survey data, behavioral logs, validation results
  - Decisions: documented pivot/persevere choices with supporting evidence
  - Metrics: retention curves, completion rates, willingness-to-pay signals
  - NOT: code commits, API deployments, database migrations, CI/CD runs
  - Validated by artifact type analysis at `/blogkit.implement` completion

## Out of Scope *(optional)*

- blog validation tools integration (Typeform, Calendly, etc.) - users will use external tools for research execution
- Automated customer recruitment - users must handle participant sourcing
- Data analysis automation - users must analyze research data manually or with external tools
- Multi-language support for CLI and templates (English only in initial release)
- GUI or web interface (CLI and agent commands only)
- Direct integration with CRM or customer data platforms
- Automated blog metric calculation or dashboards
- Real-time collaboration features within blog-Kit
- Migration tools from spec-kit projects to blog-kit projects

## Assumptions *(optional)*

- Users are familiar with basic spec-driven development concepts from spec-kit
- Users have Python 3.11+, uv, and Git installed
- Users have access to one of the supported AI agents (Claude Code, Cursor, Windsurf, etc.)
- Users understand basic blog concepts (hypotheses, customer validation, evidence-driven decisions)
- Installation via uv tool is acceptable to target users
- English-language templates are sufficient for initial release
- Users are comfortable with command-line interfaces
- GitHub is accessible for installation (not blocked by corporate firewalls)
- Users will handle customer research execution using external tools (interviews, surveys)
- Users can analyze qualitative research data without automated tooling

## Dependencies *(optional)*

- **Upstream spec-kit**: blog-Kit forks and adapts spec-kit architecture, templates, and CLI patterns
- **uv package manager**: Required for installation and tool management
- **Git**: Required for version control and branch-per-feature workflow
- **Python 3.11+**: Runtime environment for CLI and scripts
- **AI agent platforms**: Claude Code, Cursor, Windsurf, or compatible agent for workflow execution
- **GitHub**: Hosts the blog-kit repository for installation

## Constraints *(optional)*

- Must maintain architectural compatibility with spec-kit to leverage existing infrastructure
- Must use unique namespaces (blog, blogkit.*) to avoid conflicts with other kit variants
- Must not require changes to spec-kit codebase (pure fork with adaptations)
- CLI must follow same installation patterns as spec-kit (uv tool install)
- Templates must follow same structure as spec-kit to enable easy variant creation
- Must support all AI agents supported by spec-kit (Claude Code, Cursor, Windsurf, Gemini, Copilot, etc.)
- Documentation must enable users to create additional kit variants following the same pattern

## Related Features or Documentation *(optional)*

- **spec-kit repository**: https://github.com/github/spec-kit - upstream project providing architecture and patterns for spec-driven development
- **Spec-Driven Development Methodology**: Core methodology document in spec-kit explaining structured AI-assisted workflows for software development
- **blog Principles for AI SaaS (2024-2025)**: /refs/1_principles_for_constitution.md - comprehensive research on modern AI SaaS blog patterns from Cursor, Claude Code, Devin, Runway, Pika, HeyGen, Harvey, Writer, Canva, Figma, Notion
- **blog-Specific Spec Structure**: /refs/2_define_for_specify.md - detailed guidance for creating blog-focused specifications with personas & segments, JTBD, hero workflows, success metrics, constraints & risks, distribution hypotheses
- **blog-Kit Constitution**: /memory/constitution.md - blog-Kit specific principles established in Phase 0 (v1.0.0)
- **Kit Namespace Strategy**: (To be created) Documentation explaining multi-kit installation and namespace isolation strategy for coexisting kit variants
- **Variant Creation Guide**: (To be created) Step-by-step guide in /refs/ for creating domain-specific kit variants (pd-kit, marketing-kit, biz-writing-kit) following blog-Kit pattern
- **Successful AI Product Case Studies**: Referenced throughout templates - Cursor (dev tools), Runway (video), Harvey (legal), Writer (enterprise), PhotoRoom (commerce), demonstrating proven blog approaches
