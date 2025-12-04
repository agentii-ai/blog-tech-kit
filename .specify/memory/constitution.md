# Blog-Tech-Kit Constitution
<!-- AI/LLM SaaS Technical Blog & Twitter Marketing Governance Framework -->

**Version**: 1.0.0 | **Ratified**: 2025-12-04 | **Last Amended**: 2025-12-04

---

## Preamble: Multi-Kit Architecture & Coexistence Strategy

This constitution governs **blog-tech-kit**, a specialized variant of the spec-kit framework focused on Twitter marketing and technical blog growth for AI SaaS products. Blog-tech-kit demonstrates how to create domain-specific kit variants while maintaining full compatibility with the original spec-kit and future variants (pm-kit, pd-kit, marketing-kit, biz-writing-kit).

### Namespace Design for Multi-Kit Coexistence

**Challenge**: Users may install multiple kit variants on the same machine. Each variant must operate independently without namespace collisions or command conflicts.

**Solution Architecture**:

#### 1. CLI Command Separation Strategy

Each kit variant uses a **unique CLI command name** to avoid binary/command collisions:

- **spec-kit**: Package `specify-cli` → Command `specify`
- **blog-tech-kit**: Package `blog-cli` → Command `blog`
- **pm-kit**: Package `pm-cli` → Command `pm`
- **pd-kit**: Package `pd-cli` → Command `pd`

**Installation Pattern**:
```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
uv tool install blog-cli --from git+https://github.com/[org]/blog-tech-kit.git
uv tool install pm-cli --from git+https://github.com/[org]/pm-kit.git
```

Each command operates independently. Users invoke `specify init`, `blog init`, or `pm init` without conflict.

#### 2. Working Directory Structure (Per-Project)

**CRITICAL DISTINCTION**: Within a project, all kits share the `.specify/` working directory structure for consistency with spec-driven development patterns.

```
project-root/
├── .specify/              # Shared working directory (used by all kits)
│   ├── memory/
│   │   └── constitution.md    # Active constitution (spec-kit or blog-kit or pm-kit)
│   ├── scripts/           # Shared utility scripts
│   ├── templates/         # Templates (spec/plan/tasks)
├── .claude/               # Agent context (managed by active kit)
│   └── commands/
│       ├── speckit.*.md   # spec-kit commands
│       ├── blogkit.*.md   # blog-kit commands (when active)
│       └── pmkit.*.md     # pm-kit commands (when active)
├── specs/                 # Feature specifications (shared across kits)
├── .cursor/               # Cursor agent rules (kit-specific namespacing)
├── .windsurf/             # Windsurf agent rules (kit-specific namespacing)
```

**Rationale**:
- The `.specify/` directory name is **generic** enough to represent "specification-driven workflows" regardless of domain (software, blog content, product design, etc.)
- Changing to `.blogkit/` or `.pmkit/` would break the abstraction and create unnecessary duplication
- All kits follow the same workflow: constitution → specify → clarify → plan → tasks → implement
- Sharing `.specify/` enables hybrid workflows (e.g., using spec-kit for code + blog-kit for content in the same project)

#### 3. Slash Command Namespacing (Agent Integration)

Agent slash commands use **kit-specific prefixes** to avoid collision:

- **spec-kit**: `/speckit.constitution`, `/speckit.specify`, `/speckit.plan`, `/speckit.tasks`, `/speckit.implement`
- **blog-tech-kit**: `/blogkit.constitution`, `/blogkit.specify`, `/blogkit.plan`, `/blogkit.tasks`, `/blogkit.implement`
- **pm-kit**: `/pmkit.constitution`, `/pmkit.specify`, `/pmkit.plan`, `/pmkit.tasks`, `/pmkit.implement`

**Pattern**: `/<kitname>.<command>` ensures each kit variant has isolated command namespaces.

**Implementation**:
- Claude Code: `.claude/commands/blogkit.constitution.md` vs `.claude/commands/speckit.constitution.md`
- Cursor: `.cursor/rules/blogkit-rules.mdc` vs `.cursor/rules/specify-rules.mdc`
- Each kit's CLI (`blog init`, `specify init`) installs its own slash command files

#### 4. Script & Template Path References

**Key Principle**: Scripts and templates reference `.specify/` paths (not `.blogkit/` or `.pmkit/`), maintaining portability across kit variants.

Example from a blogkit script:
```bash
TEMPLATE="$REPO_ROOT/.specify/templates/plan-template.md"
CONSTITUTION="$REPO_ROOT/.specify/memory/constitution.md"
```

