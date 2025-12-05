# Blog-Tech-Kit Constitution
<!-- AI/LLM SaaS Technical Blog & Twitter Marketing Governance Framework -->

**Version**: 1.1.0 | **Ratified**: 2025-12-04 | **Last Amended**: 2025-12-05

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

### II-A. Evidence Standards (NON-NEGOTIABLE)

**Principle**: All claims, benchmarks, and technical assertions must be supported by evidence from an explicit tier hierarchy.

**Evidence Tier Hierarchy**:

| Tier | Description | Examples | Usage |
|------|-------------|----------|-------|
| **Tier 1** | Peer-reviewed research, independently verified benchmarks | Academic papers, third-party audits, industry standards | Required for accuracy claims, performance benchmarks |
| **Tier 2** | Industry-recognized methodologies | Established frameworks, widely-adopted patterns, expert consensus | Acceptable for best practices, architectural patterns |
| **Tier 3** | Internal research with full methodology disclosure | Custom benchmarks, A/B tests, production metrics (with methodology) | Acceptable when methodology is transparent and reproducible |
| **Tier 4** | Anecdotal, unverified claims | "We heard that..." "Many companies..." | **AVOID** - Never use without Tier 1-3 support |

**Application**:
- Every specification must identify evidence sources for key claims
- Plans must include evidence validation tasks in the editorial workflow
- Technical review pass must verify evidence tier compliance

**Test**: No post may be published with Tier 4 evidence as primary support. All accuracy/performance claims require Tier 1-2 evidence.

### II-B. Honest Limitations Requirement

**Principle**: Every post must include explicit acknowledgment of limitations, edge cases, and when the approach does NOT apply.

**Application**:
- Authority posts: Dedicated "Limitations" or "When This Doesn't Apply" section (minimum 150 words)
- Practitioner posts: "Edge Cases" or "Common Pitfalls" section
- All posts: Failure modes, cost trade-offs, and complexity acknowledgments where relevant

**Rationale**: Transparency builds trust. The most authoritative AI/LLM blogs (Anthropic, OpenAI) consistently document what doesn't work alongside what does.

**Test**: Posts without limitation acknowledgment fail the technical review pass and must be revised before publication

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

### IV. SEO-First Content Architecture (NON-NEGOTIABLE)

**Principle**: SEO is integrated into every stage of content creation—from specification through measurement—not added as an afterthought.

**Rationale**: In 2024-2025, organic search and AI systems are primary discovery channels. Content optimized for search intent, topical authority, and E-E-A-T signals achieves sustainable traffic and authority.

**SEO Integration by Workflow Stage**:

| Stage | SEO Requirements |
|-------|------------------|
| **Specification** | Target keyword identified, search intent validated, content pillar assigned |
| **Clarification** | Keyword competition analyzed, content gap identified, internal linking targets defined |
| **Planning** | URL structure defined, metadata templates created, structured data schema selected |
| **Tasks** | Keyword density targets, heading hierarchy requirements, image alt-text tasks |
| **Implementation** | On-page SEO checklist, technical SEO validation, Core Web Vitals targets |
| **Measurement** | Ranking tracking, organic traffic monitoring, search console analysis |

**Core SEO Requirements**:
1. **Search Intent Fit**: Each post precisely answers a specific query and sub-questions
2. **Topical Authority**: Content organized into clusters (pillar + supporting posts)
3. **E-E-A-T Signals**: Author attribution, real examples, transparent methodology
4. **Technical Quality**: Fast, mobile-friendly, structured data, clean HTML

**Test**: Specifications must include a "Target Keyword" field. Plans must include an "SEO Checklist" section.

### IV-A. AI-Native Content Distribution

**Principle**: Content must be optimized for discovery by both human readers and AI systems (ChatGPT, Perplexity, Google AI Overviews, Claude).

**Rationale**: AI systems are increasingly primary discovery and citation channels. Content that AI can extract, understand, and cite achieves wider reach and sustained authority.

**Application**:
- All blog posts include structured metadata (JSON-LD Article schema)
- Content uses clear heading hierarchy (H1 → H2 → H3) for extraction
- Code examples include language tags and complete context
- Key concepts are explicitly defined and linked to glossary/pattern library
- Summary/Key Takeaways sections enable AI systems to extract concise answers
- FAQ sections target "People Also Ask" queries

**Structured Data Requirements**:
```json
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "[Post Title]",
  "author": { "@type": "Person", "name": "[Author Name]", "jobTitle": "[Role]" },
  "datePublished": "[ISO Date]",
  "dateModified": "[ISO Date]",
  "description": "[Meta Description]",
  "image": "[OG Image URL]"
}
```

**Examples**:
- ✅ "Problem: Agent responses lack context → Solution: Prompt templates with variable injection → Code example → Results"
- ❌ "Check out our new feature that makes agents better!"

**Test**: Plans must include an "AI Discoverability" section describing JSON-LD schema, heading hierarchy, and FAQ sections.

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

**Measurement Dashboard Template**:

