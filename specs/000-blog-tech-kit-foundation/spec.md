# Feature Specification: Blog-Tech-Kit Foundation

**Feature Branch**: `000-blog-tech-kit-foundation`
**Created**: 2025-12-04
**Status**: Foundation
**Type**: Kit Variant (Spec-Driven Development for Technical Blogging & Twitter Marketing)

## Executive Summary

Blog-Tech-Kit is a specialized variant of spec-kit that applies spec-driven development methodology to **Twitter marketing and technical blog growth for AI SaaS products**. It enables product teams to systematically build authority blogs, create content strategies, and execute Twitter growth campaigns using the same rigorous specify → plan → tasks → implement workflow that spec-kit uses for software development.

**Core Insight**: Just as spec-kit treats software development as a specification problem, Blog-Tech-Kit treats content marketing as a specification problem. Before writing code (or content), define what success looks like, who the audience is, and how to measure impact.

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Install Blog-Tech-Kit Alongside Spec-Kit (Priority: P0)

A technical founder building an AI SaaS product wants to use spec-kit for software development AND Blog-Tech-Kit for content marketing in the same repository. They should be able to install both kits without CLI command conflicts, namespace collisions, or workflow interference.

**Why this priority**: Multi-kit coexistence is the foundational architecture requirement. If Blog-Tech-Kit conflicts with spec-kit, users cannot adopt it in existing spec-kit projects.

**Independent Test**: Can be fully tested by:
1. Installing both kits on the same machine: `uv tool install specify-cli` and `uv tool install blog-cli`
2. Verifying both `specify` and `blog` CLI commands work independently
3. Running `/speckit.plan` and `/blogkit.plan` in Claude Code and confirming they trigger different workflows
4. Checking that `.specify/` directory is shared while `.claude/commands/` contains isolated command files

**Acceptance Scenarios**:

1. **Given** a system with spec-kit installed, **When** user installs blog-cli using `uv tool install blog-cli --from git+https://github.com/[org]/blog-tech-kit.git`, **Then** both `specify` and `blog` commands are available
2. **Given** both kits installed, **When** user runs `specify check` and `blog check`, **Then** each command shows its respective configuration without conflict
3. **Given** a Claude Code session with both kits, **When** user types `/`, **Then** autocomplete shows both `/speckit.*` and `/blogkit.*` commands distinctly
4. **Given** a project using both kits, **When** user runs `/blogkit.plan`, **Then** Blog-Tech-Kit templates and workflows execute (not spec-kit software templates)
5. **Given** both kits installed, **When** user examines `.specify/memory/constitution.md`, **Then** the active constitution is Blog-Tech-Kit's (identified by header comment)
6. **Given** both kits installed, **When** user switches from spec-kit to blog-kit via `blog init --here --force`, **Then** `.claude/commands/blogkit.*` files replace `/speckit.*` files, and constitution updates to Blog-Tech-Kit version

---

### User Story 2 - Initialize Blog Content Strategy Project (Priority: P1)

A product marketer wants to launch a technical blog for their AI agent product (inspired by Anthropic, LangChain, Together AI). They should be able to bootstrap a project with blog-specific templates, editorial workflows, and content principles.

**Why this priority**: This is the entry point for all Blog-Tech-Kit usage. Without project initialization, users cannot begin structured content work.

**Independent Test**: Can be tested by running `blog init my-ai-blog` and verifying:
- Constitution contains blog principles (Content-First, AI-Native Distribution, etc.)
- Templates include content strategy, editorial workflow, blog post structure
- Slash commands are `/blogkit.*` not `/speckit.*`

**Acceptance Scenarios**:

1. **Given** an empty directory, **When** user runs `blog init my-ai-blog`, **Then** a new project structure is created with Blog-Tech-Kit constitution, templates, and commands
2. **Given** a blog project, **When** user launches Claude Code, **Then** `/blogkit.*` commands are available (constitution, specify, clarify, plan, tasks, implement, checklist, analyze)
3. **Given** a blog project, **When** user opens `.specify/memory/constitution.md`, **Then** blog-specific principles are present (8 Core Blog Principles from refs/1_principles_for_constitution.md)
4. **Given** initialization with `--ai claude`, **When** project created, **Then** `.claude/commands/blogkit.*.md` files are present
5. **Given** a blog project, **When** user examines `.specify/templates/`, **Then** templates include: content-strategy-template.md, editorial-workflow-template.md, blog-post-template.md (not software development templates)

---

### User Story 3 - Define Content Strategy with `/blogkit.specify` (Priority: P1)