**Rationale**: All kits share the same workflow structure. Path consistency enables script reuse and reduces maintenance burden.

#### 5. Package Naming & Version Independence

- **PyPI Package Names**: Unique per kit (`blog-cli`, `specify-cli`, `pm-cli`)
- **Version Independence**: Each kit can be upgraded independently
- **Dependency Management**: Kits do not depend on each other; they are parallel implementations of the same workflow pattern

### Active Kit Detection

When a project has multiple kit variants installed, the **active kit** is determined by:

1. **Constitution Header**: The constitution file includes a kit identifier (e.g., `<!-- AI/LLM SaaS Technical Blog & Twitter Marketing Governance Framework -->`)
2. **Agent Context Files**: Slash commands in `.claude/commands/` indicate which kit is active
3. **CLI Invocation**: The user explicitly chooses which kit to use (`blog plan` vs `specify plan`)

**Switching Kits**: To switch from spec-kit to blog-kit in an existing project:
1. Run `blog init --here --force` to overlay blog-kit templates and commands
2. Update `.specify/memory/constitution.md` with blog-kit constitution
3. Verify `.claude/commands/blogkit.*.md` files are present

---

## Core Principles

### I. Content-First, Implementation-Second

**Principle**: Every blog specification begins with **content strategy, audience needs, and distribution goals**—never with the implementation stack (CMS, frameworks, hosting).

**Rationale**: Technical blog success depends on resonance with developer audiences, not the sophistication of the publishing infrastructure. The "what" and "why" of content must be established before "how" it's published.

**Application**:
- **Specifications** describe blog goals, target audience, content themes, and success metrics
- **Plans** translate content strategy into implementation architecture
- **Tasks** execute the plan with specific technologies

**Violations**:
- ❌ "Build a blog using Next.js and Sanity CMS"
- ✅ "Create an authority blog targeting AI/LLM developers with production-grade agent patterns"

**Test**: If a specification mentions technology (React, WordPress, Ghost), it fails this principle.

### II. Principle-Driven Content Architecture

**Principle**: All blog content must align with the **8 Core Blog Principles** from `refs/1_principles_for_constitution.md`:

1. **Problem-First, Not Technology-First**: Posts begin with concrete problems, not solutions
2. **Production-Grade Honesty Over Perfection**: Share what works (and fails) in production
3. **Earned Authority Through Pattern Libraries**: Become canonical source for category patterns
4. **Developer-First, Not Sales-First**: Education builds trust; business value follows
5. **Content Architecture for AI & Human Discovery**: Structure for both human readers and LLM systems
6. **Consistency Over Perfection**: Quality posts compound over time
7. **Thought Leadership = Transparency + Specificity**: Show your work with extreme specificity
8. **Link Equity & Topic Authority**: Build content clusters, not isolated posts

**Application**:
- Every specification must identify which **blog type** is being built: **Authority**, **Practitioner**, **Community**, or **Thought Leadership**
- Plans must define content calendar strategy based on chosen blog type
- Success metrics must align with blog type (citations for Authority, developer CAC for Practitioner, etc.)

**Governance**:
- All specifications undergo **principle alignment validation** before planning phase
- Content that violates principles (e.g., feature dumps, sales-first positioning) must be rejected or reframed

**Test**: Specifications include a "Blog Type Declaration" section that explicitly states the blog type and how content aligns with the corresponding principles.

### III. Test-First for Content Quality (NON-NEGOTIABLE)

**Principle**: Before implementing any blog infrastructure or content production workflow, define **measurable success criteria** and **content quality tests**.

**Rationale**: Blog content quality is testable through engagement metrics, SEO rankings, citation counts, and conversion rates. Defining tests first ensures content delivers measurable value.

**Application**:
- **Specifications** define success metrics (e.g., "50K+ monthly organic traffic by Month 12")
- **Plans** include content quality gates (editorial review process, technical accuracy validation)
- **Tasks** implement automated checks where possible (SEO metadata validation, broken link detection, readability scoring)
- **Implementation** cannot proceed without documented success criteria

**Quality Tests Include**:
- Content passes editorial **4-pass review process** (research → draft → technical review → final edit)
- All code examples are tested and functional
- SEO metadata (title, description, Open Graph) present and optimized
- Internal linking strategy connects to content clusters
- Technical accuracy validated by domain expert