| Metric | M1 Target | M3 Target | M6 Target | M12 Target | Tool |
|--------|-----------|-----------|-----------|------------|------|
| Organic Traffic | [X]K | [X]K | [X]K | [X]K+ | Plausible/GA4 |
| Newsletter Subscribers | [X] | [X] | [X] | [X]+ | ConvertKit |
| Page-1 Keywords | [X] | [X] | [X] | [X]+ | GSC/Ahrefs |
| Backlinks | [X] | [X] | [X] | [X]+ | Ahrefs |
| Avg Time on Page | [X]:00 | [X]:30 | [X]:00 | [X]:30+ | Plausible |
| Blog-Sourced Leads | [X] | [X] | [X] | [X]+ | CRM |
| AI Citations | [X] | [X] | [X] | [X]+ | Manual |

**Measurement Cadence**:
- **Daily**: Traffic, social engagement (first 7 days post-publish)
- **Weekly**: Keyword rankings, newsletter growth
- **Monthly**: Full dashboard review, content performance analysis
- **Quarterly**: Backlink audit, AI citation check, strategy adjustment

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
   - Consider multiple audience tracks with customized content depth and terminology
3. **Content Pillars**: 3-5 core themes aligned with product value (e.g., "Context Engineering," "Production Debugging," "Multi-Agent Orchestration")
   - Each pillar should have a hub/pillar page (3,000-6,000+ words) and 8-12 cluster posts
4. **Publishing Cadence**: Realistic frequency based on blog type and **team capacity**
   - Authority: 1-2 posts/quarter (deep research, original insights)
   - Practitioner: 2-4 posts/month (tutorials, guides, patterns)
   - Community: 4-8 posts/month (contributor features, case studies)
   - Thought Leadership: 1-2 posts/month (executive perspective, industry analysis)
5. **Success Metrics**: Measurable outcomes aligned with blog type (see Principle VI)
6. **Primary Keywords**: Target keyword per pillar (map 1 primary + 2-5 secondary keywords per post)

### Team Resource Requirements

**Principle**: Publishing cadence must be validated against available team capacity. Unrealistic cadence degrades quality.

**Team Capacity Guidelines**:

| Cadence | Minimum Team | Roles Required |
|---------|--------------|----------------|
| 1-2 posts/month | 0.5 FTE | Writer (part-time), SME review (ad hoc) |
| 3-4 posts/month | 1.5 FTE | Writer (1 FTE), Editor (0.25 FTE), SME (0.25 FTE) |
| 6-8 posts/month | 3 FTE | Writer (1.5 FTE), Editor (0.5 FTE), SME (0.5 FTE), Marketing (0.5 FTE) |
| 10+ posts/month | 5+ FTE | Multiple writers, dedicated editor, SME pool, marketing team |

**Role Definitions**:
- **Writer**: Research, drafting, revisions (15-25 hours per authority post, 8-12 hours per practitioner post)
- **SME (Subject Matter Expert)**: Technical review, accuracy validation (2-4 hours per post)
- **Editor**: Copyediting, SEO optimization, quality gates (3-5 hours per post)
- **Marketing**: Distribution, social amplification, analytics (2-4 hours per post)

**Test**: Specifications must include a "Team Capacity" section validating that stated cadence is achievable with available resources. Plans must assign owners to each editorial role.

### Editorial Workflow Standards

All blog content follows a **4-pass editorial process** with SEO integrated at each stage:

1. **Research Pass** (Week 1): Topic research, outline creation, source validation, **keyword research & competition analysis**
   - SEO: Primary keyword selected, search intent validated, competitor content analyzed
   - Deliverable: Outline with H2/H3 structure, keyword mapping, evidence sources

2. **Draft Pass** (Week 2): Full draft with code examples, diagrams, citations, and internal links
   - SEO: Keyword placement (H1, first 100 words, H2s), internal linking (3-5 links), meta description draft
   - Deliverable: Complete draft meeting word count targets, all sections filled

3. **Technical Review Pass** (Week 3): Domain expert validates accuracy, tests code examples, verifies claims, **checks evidence tier compliance**
   - SEO: Verify structured data, check heading hierarchy, validate code examples
   - Deliverable: SME sign-off with corrections noted, evidence sources validated

4. **Final Edit Pass** (Week 4): Copyediting, **SEO optimization**, metadata completion, image optimization
   - SEO: Final keyword density check, meta description (150-160 chars), OG tags, alt text, JSON-LD schema
   - Deliverable: Publication-ready post with 15-point SEO checklist complete

**Timeline**:
- Authority posts: 4-6 weeks from research to publication
- Practitioner posts: 2-3 weeks (simpler validation)
- Community/Thought Leadership posts: 2 weeks (less technical validation needed)

**Quality Gates**:
- Draft must include at least 3-5 internal links to related content (content cluster strategy)
- Code examples must be tested in a clean environment
- SEO metadata must target a primary keyword with < 5,000 monthly search volume (low competition initially)
- Technical review must be completed by someone other than the author (NO SELF-VALIDATION)
- Evidence tier compliance verified (no Tier 4 claims as primary support)
- Limitations section present (minimum 150 words for authority posts)

### Distribution Requirements (3-Tier Model)

Every published post must include a distribution plan across three tiers:

#### Tier 1: Owned Audience (Day 0)
- **Blog Publication**: SEO-optimized post with target keyword, meta description (150-160 chars), JSON-LD schema
- **Newsletter**: Dedicated email or featured section (excerpt + compelling CTA)
- **RSS Feed**: Automatic syndication to feed subscribers
- **Internal Linking**: Minimum 3-5 links to related content (builds topic authority and SEO equity)

#### Tier 2: Amplification (Day 0-3)
- **Social Media**:
  - Twitter/X: Thread (1 main + 5-7 follow-ups) with key insights, posted 2pm PT
  - LinkedIn: Long-form post with narrative angle, posted 9am PT
- **Cross-Posting**: Dev.to, Hashnode, Medium (with canonical URL pointing to original)
- **Open Graph & Twitter Cards**: Custom image (1200x630px) with title overlay

#### Tier 3: Community Engagement (Day 1-7)
- **Hacker News**: Submit as "Show HN" on Tue/Wed/Thu between 7-9 AM EST
  - Title format: "Show HN: [Problem] – [Approach/Result]"
  - Engage with comments within first 2 hours
  - Target: 3,000-5,000 targeted visitors per successful post
- **Reddit**: Relevant subreddits (r/programming, r/MachineLearning, domain-specific)
  - Participate authentically, don't spam
- **Discord/Slack Communities**: Share in relevant channels with context

#### Content Repurposing Requirements
Each authority post should generate:
- 1 Twitter/X thread (5-7 tweets)
- 1 LinkedIn post (different angle)
- 3-5 quote graphics for social sharing
- 1 newsletter segment
- 1 cross-post (Dev.to or equivalent)

**Citation Preparation**: Permanent URL, clear licensing, author attribution, canonical URL tags

### Technical Standards

Blog implementations must meet:

- **Performance**: Lighthouse score ≥90 (mobile and desktop), Core Web Vitals pass
  - LCP (Largest Contentful Paint): < 2.5s
  - CLS (Cumulative Layout Shift): < 0.1
  - FID (First Input Delay): < 100ms
- **Accessibility**: WCAG 2.1 AA compliance minimum (semantic HTML, alt text, keyboard navigation)
- **SEO Technical Requirements**:
  - Valid JSON-LD Article schema on all posts (headline, author, datePublished, image)
  - Organization schema on main site
  - sitemap.xml with all blog posts
  - robots.txt with sitemap reference
  - OpenGraph tags (og:title, og:description, og:image, og:url)
  - Twitter Card tags (twitter:card, twitter:title, twitter:description, twitter:image)
  - Canonical URLs on all pages
  - Clean URL structure (no dates unless news content)
- **Analytics**: Privacy-compliant tracking (GDPR/CCPA), cookie consent if required
- **Security**: HTTPS enforced, CSP headers, dependency scanning, XSS protection

### SEO Checklist (15-Point Gate)

Every post must pass this checklist before publication:

| # | Item | Requirement |
|---|------|-------------|
| 1 | Primary Keyword | In H1, first 100 words, 1-2 H2s |
| 2 | Meta Title | ≤60 chars, includes keyword + brand |
| 3 | Meta Description | 150-160 chars, keyword + value + CTA |
| 4 | URL Slug | Short, hyphenated, keyword-relevant |
| 5 | Heading Hierarchy | H1 → H2 → H3 (no skipped levels) |
| 6 | Internal Links | 3-5 links to related content |
| 7 | External Links | 2-3 authoritative sources |
| 8 | Images | Optimized (<200KB), descriptive alt text |
| 9 | JSON-LD Schema | Valid Article schema |
| 10 | OG Tags | Title, description, image (1200x630px) |
| 11 | Twitter Card | Summary large image card |
| 12 | Readability | Grade 11-14 (Flesch-Kincaid) |
| 13 | FAQ Section | 4-6 Q&A pairs (authority posts) |
| 14 | Key Takeaways | 3-5 extractable bullet points |
| 15 | Code Examples | Language-tagged, tested, complete |

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

**Last Reviewed**: 2025-12-05
**Next Review**: 2025-03-05 (Quarterly)

---

## Changelog

### v1.1.0 (2025-12-05)
- **Added**: Evidence Tier Hierarchy (II-A) - 4-tier evidence standards for claims validation
- **Added**: Honest Limitations Requirement (II-B) - Mandatory limitations sections
- **Added**: SEO-First Content Architecture (IV) - SEO integration at every workflow stage
- **Added**: SEO Integration by Workflow Stage table
- **Added**: JSON-LD structured data template
- **Added**: Team Resource Requirements section with FTE guidelines
- **Added**: Distribution Requirements (3-Tier Model) with content repurposing
- **Added**: Measurement Dashboard Template with targets and cadence
- **Added**: 15-Point SEO Checklist gate for publication
- **Added**: Core Web Vitals targets (LCP, CLS, FID)
- **Enhanced**: Editorial Workflow Standards with SEO at each pass
- **Enhanced**: Technical Standards with detailed SEO requirements
- **Enhanced**: Quality Gates with evidence tier and limitations checks