A content lead wants to define a content strategy for an "Authority Blog targeting AI/LLM developers with production-grade agent patterns" (similar to Anthropic's approach). They should be able to create a specification that captures:

- **Blog Type**: Authority / Practitioner / Community / Thought Leadership
- **Target Audience**: Specific developer persona (role, pain points, tools)
- **Content Pillars**: 3-5 core themes aligned with product value
- **Publishing Cadence**: Realistic frequency based on blog type and team capacity
- **Success Metrics**: Traffic, citations, developer CAC, SEO rankings
- **Distribution Strategy**: Owned, amplified, and community channels

**Why this priority**: This enables users to apply spec-driven thinking to content strategy—defining WHAT and WHY before HOW (technical implementation).

**Independent Test**: Can be tested by running `/blogkit.specify "Create an authority blog targeting AI/LLM developers with production-grade agent patterns"` and verifying spec.md contains:
- Explicit blog type declaration (Authority)
- Specific persona (e.g., "Senior ML Engineers building production LLM systems")
- 3-5 content pillars (e.g., "Context Engineering," "Multi-Agent Orchestration," "Production Debugging")
- Measurable success metrics (e.g., "50K+ monthly organic traffic by Month 12")
- NO implementation details (no CMS choice, no framework selection, no hosting platform)

**Acceptance Scenarios**:

1. **Given** a blog project, **When** user runs `/blogkit.specify` with content strategy description, **Then** a new feature branch and spec.md are created with blog-specific sections: Blog Type Declaration, Target Audience, Content Pillars, Publishing Cadence, Success Criteria, Distribution Requirements
2. **Given** a blog specification, **When** reviewing Blog Type Declaration, **Then** it explicitly states: Authority, Practitioner, Community, or Thought Leadership with rationale
3. **Given** a blog specification, **When** reviewing Target Audience, **Then** it includes: specific role/title, skill level, company context, current tool stack, pain points, and reading preferences (not generic "developers")
4. **Given** a blog specification, **When** reviewing Content Pillars, **Then** each pillar includes: pillar name, why you're credible to write about it, target keywords, example post titles, and alignment with product value
5. **Given** a blog specification, **When** reviewing Publishing Cadence, **Then** it specifies realistic frequency (Authority: 1-2 posts/quarter; Practitioner: 2-4 posts/month) with team capacity justification
6. **Given** a blog specification, **When** reviewing Success Criteria, **Then** it includes blog-type-appropriate metrics: Authority (citations, keyword rankings, backlinks), Practitioner (developer CAC, SDK downloads, tutorial completion), Community (contributor count, engagement), Thought Leadership (speaking invitations, advisor roles)
7. **Given** a blog specification, **When** checking for implementation details, **Then** NO technology choices are present (no WordPress, Ghost, Next.js, Sanity CMS—only content strategy)
8. **Given** a blog specification, **When** reviewing Distribution Requirements, **Then** it defines: Tier 1 (owned: blog, newsletter, YouTube), Tier 2 (amplified: Twitter, LinkedIn, Dev.to), Tier 3 (community: Reddit, HN, Discord)

---

### User Story 4 - Create Editorial Workflow & Technical Plan with `/blogkit.plan` (Priority: P2)

A content lead wants to define HOW they will execute their content strategy (editorial workflow, tech stack, tools, distribution automation). They should be able to create a technical implementation plan that specifies:

- **Editorial Workflow**: 4-pass review process (research → draft → technical review → final edit)
- **Tech Stack**: Publishing platform (e.g., Next.js + MDX, Ghost, WordPress)
- **Tools & Integrations**: Analytics (Plausible, Google Analytics), SEO (Ahrefs), newsletter (ConvertKit)
- **Distribution Automation**: Social scheduling, RSS, cross-posting
- **AI Discoverability**: Structured data, JSON-LD schema, heading hierarchy

**Why this priority**: Bridges the gap between content strategy (spec) and actionable tasks, ensuring clear methodology before execution.

**Independent Test**: Can be tested by running `/blogkit.plan "We're building with Next.js + MDX, using Plausible for analytics, targeting SEO with Ahrefs"` and verifying plan.md contains:
- Editorial workflow with specific roles and timelines
- Tech stack decisions with rationale
- SEO and AI optimization strategy
- Distribution channel implementation details
- NO content topics or blog post outlines (that's in spec.md)

**Acceptance Scenarios**:

1. **Given** a blog specification, **When** user runs `/blogkit.plan` with technical stack preferences, **Then** a plan.md is created with editorial workflow, tech stack, tools, and distribution strategy
2. **Given** a blog plan, **When** reviewing Editorial Workflow section, **Then** it defines 4-pass process with timeline: Research Pass (Week 1), Draft Pass (Week 2), Technical Review Pass (Week 3), Final Edit Pass (Week 4)
3. **Given** a blog plan, **When** reviewing Tech Stack section, **Then** it specifies publishing platform, content management, and hosting with rationale for each choice
4. **Given** a blog plan, **When** reviewing Analytics & Instrumentation section, **Then** it defines tools (e.g., Google Analytics, Plausible), tracked metrics (traffic, engagement, conversions), and reporting cadence
5. **Given** a blog plan, **When** reviewing AI Discoverability section, **Then** it specifies structured data requirements (JSON-LD schema), heading hierarchy (H1 → H2 → H3), FAQ sections, and internal linking strategy
6. **Given** a blog plan, **When** reviewing Distribution Strategy section, **Then** it defines automation for: social media scheduling, newsletter integration, cross-posting (Dev.to, Medium), RSS feeds
7. **Given** a blog plan, **When** checking Constitution Gates, **Then** validation checks blog-specific principles (Content-First, AI-Native Distribution, Simplicity & Focus) not software engineering principles

---

### User Story 5 - Generate Content Production Tasks with `/blogkit.tasks` (Priority: P2)

A content team wants to break down their blog plan into specific, ordered tasks (set up publishing platform, create first 3 posts, configure analytics, launch newsletter). They should be able to generate a task list organized by content sprint.

**Why this priority**: Enables systematic execution of content strategy with clear dependencies and validation checkpoints.

**Independent Test**: Can be tested by running `/blogkit.tasks` after creating spec and plan, and verifying tasks.md contains:
- Sprint-organized tasks (Sprint 1: Foundation Post 1, Sprint 2: Foundation Post 2, etc.)
- Platform setup tasks (deploy blog, configure SEO, integrate analytics)
- Content creation tasks (research, draft, review, publish) for each post
- Distribution tasks (social promotion, newsletter feature, community sharing)
- NO software development tasks (no API creation, no database schema, no backend services)

**Acceptance Scenarios**:

1. **Given** a blog plan, **When** user runs `/blogkit.tasks`, **Then** a tasks.md is created with sprint-organized content production tasks
2. **Given** a tasks file, **When** reviewing Sprint structure, **Then** tasks are grouped by content pillar and post, with explicit dependencies (e.g., "Post 1 published" before "Post 2 research begins")
3. **Given** a tasks file, **When** reviewing Platform Setup phase, **Then** tasks include: deploy publishing platform, configure SEO metadata, integrate analytics, set up newsletter, create social accounts
4. **Given** a tasks file, **When** reviewing Content Creation tasks, **Then** each post has tasks: research & outline, draft, code examples (if applicable), technical review, copyedit, SEO optimization, publish
5. **Given** a tasks file, **When** reviewing Distribution tasks, **Then** each published post has tasks: create social media posts, add to newsletter, share in communities (Reddit, HN, Dev.to), engage with comments
6. **Given** a tasks file, **When** reviewing Validation Checkpoints, **Then** each sprint ends with: analytics review, content quality check, SEO ranking check, audience feedback collection

---

### User Story 6 - Execute Content Strategy with `/blogkit.implement` (Priority: P3)

A content lead wants to execute their content plan systematically (execute tasks in dependency order, validate checkpoints, track progress). They should be able to trigger implementation that:

- Executes tasks in correct order (platform setup → first post → distribution → iterate)
- Respects dependencies (don't publish post before technical review completes)
- Validates quality gates (SEO metadata present, code examples tested, analytics configured)
- Updates progress as work completes

**Why this priority**: Automates execution of content strategy, ensuring systematic implementation with quality control.

**Independent Test**: Can be tested by running `/blogkit.implement` and verifying:
- Tasks execute in dependency order
- Quality gates are checked (SEO metadata validation, broken link detection, readability scoring)
- Progress updates are provided (Sprint 1: 3/5 tasks complete)
- Agent handles file operations (create blog posts, update templates, configure tools)

**Acceptance Scenarios**:

1. **Given** a blog tasks file, **When** user runs `/blogkit.implement`, **Then** agent executes tasks in dependency order (platform setup → content creation → distribution)
2. **Given** implementation in progress, **When** agent completes a post draft, **Then** quality gates validate: SEO metadata present (title, description, Open Graph tags), internal links included (2-3 minimum), code examples tested (if applicable), readability score acceptable
3. **Given** implementation in progress, **When** agent publishes a post, **Then** distribution tasks trigger automatically: social posts created, newsletter updated, community sharing prepared
4. **Given** implementation complete, **When** user reviews final state, **Then** all defined posts are published, analytics are configured and reporting, distribution channels are active, success metrics dashboard is available

---

## Functional Requirements *(mandatory)*

### FR1: Multi-Kit Namespace Isolation *(P0)*

Blog-Tech-Kit MUST coexist with spec-kit and other kit variants without conflicts.

**Requirements**:

1. **CLI Command Separation**: Blog-Tech-Kit uses `blog` command (not `specify`)
   - Package name: `blog-cli` (published to PyPI or installed via git)
   - Command invocation: `blog init`, `blog check`
   - Installation: `uv tool install blog-cli --from git+...`

2. **Slash Command Namespacing**: Agent commands use `/blogkit.*` prefix
   - `/blogkit.constitution` (not `/constitution` or `/speckit.constitution`)
   - `/blogkit.specify`, `/blogkit.clarify`, `/blogkit.plan`, `/blogkit.tasks`, `/blogkit.implement`
   - `/blogkit.checklist`, `/blogkit.analyze`, `/blogkit.taskstoissues`

3. **Shared Working Directory**: All kits use `.specify/` directory structure
   - Rationale: `.specify/` is generic enough for "specification-driven workflows" across domains
   - Path references: Scripts and templates reference `.specify/` (not `.blogkit/`)
   - Constitution location: `.specify/memory/constitution.md` (active kit identified by header comment)

4. **Agent Context File Isolation**: Each kit manages its own agent-specific files
   - Claude Code: `.claude/commands/blogkit.*.md` (vs `.claude/commands/speckit.*.md`)
   - Cursor: `.cursor/rules/blogkit-rules.mdc` (vs `.cursor/rules/specify-rules.mdc`)
   - Windsurf, Qwen, other agents: Similar namespaced files

5. **Active Kit Detection**: When multiple kits installed, active kit determined by:
   - Constitution header comment (e.g., `<!-- AI/LLM SaaS Technical Blog & Twitter Marketing Governance Framework -->`)
   - Agent context files present in `.claude/commands/` (e.g., `blogkit.*.md` vs `speckit.*.md`)
   - CLI invocation choice (`blog init` vs `specify init`)

### FR2: Blog-Specific Constitution & Principles *(P1)*

Blog-Tech-Kit MUST include a constitution adapted for content marketing, not software development.

**Requirements**:

1. **8 Core Principles for Blog Content** (defined in constitution):
   - I. Content-First, Implementation-Second
   - II. Principle-Driven Content Architecture (8 blog principles from refs)
   - III. Test-First for Content Quality (measurable success criteria before execution)
   - IV. AI-Native Content Distribution (optimized for LLM discovery)
   - V. Incremental Content Delivery (staged content rollout)
   - VI. Observability & Measurement (analytics and SEO tracking)
   - VII. Simplicity & Focus (YAGNI for blog infrastructure)
   - VIII. Versioning & Breaking Changes (content strategy evolution)

2. **Blog-Specific Constraints**:
   - Content Strategy Requirements: Blog type, target audience, content pillars, publishing cadence, success metrics
   - Editorial Workflow Standards: 4-pass review process (research → draft → technical review → final edit)
   - Distribution Requirements: SEO optimization, internal linking, social promotion, community sharing
   - Technical Standards: Performance (Lighthouse ≥90), Accessibility (WCAG 2.1 AA), SEO (JSON-LD schema, sitemap.xml, robots.txt), Analytics (privacy-compliant tracking)

3. **Quality Gates for Blog Workflow**:
   - Pre-Clarify Gate: Blog type declared, target audience defined, content pillars identified, success metrics measurable, no tech implementation details
   - Pre-Planning Gate: All [NEEDS CLARIFICATION] markers resolved, specification passes principle alignment, editorial workflow defined
   - Pre-Implementation Gate: Plan includes analytics tools, editorial workflow integrated, distribution strategy defined, technical standards checklist complete
   - Post-Implementation Gate: Technical standards met, analytics configured, first post passing editorial review, distribution channels active

### FR3: Blog-Specific Templates *(P1)*

Blog-Tech-Kit MUST include templates adapted for content strategy, not software development.

**Requirements**:

1. **Content Strategy Template** (`.specify/templates/spec-template.md` for blog-tech-kit):
   - Sections: Blog Type Declaration, Target Audience, Content Pillars, Publishing Cadence, Success Criteria, Distribution Requirements, Assumptions, Constraints & Risks
   - NOT included: Technical architecture, API specs, database schemas, code structure

2. **Editorial Workflow Template** (`.specify/templates/plan-template.md` for blog-tech-kit):
   - Sections: Editorial Process, Tech Stack, Tools & Integrations, AI Discoverability, Distribution Strategy, Analytics & Instrumentation, Constitution Gates
   - NOT included: Code architecture, backend services, deployment pipelines

3. **Content Production Template** (`.specify/templates/tasks-template.md` for blog-tech-kit):
   - Sections: Sprint Organization (by content pillar/post), Platform Setup, Content Creation, Distribution, Validation Checkpoints
   - NOT included: Software development tasks, API integration, database migrations

4. **Blog Post Structure Template** (new, blog-tech-kit specific):
   - Sections: Title & Hook, TLDR/Executive Summary, Background Context, Main Content (H2/H3 hierarchy), Code Examples (if applicable), Results/Evidence, Lessons Learned, Conclusion & CTA, FAQ
   - Best Practices: Problem-first approach, production-grade honesty, structured for AI extraction, internal linking, SEO metadata

### FR4: Blog-Specific Workflow Commands *(P2)*

Blog-Tech-Kit MUST adapt spec-kit slash commands for content marketing workflows.

**Requirements**:

1. **`/blogkit.constitution`**: Create or update blog program governance principles
   - Input: High-level principles, blog strategy philosophy
   - Output: Updated `.specify/memory/constitution.md` with blog-specific principles
   - Validation: Constitution includes 8 Core Blog Principles, Blog-Specific Constraints, Quality Gates

2. **`/blogkit.specify`**: Define content strategy, blog type, success metrics (NO implementation details)
   - Input: Content strategy description (e.g., "Authority blog for AI/LLM developers")
   - Output: `specs/{N}-{feature}/spec.md` with: Blog Type, Target Audience, Content Pillars, Publishing Cadence, Success Criteria, Distribution Requirements
   - Validation: No technology choices present (no CMS, frameworks, hosting platforms)

3. **`/blogkit.clarify`**: Structured Q&A to resolve underspecified requirements
   - Input: Existing specification with [NEEDS CLARIFICATION] markers
   - Output: Updated specification with clarifications documented
   - Max 3 clarification questions, prioritized by impact (scope > security > UX)

4. **`/blogkit.plan`**: Translate content strategy into technical implementation (platform, tools, workflows)
   - Input: Content strategy spec + tech stack preferences
   - Output: `plan.md` with: Editorial Workflow, Tech Stack, Tools, Distribution Strategy, AI Discoverability, Analytics
   - Validation: Includes 4-pass editorial process, analytics tools, SEO/AI optimization strategy

5. **`/blogkit.tasks`**: Generate dependency-ordered task breakdown for content production
   - Input: Implementation plan
   - Output: `tasks.md` with: Sprint Organization, Platform Setup, Content Creation, Distribution, Validation Checkpoints
   - Validation: Tasks grouped by content sprint, dependencies explicit, quality gates defined

6. **`/blogkit.implement`**: Execute tasks to build blog infrastructure and initial content
   - Input: Task list from `tasks.md`
   - Output: Published blog infrastructure, initial draft posts, configured analytics
   - Validation: Quality gates checked (SEO metadata, code examples tested, analytics configured)

7. **`/blogkit.checklist`**: Generate custom quality checklists for content validation
   - Input: Current specification or plan
   - Output: Checklist file with validation items (e.g., SEO optimization checklist, editorial review checklist)

8. **`/blogkit.analyze`**: Cross-artifact consistency & quality analysis
   - Input: Existing spec.md, plan.md, tasks.md
   - Output: Analysis report identifying gaps, inconsistencies, missing validation

9. **`/blogkit.taskstoissues`**: Convert tasks into GitHub issues
   - Input: Existing tasks.md
   - Output: GitHub issues created with dependencies, labels, milestones

### FR5: Reference Documentation & Examples *(P2)*

Blog-Tech-Kit MUST include comprehensive reference docs showing how to apply the methodology.

**Requirements**:

1. **Worked Examples in `refs/` Directory**:
   - `0_overview.md`: Overview of successful AI/LLM SaaS blogs (Anthropic, LangChain, Hugging Face)
   - `1_principles_for_constitution.md`: 8 Core Blog Principles with examples and case studies
   - `2_define_for_specify.md`: Core principles of good blog writing and growth patterns
   - `5_more/blog_principles.md`: Complete constitutional framework (9 parts, 798 lines)
   - `5_more/overview.md`: Comprehensive guide to blog writing (8 sections, 857 lines)

2. **Kit Variant Creation Guide** (Appendix in constitution):
   - How to create new kit variants (pm-kit, pd-kit, marketing-kit, biz-writing-kit)
   - Core reusable elements (namespace strategy, CLI patterns, workflow phases, quality gates)
   - Kit-specific customization examples
   - Multi-kit coexistence testing checklist

3. **Integration Examples**:
   - Claude Code integration (`.claude/commands/blogkit.*.md` files)
   - Cursor integration (`.cursor/rules/blogkit-rules.mdc`)
   - Windsurf, Qwen, other agents (namespace pattern examples)

---

## Success Criteria *(mandatory)*

### SC1: Multi-Kit Coexistence (P0)

**Criteria**:
- Spec-kit and Blog-Tech-Kit can be installed on the same machine without conflicts
- `/speckit.*` and `/blogkit.*` commands both work in same Claude Code session
- `.specify/` directory is shared, but agent context files are isolated
- User can switch between kits using `blog init --here --force` or `specify init --here --force`

**Measurement**:
- Installation test: Both `specify check` and `blog check` succeed
- Command test: `/speckit.plan` and `/blogkit.plan` trigger different workflows
- File test: `.claude/commands/` contains both `speckit.*.md` and `blogkit.*.md` without collision

### SC2: Blog Content Quality (P1)

**Criteria**:
- Blog specifications contain NO implementation details (no CMS, frameworks, hosting)
- Blog plans include 4-pass editorial workflow, SEO/AI optimization, distribution strategy
- Blog tasks are content-focused (research, draft, review, publish) not code-focused
- Generated content passes quality gates (SEO metadata, internal links, AI-extractable structure)

**Measurement**:
- Specification validation: 0 technology choices in spec.md
- Plan validation: Editorial workflow, analytics tools, distribution strategy all present
- Task validation: Content creation tasks present, software development tasks absent
- Content validation: Published posts pass Lighthouse (≥90), WCAG 2.1 AA, JSON-LD schema validation

### SC3: Workflow Adoption (P2)

**Criteria**:
- Users successfully create content strategies using `/blogkit.specify`
- Users generate actionable plans using `/blogkit.plan`
- Users execute content production using `/blogkit.implement`
- Users iterate and improve based on analytics and feedback

**Measurement**:
- Adoption: 10+ projects using Blog-Tech-Kit workflow (spec → plan → tasks → implement)
- Completion: 80%+ of initiated projects complete at least 3 posts
- Quality: 70%+ of published posts achieve target success metrics (traffic, engagement, SEO rankings)
- Iteration: 50%+ of projects update constitution or templates based on learnings

### SC4: Reference Implementation Value (P2)

**Criteria**:
- Blog-Tech-Kit serves as clear reference for creating other kit variants
- At least 2 other kit variants (pm-kit, pd-kit, marketing-kit) successfully created using Blog-Tech-Kit as template
- Multi-kit coexistence testing confirms all variants work together
- Community feedback validates architecture decisions

**Measurement**:
- Derivative kits: 2+ new kit variants created following Blog-Tech-Kit patterns
- Coexistence: All kits pass multi-kit installation and command isolation tests
- Documentation: Kit Variant Creation Guide cited by 80%+ of variant creators
- Feedback: Architecture patterns validated by community (GitHub discussions, issues)

---

## Assumptions *(mandatory)*

1. **Spec-Kit Foundation**: Users are familiar with spec-driven development methodology (constitution → specify → plan → tasks → implement workflow)
2. **AI Agent Access**: Users have access to Claude Code, Cursor, or other supported coding agents with slash command support
3. **Blog Literacy**: Users understand basic blogging concepts (SEO, analytics, distribution channels) even if they're not content marketing experts
4. **Git Workflow**: Users are comfortable with Git branching, commits, and pull requests for version control
5. **Python Environment**: Users have Python 3.11+ and `uv` installed for package management
6. **AI/LLM Context**: Blog-Tech-Kit focuses on AI/LLM SaaS products specifically (not general SaaS or non-AI products)

---

## Out of Scope *(mandatory)*

### Explicitly NOT Included:

1. **Content Writing Automation**: Blog-Tech-Kit provides templates and workflows, but does NOT automatically generate blog posts. Users must write content (with AI assistance if desired).
2. **Hosting & Deployment**: Blog-Tech-Kit defines tech stack in plans, but does NOT automate hosting setup or deployment pipelines.
3. **Paid Marketing**: Blog-Tech-Kit focuses on organic content marketing (blogging, Twitter, SEO). Paid ads, sponsored content, and paid distribution channels are out of scope.
4. **Social Media Management**: Blog-Tech-Kit defines distribution strategy, but does NOT include social media scheduling, automation, or analytics tools.
5. **Email Marketing Platforms**: Blog-Tech-Kit references newsletters in distribution strategy, but does NOT integrate with or manage ConvertKit, Substack, or other email platforms.
6. **SEO Tool Integration**: Blog-Tech-Kit defines SEO requirements, but does NOT integrate with Ahrefs, SEMrush, or other SEO tools.
7. **Analytics Platforms**: Blog-Tech-Kit specifies analytics requirements, but does NOT integrate with Google Analytics, Plausible, or other analytics platforms.
8. **Non-AI Products**: Blog-Tech-Kit is optimized for AI/LLM SaaS products. Adapting for non-AI SaaS or physical products requires customization.

---

## Constraints & Risks *(mandatory)*

### Technical Constraints:

1. **Agent Support Limitation**: Blog-Tech-Kit requires coding agents with slash command support. CLI-only workflows are not supported.
2. **Python 3.11+ Requirement**: Blog-Tech-Kit CLI uses modern Python features. Older Python versions are not supported.
3. **Git Dependency**: Feature branching workflow assumes Git repository. Non-Git version control systems are not supported.
4. **uv Requirement**: Package management assumes `uv` tool. Alternative Python package managers require manual setup.

### Business Constraints:

1. **AI/LLM Focus**: Templates and examples assume AI/LLM SaaS context. Non-AI products need template customization.
2. **Content Team Capacity**: Blog-Tech-Kit assumes team can dedicate 10-20 hours/week to content production. Smaller time commitments may require adjusted cadence.
3. **Long-Term Commitment**: Authority blogging compounds over 6-12 months. Teams expecting immediate ROI may be disappointed.

### Risks & Mitigations:

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|-----------|
| **Multi-kit namespace collisions** | HIGH (blocks adoption) | MEDIUM | Rigorous testing of spec-kit + blog-tech-kit + pm-kit coexistence; clear namespace strategy documented |
| **Template quality insufficient** | MEDIUM (poor content quality) | MEDIUM | Use refs as source of truth; validate templates against successful examples (Anthropic, LangChain); iterate based on user feedback |
| **Users expect content generation** | MEDIUM (unmet expectations) | HIGH | Clear documentation that Blog-Tech-Kit provides structure, not automated content generation |
| **SEO/Analytics integration gaps** | LOW (manual workarounds exist) | MEDIUM | Provide clear integration guides for common tools (Google Analytics, Plausible, Ahrefs); future versions may add integrations |
| **Agent compatibility issues** | MEDIUM (limits adoption) | LOW | Test with Claude Code, Cursor, Windsurf; provide fallback CLI-only workflows if needed |

---

## Dependencies *(mandatory)*

### Internal Dependencies:

1. **Spec-Kit Core**: Blog-Tech-Kit inherits workflow patterns from spec-kit (constitution → specify → plan → tasks → implement)
2. **Constitution Framework**: Blog-specific principles build on spec-kit governance model
3. **CLI Architecture**: Blog-Tech-Kit CLI follows same patterns as `specify-cli` for consistency

### External Dependencies:

1. **Python Ecosystem**: Python 3.11+, `uv` package manager, `typer` CLI framework, `rich` terminal formatting
2. **Git**: Version control for feature branching and collaboration
3. **Coding Agents**: Claude Code, Cursor, Windsurf, or other agents with slash command support
4. **Reference Sources**: Blogs from Anthropic, OpenAI, LangChain, Hugging Face, Together AI used as examples

### Optional Dependencies:

1. **Publishing Platforms**: Next.js, Ghost, WordPress (user choice, defined in plan)
2. **Analytics Tools**: Google Analytics, Plausible (user choice, defined in plan)
3. **SEO Tools**: Ahrefs, SEMrush (user choice, optional)
4. **Newsletter Platforms**: ConvertKit, Substack (user choice, defined in distribution strategy)

---

## Key Entities *(if applicable)*

### Content Strategy (Spec Phase):

```
ContentStrategy:
  - blog_type: "Authority" | "Practitioner" | "Community" | "Thought Leadership"
  - target_audience: AudiencePersona
  - content_pillars: List[ContentPillar] (3-5)
  - publishing_cadence: PublishingCadence
  - success_metrics: SuccessMetrics
  - distribution_requirements: DistributionStrategy

AudiencePersona:
  - role_title: string (e.g., "Senior ML Engineer")
  - skill_level: "beginner" | "intermediate" | "advanced"
  - company_context: string (e.g., "Series A-C AI startups")
  - tool_stack: List[string] (e.g., ["Python", "LangChain", "OpenAI API"])
  - pain_points: List[string]
  - reading_preferences: string (e.g., "code-heavy tutorials, case studies")

ContentPillar:
  - pillar_name: string (e.g., "Context Engineering")
  - credibility_reason: string (why your team can write authoritatively)
  - target_keywords: List[string]
  - example_post_titles: List[string]
  - product_alignment: string (how pillar supports product value)

PublishingCadence:
  - frequency: string (e.g., "1-2 posts/quarter", "2-4 posts/month")
  - team_capacity: string (hours/week dedicated to content)
  - rationale: string (why this cadence is realistic)

SuccessMetrics:
  - leading_indicators: List[Metric] (Month 1-3)
  - lagging_indicators: List[Metric] (Month 6-12)
  - year_one_targets: YearOneTargets

Metric:
  - name: string (e.g., "Organic traffic to posts")
  - target_value: string (e.g., "50K+ monthly")
  - measurement_tool: string (e.g., "Google Analytics")
  - review_frequency: "weekly" | "monthly" | "quarterly"

DistributionStrategy:
  - tier_1_owned: List[Channel] (blog, newsletter, YouTube)
  - tier_2_amplified: List[Channel] (Twitter, LinkedIn, Dev.to)
  - tier_3_community: List[Channel] (Reddit, HN, Discord)
```

### Editorial Workflow (Plan Phase):

```
EditorialWorkflow:
  - research_pass: WorkflowPass (Week 1)
  - draft_pass: WorkflowPass (Week 2)
  - technical_review_pass: WorkflowPass (Week 3)
  - final_edit_pass: WorkflowPass (Week 4)

WorkflowPass:
  - pass_name: string
  - duration: string (e.g., "Week 1")
  - responsibilities: List[string]
  - quality_gates: List[QualityGate]
  - output_artifacts: List[string]

TechStack:
  - publishing_platform: string (e.g., "Next.js + MDX", "Ghost", "WordPress")
  - content_management: string (e.g., "GitHub", "Notion")
  - hosting: string (e.g., "Vercel", "Netlify", "WordPress.com")
  - rationale: string (why these choices)

AnalyticsInstrumentation:
  - analytics_tool: string (e.g., "Google Analytics", "Plausible")
  - tracked_metrics: List[string]
  - reporting_cadence: "weekly" | "monthly" | "quarterly"
  - dashboard_url: string (optional)
```

### Content Production (Tasks Phase):

```
ContentSprint:
  - sprint_number: int
  - content_pillar: string
  - post_title: string
  - tasks: List[ContentTask]
  - dependencies: List[string] (task IDs this sprint depends on)
  - validation_checkpoint: ValidationCheckpoint

ContentTask:
  - task_id: string
  - task_type: "research" | "draft" | "review" | "publish" | "distribute"
  - description: string
  - duration_estimate: string (e.g., "1 week")
  - assignee: string (optional)
  - dependencies: List[string] (task IDs)
  - quality_gates: List[QualityGate]

QualityGate:
  - gate_name: string (e.g., "SEO metadata present")
  - validation_method: string (e.g., "Manual check", "Automated script")
  - pass_criteria: string
  - blocker: bool (if true, must pass before proceeding)
```

---

## Review & Acceptance Checklist *(mandatory)*

### Specification Quality:

- [x] Blog type explicitly declared (Authority, Practitioner, Community, Thought Leadership)
- [x] Target audience persona documented with specific use cases and pain points
- [x] 3-5 content pillars align with product value and developer needs
- [x] Publishing cadence realistic for team size and blog type
- [x] Success metrics measurable and blog-type-appropriate (at least 3 metrics)
- [x] No implementation details leak into specification (CMS, frameworks, hosting)
- [x] Editorial workflow defined (4-pass process or equivalent)
- [x] Distribution strategy includes Tier 1 + Tier 2 channels
- [x] All [NEEDS CLARIFICATION] markers resolved or explicitly deferred with rationale
- [x] Content pillars address problems first, not technologies

### Multi-Kit Architecture:

- [x] CLI command separation strategy defined (`blog` vs `specify` vs `pm`)
- [x] Slash command namespacing strategy defined (`/blogkit.*` vs `/speckit.*`)
- [x] Shared working directory strategy defined (`.specify/` for all kits)
- [x] Agent context file isolation strategy defined (`.claude/commands/blogkit.*` vs `speckit.*`)
- [x] Active kit detection mechanism defined (constitution header, CLI invocation)
- [x] Kit switching process defined (`blog init --here --force`)

### Constitutional Alignment:

- [x] 8 Core Blog Principles documented and aligned with refs
- [x] Blog-Specific Constraints documented (content strategy, editorial, distribution, technical)
- [x] Quality Gates defined for each workflow phase
- [x] Governance model adapted from spec-kit (authority, amendments, conflict resolution)
- [x] Kit Variant Creation Guide included for future variants

### Implementation Readiness:

- [x] Templates identified (content strategy, editorial workflow, content production, blog post structure)
- [x] Slash commands specified with inputs/outputs/validation
- [x] Reference documentation mapped (`refs/` directory structure)
- [x] Success criteria measurable and testable
- [x] Risks identified with mitigations
- [x] Dependencies documented (internal, external, optional)

---

**Next Steps**:

1. **Pre-Planning**: Run `/blogkit.clarify` to resolve any remaining ambiguities before technical planning
2. **Planning**: Run `/blogkit.plan` to define tech stack, editorial workflow, and tools
3. **Task Breakdown**: Run `/blogkit.tasks` to generate actionable task list
4. **Implementation**: Run `/blogkit.implement` to execute blog infrastructure setup and content production

---

*This specification follows the Blog-Tech-Kit constitution principles: Content-First, AI-Native Distribution, Test-First for Content Quality. It defines WHAT and WHY before HOW, ensuring clear strategy before technical execution.*