**Test**: Every specification includes a "Success Criteria" section with at least 3 measurable outcomes. Every plan includes a "Quality Gates" section defining editorial workflow checkpoints.

### IV. AI-Native Content Distribution

**Principle**: Content must be optimized for discovery by both human readers and AI systems (ChatGPT, Perplexity, Google AI Overviews, Claude).

**Rationale**: In 2024-2025, AI systems are primary discovery and citation channels. Content that AI can extract, understand, and cite achieves wider reach and sustained authority.

**Application**:
- All blog posts include structured metadata (JSON-LD schema)
- Content uses clear heading hierarchy (H1 → H2 → H3) for extraction
- Code examples include language tags and complete context
- Key concepts are explicitly defined and linked to glossary/pattern library
- Summary sections enable AI systems to extract concise answers

**Examples**:
- ✅ "Problem: Agent responses lack context → Solution: Prompt templates with variable injection → Code example → Results"
- ❌ "Check out our new feature that makes agents better!"

**Test**: Plans must include an "AI Discoverability" section describing how content will be structured for LLM extraction and citation.

### V. Incremental Content Delivery

**Principle**: Blog programs build authority through **consistent, staged content delivery**, not one-shot launches.

**Rationale**: Authority blogs compound over time. A content cluster (8-12 related posts) maintains SEO rankings and citation equity far longer than isolated posts.

**Application**:
- **Months 1-3**: Foundation phase (3-5 authoritative posts on core problems)
- **Months 4-6**: Expansion phase (practitioner guides with code examples)
- **Months 7-12**: Authority phase (original research, content clusters, community features)

**Task Execution**:
- Content production is broken into sprints (2-4 weeks per post)
- Each sprint includes research → draft → review → publish → promote
- Parallel execution allowed only for independent content tracks (e.g., different blog types)

**Test**: Task breakdowns include explicit sprint phases with milestone markers (e.g., "Sprint 1: Foundation Post 1 - Research & Draft").

### VI. Observability & Measurement

**Principle**: Every blog initiative must include instrumentation for success metrics, engagement analytics, and SEO performance tracking.

**Rationale**: "You can't improve what you don't measure." Blog success requires continuous monitoring of traffic, engagement, conversions, and authority metrics.

**Application**:
- All implementations include analytics setup (Google Analytics, Plausible, or equivalent)
- SEO tracking configured for target keywords and ranking positions
- Conversion tracking for CTAs (newsletter signups, demo requests, SDK downloads)
- Monthly reporting dashboard for stakeholder visibility

**Metrics by Blog Type**:
- **Authority Blogs**: Citations, keyword rankings, backlink profile growth (6-12 month horizon)
- **Practitioner Blogs**: Developer CAC, tutorial completion rates, SDK adoption (1-3 month horizon)
- **Community Blogs**: Contributor count, community engagement (comments, shares)
- **Thought Leadership**: Speaking invitations, media mentions, advisor roles

**Test**: Plans include an "Analytics & Instrumentation" section defining tools, metrics, and reporting cadence.

### VII. Simplicity & Focus

**Principle**: Start simple. Build only what's needed for the chosen blog type and strategy. Avoid over-engineering infrastructure or content workflows.

**Rationale**: Blog success comes from content quality and consistency, not technical sophistication. Complex CMSs, custom publishing pipelines, and premature optimization create maintenance burden without commensurate value.

**Application**:
- Use proven platforms (WordPress, Ghost, Next.js + MDX) rather than custom solutions
- Prioritize editorial workflow over technical features
- Implement only necessary integrations (analytics, SEO tools, distribution channels)
- Defer advanced features (multilingual support, video hosting, community platforms) until core blog proven

**YAGNI Examples**:
- ❌ Custom CMS with headless architecture before publishing 10 posts
- ❌ Advanced personalization engine before reaching 10K monthly visitors
- ✅ Static site generator (Hugo, Next.js) with markdown files for Month 1 launch
- ✅ Add CMS when editorial team exceeds 3 contributors

**Test**: Plans undergo "Complexity Review" - any feature not directly supporting the first 10 posts must be explicitly justified or deferred.

### VIII. Versioning & Breaking Changes

**Principle**: Content strategy, editorial guidelines, and publishing infrastructure must be versioned. Breaking changes to content architecture or workflows require migration plans.

**Rationale**: Blog programs evolve over time (content strategy pivots, platform migrations, editorial process changes). Versioned governance ensures continuity and prevents disruption.

**Application**:
- Constitution uses semantic versioning (MAJOR.MINOR.PATCH)
- Content strategy documents include version history
- Platform migrations documented with rollback plans
- Editorial guideline changes communicated to all contributors

**Version Bumps**:
- **MAJOR**: Blog type change (Authority → Practitioner), platform migration (WordPress → Next.js)
- **MINOR**: New content pillar added, editorial process changes (3-pass → 4-pass review)
- **PATCH**: Guideline clarifications, SEO metadata standards updates

**Test**: Constitution updates include a "Sync Impact Report" documenting version change rationale and affected templates.

---

## Blog-Specific Constraints

### Content Strategy Requirements

Every blog initiative must define:

1. **Blog Type**: Authority, Practitioner, Community, or Thought Leadership
2. **Target Audience**: Specific developer persona (e.g., "Senior ML Engineers building production LLM systems")
3. **Content Pillars**: 3-5 core themes aligned with product value (e.g., "Context Engineering," "Production Debugging," "Multi-Agent Orchestration")
4. **Publishing Cadence**: Realistic frequency based on blog type and team capacity
   - Authority: 1-2 posts/quarter (deep research, original insights)
   - Practitioner: 2-4 posts/month (tutorials, guides, patterns)
   - Community: 4-8 posts/month (contributor features, case studies)
   - Thought Leadership: 1-2 posts/month (executive perspective, industry analysis)
5. **Success Metrics**: Measurable outcomes aligned with blog type (see Principle VI)

### Editorial Workflow Standards

All blog content follows a **4-pass editorial process**:

1. **Research Pass** (Week 1): Topic research, outline creation, source validation, keyword research
2. **Draft Pass** (Week 2): Full draft with code examples, diagrams, citations, and internal links
3. **Technical Review Pass** (Week 3): Domain expert validates accuracy, tests code examples, verifies claims
4. **Final Edit Pass** (Week 4): Copyediting, SEO optimization, metadata completion, image optimization

**Timeline**:
- Authority/Practitioner posts: 4 weeks from research to publication
- Community/Thought Leadership posts: 2 weeks (less technical validation needed)

**Quality Gates**:
- Draft must include at least 3 internal links to related content
- Code examples must be tested in a clean environment
- SEO metadata must target a primary keyword with < 5,000 monthly search volume (low competition)
- Technical review must be completed by someone other than the author

### Distribution Requirements

Every published post must include:

- **SEO Optimization**: Target keyword, meta description (150-160 chars), Open Graph tags, Twitter Card metadata
- **Internal Linking**: Minimum 2-3 links to related content (builds topic authority and SEO equity)
- **Promotion Plan**:
  - Social media posts (Twitter/X thread, LinkedIn post)
  - Newsletter feature (excerpt + CTA)
  - Community sharing (Reddit, Hacker News if applicable, Dev.to cross-post)
- **Citation Preparation**: Permanent URL, clear licensing (Creative Commons or All Rights Reserved), author attribution, canonical URL tags

**Hacker News Strategy** (for Authority/Practitioner posts):
- Post as "Show HN" on Tue/Wed/Thu between 7-9 AM EST
- Title format: "Show HN: [Problem] – [Approach/Result]"
- Engage with comments within first 2 hours
- Target: 3,000-5,000 targeted visitors per successful HN post

### Technical Standards

Blog implementations must meet:

- **Performance**: Lighthouse score ≥90 (mobile and desktop), Core Web Vitals pass
- **Accessibility**: WCAG 2.1 AA compliance minimum (semantic HTML, alt text, keyboard navigation)
- **SEO**: Valid structured data (JSON-LD Article schema), sitemap.xml, robots.txt, OpenGraph + Twitter Card tags
- **Analytics**: Privacy-compliant tracking (GDPR/CCPA), cookie consent if required
- **Security**: HTTPS enforced, CSP headers, dependency scanning, XSS protection

---

## Development Workflow

### Slash Command Workflow

The blog-tech-kit workflow follows the spec-driven development pattern with blog-specific adaptations:

1. **`/blogkit.constitution`**: Establish or update blog program governance principles
   - Input: High-level principles, blog strategy philosophy
   - Output: Updated `.specify/memory/constitution.md`

2. **`/blogkit.specify`**: Define content strategy, blog type, success metrics (no implementation details)
   - Input: Blog goals, target audience, content themes, success metrics
   - Output: `specs/{N}-{feature}/spec.md` with content strategy

3. **`/blogkit.clarify`**: Structured Q&A to resolve underspecified requirements (optional but recommended)
   - Input: Existing specification with [NEEDS CLARIFICATION] markers
   - Output: Updated specification with clarifications documented

4. **`/blogkit.plan`**: Translate content strategy into technical implementation (platform, tools, workflows)
   - Input: Content strategy specification, tech stack preferences
   - Output: `plan.md`, `research.md`, `data-model.md` (if applicable)

5. **`/blogkit.tasks`**: Generate dependency-ordered task breakdown for implementation
   - Input: Implementation plan
   - Output: `tasks.md` with sprint-organized task list

6. **`/blogkit.implement`**: Execute tasks to build blog infrastructure and initial content
   - Input: Task list
   - Output: Working blog infrastructure, first draft posts

### Quality Gates

Before advancing to next phase:

- **Pre-Clarify Gate** (after `/blogkit.specify`):
  - ✅ Blog type explicitly declared
  - ✅ Target audience defined with specific persona
  - ✅ 3-5 content pillars identified
  - ✅ Success metrics include at least 3 measurable outcomes
  - ✅ No technology implementation details present

- **Pre-Planning Gate** (after `/blogkit.clarify`):
  - ✅ All [NEEDS CLARIFICATION] markers resolved
  - ✅ Specification passes principle alignment validation (Principle II)
  - ✅ Editorial workflow defined (4-pass or equivalent)

- **Pre-Implementation Gate** (after `/blogkit.plan`):
  - ✅ Plan includes success metrics tracking tools (analytics, SEO)
  - ✅ Editorial workflow integrated into task breakdown
  - ✅ Distribution strategy includes Tier 1 + Tier 2 channels
  - ✅ Technical standards checklist completed

- **Post-Implementation Gate** (after `/blogkit.implement`):
  - ✅ All technical standards met (performance, accessibility, SEO)
  - ✅ Analytics configured and tested
  - ✅ First post drafted and passing editorial 4-pass review
  - ✅ Distribution channels activated (social, newsletter, RSS)

### Review & Acceptance Checklist

Every specification undergoes validation against this checklist:

- [ ] Blog type explicitly defined (Authority, Practitioner, Community, Thought Leadership)
- [ ] Target audience persona documented with specific use cases and pain points
- [ ] 3-5 content pillars align with product value and developer needs
- [ ] Publishing cadence realistic for team size and blog type
- [ ] Success metrics measurable and blog-type-appropriate (at least 3 metrics)
- [ ] No implementation details leak into specification (CMS, frameworks, hosting)
- [ ] Editorial workflow defined (4-pass process or equivalent)
- [ ] Distribution strategy includes Tier 1 + Tier 2 channels
- [ ] All [NEEDS CLARIFICATION] markers resolved (max 3 total)
- [ ] Content pillars address problems first, not technologies

---

## Governance

### Authority & Amendments

1. **Constitution Authority**: This document supersedes all other guidelines, templates, and ad-hoc decisions for blog-tech-kit projects
2. **Amendment Process**:
   - Propose change with rationale and impact analysis
   - Version bump according to semantic versioning rules (Principle VIII)
   - Update dependent templates and scripts (propagation checklist)
   - Document in Sync Impact Report (HTML comment at top of constitution)
3. **Compliance Review**: All specifications, plans, and implementations must demonstrate alignment with constitution principles

### Conflict Resolution

When principles conflict, apply this priority hierarchy:

1. **Content Quality > Speed**: Principle III (Test-First) takes precedence over aggressive timelines
2. **Simplicity > Features**: Principle VII (Simplicity) overrides premature optimization
3. **Consistency > Perfection**: Principle II (Consistency Over Perfection) prioritizes sustainable publishing over one-off viral attempts
4. **Developer-First > Sales-First**: Principle II.4 (Developer-First) overrides business pressure for promotional content

### Exception Handling

Exceptions to principles require:

- **Written Justification**: Specific rationale with risk assessment
- **Documented Alternatives**: What was considered and why rejected
- **Approval**: Project owner or editorial lead sign-off
- **Temporary Waiver**: Expiration date (max 3 months) with re-evaluation plan
- **Retrospective**: Post-mortem after exception expires to evaluate impact

**Common Exception Scenarios**:
- Time-sensitive blog post (conference announcement, product launch) bypassing 4-pass editorial process
- Platform migration under deadline pressure skipping rollback plan documentation
- One-off viral content attempt violating "Consistency Over Perfection" principle

### Continuous Improvement

- **Quarterly Review**: Revisit constitution to reflect learnings, strategy pivots, market changes
- **Retrospectives**: After each content milestone (10 posts, 50K traffic, first citation, first conversion), evaluate what worked and update principles if needed
- **Community Feedback**: Solicit input from editorial team, contributors, and audience about content quality and relevance
- **Competitive Analysis**: Monitor successful AI/LLM blogs quarterly to validate or challenge current principles

---

## Appendix: Kit Variant Creation Guide

This constitution serves as a **reference implementation** for creating your own kit variants (pm-kit, pd-kit, marketing-kit, biz-writing-kit). When adapting this template:

### Core Reusable Elements

1. **Namespace Strategy**:
   - Use `<kitname>.` prefix for slash commands (e.g., `/pmkit.specify`)
   - Share `.specify/` working directory across all kits
   - Use unique CLI command per kit (`pm`, `pd`, `blog`, `specify`)

2. **CLI Command Pattern**:
   - Package naming: `<kit>-cli` (e.g., `pm-cli`)
   - Command invocation: `<kit>` (e.g., `pm init`)
   - Installation: `uv tool install <kit>-cli --from git+...`

3. **Workflow Phases**: All kits follow the same 6-phase workflow:
   - constitution → specify → clarify → plan → tasks → implement

4. **Quality Gates**:
   - Test-first approach (define success criteria before implementation)
   - Validation checklists (pre-planning, pre-implementation, post-implementation)
   - Principle alignment validation (content-first, simplicity, versioning)

### Kit-Specific Customization

1. **Core Principles**: Replace blog-specific principles with domain-appropriate principles
   - **PM-Kit**: User story quality, stakeholder alignment, roadmap prioritization, backlog refinement
   - **PD-Kit**: Design system consistency, user research validation, accessibility standards, design critique
   - **Marketing-Kit**: Campaign-market fit, channel optimization, conversion tracking, brand consistency
   - **Biz-Writing-Kit**: Clarity over jargon, stakeholder awareness, evidence-based claims, revision discipline

2. **Validation Criteria**: Define domain-specific quality tests
   - Blog-Kit → SEO optimization, citation-readiness, AI discoverability
   - PM-Kit → Backlog refinement, story point estimation, dependency mapping
   - PD-Kit → Design system compliance, accessibility audit, user research validation

3. **Success Metrics**: Adapt to domain outcomes
   - Blog-Kit → Traffic, citations, developer CAC, content cluster authority
   - PM-Kit → Feature adoption, velocity stability, stakeholder satisfaction, sprint predictability
   - PD-Kit → User satisfaction (NPS), task completion rate, accessibility compliance, design debt reduction

### Multi-Kit Coexistence Testing

Before releasing a new kit variant, validate multi-kit coexistence:

1. **Install Alongside Existing Kits**:
   ```bash
   uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
   uv tool install blog-cli --from git+https://github.com/[org]/blog-tech-kit.git
   uv tool install pm-cli --from git+https://github.com/[org]/pm-kit.git
   ```

2. **Verify No CLI Command Conflicts**:
   - Test `specify --help`, `blog --help`, `pm --help` all work independently
   - Test `specify init test-project`, `blog init blog-project`, `pm init pm-project`

3. **Verify Shared Directory Structure**:
   - All kits write to `.specify/` (not `.blogkit/` or `.pmkit/`)
   - Constitution files coexist without collision (kit-specific headers differentiate them)

4. **Verify Slash Command Isolation**:
   - Install both spec-kit and blog-kit in same project
   - Verify `/speckit.plan` and `/blogkit.plan` are both available
   - Test that `/blogkit.plan` executes blog-specific workflow, not spec-kit workflow

5. **Agent Context File Namespacing**:
   - Verify `.claude/commands/blogkit.*` and `.claude/commands/speckit.*` both exist
   - Test `.cursor/rules/blogkit-rules.mdc` and `.cursor/rules/specify-rules.mdc` both work
   - Confirm Windsurf, Qwen, and other agents handle namespaced files correctly

6. **Script Path Portability**:
   - Run `blog init` in a project previously initialized with `specify init`
   - Verify scripts reference `.specify/` paths correctly
   - Test template loading from `.specify/templates/` works for both kits

---

**Living Document**: This constitution evolves as blog-tech-kit matures and as multi-kit coexistence patterns are validated. Amendments follow semantic versioning and propagate to all dependent templates and scripts.

**Last Reviewed**: 2025-12-04
**Next Review**: 2025-03-04 (Quarterly)
