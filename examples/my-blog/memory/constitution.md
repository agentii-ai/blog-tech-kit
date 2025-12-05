# Spec-Kit Methodology Blog Constitution
<!-- Educational Blog on Spec-Driven Development as Universal Problem-Solving Framework -->

**Version**: 2.0.0 | **Ratified**: 2025-12-05 | **Last Amended**: 2025-12-05

---

## Preamble: The Job Kit Movement

This constitution governs **the Spec-Kit Methodology Blog**, an authority publication demonstrating how spec-driven development (SDD) and the job kit pattern extend beyond software engineering to empower geeks, engineers, product managers, and product designers to solve complex problems systematically.

**Mission**: Establish kits.agentii.ai as the canonical authority for spec-kit methodology education, driving traffic through authoritative content that teaches professionals across all disciplines how to use structured specification-driven workflows with AI agents.

**Vision**: Enable millions of non-coders to abstract their professional workflows using the job kit methodology, reducing chaos and improving outcomes through specification-driven problem-solving.

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

### I. Problem-First, Not Technology-First

**Principle**: Every article begins with **concrete problems faced by professionals**, not the tools or technologies that solve them.

**Rationale**: Readers across disciplines (engineers, PMs, designers, geeks) come seeking solutions to their workflow chaos. Articles that lead with technology alienate audiences; articles that lead with universal problems build authority.

**Application**:
- **Articles address problems**: "How to communicate requirements without ambiguity," not "How to use spec-kit"
- **Solutions emerge naturally**: After establishing the problem, reveal how spec-driven development solves it
- **Real-world scenarios**: Use case studies from different professions (PM managing product roadmap, designer organizing design tokens, engineer building complex systems)

**Examples**:
- ❌ "Spec-Kit: A Spec-Driven Development Framework"
- ✅ "Reducing Product Ambiguity: How Structured Specifications End Engineering Rework"
- ❌ "Building PM-Kit for Product Managers"
- ✅ "Why Product Roadmaps Fail (And How to Fix It with Structured Planning)"

**Test**: Each article can be understood and valued by someone unfamiliar with spec-kit, reading only the problem statement and solution approach.

### II. Job Kit Abstraction Through Concrete Patterns

**Principle**: Content demonstrates that **specification-driven workflows are domain-agnostic patterns**, applicable to any knowledge work (coding, product management, design, marketing, sales, operations).

**Rationale**: Readers must understand that job kits are not "spec-kit for non-coders" but rather universal problem-solving methodologies. Authority comes from teaching the underlying abstraction, not just applying existing frameworks.

**Application**:
- **Pattern-focused**: Articles explain the job kit pattern (constitution → specify → clarify → plan → tasks → implement) abstractly
- **Cross-domain examples**: Same article demonstrates the pattern in 2-3 different professions
- **Tooling is secondary**: Whether you implement with markdown files, Jira, Notion, or AI agents is less important than the underlying methodology

**Content Pillars** (each pillar shows pattern across multiple domains):
1. **Specification Patterns**: How to define requirements clearly in coding, product management, design, marketing
2. **Planning & Decomposition**: Breaking complex work into executable steps across professions
3. **Constitution Engineering**: Building reusable governance frameworks for teams and organizations
4. **AI-Augmented Workflows**: Using AI agents to interpret and execute specifications across domains
5. **Authority Building Through Job Kits**: How to establish professional authority by mastering domain-specific kit patterns

**Test**: A non-technical PM or designer should finish reading an article and immediately think, "I could apply this to my work," not "This is for engineers only."

### III. Transparency Over Perfection

**Principle**: Share what works (and fails) in building spec-driven workflows across disciplines. Document edge cases, failures, and pragmatic workarounds honestly.

**Rationale**: Authority comes from hard-won wisdom, not polished marketing narratives. Readers trust writers who acknowledge limitations and share production lessons.

**Application**:
- **Document failures**: "Why we abandoned strict 4-pass editorial review and adopted a 2-pass rapid-content model"
- **Share metrics**: Publishing conversion rates, traffic sources, content performance data
- **Acknowledge constraints**: "This pattern works well for teams up to 50 people; beyond that, you need..."
- **Show alternatives**: "In this scenario, specification-driven workflows add overhead. Consider alternatives if..."

**Examples**:
- ❌ "How we scaled to 10K monthly users" (without context on what failed along the way)
- ✅ "We tried spec-kit for our marketing team and failed—here's what we learned and how to do it better"

**Test**: Each article includes at least one section documenting limitations, failures, or scenarios where the approach doesn't apply.

### IV. Audience-Specific Content Tracks

**Principle**: Create **four distinct content tracks**, each optimized for a different professional audience: Geeks, Engineers, Product Managers, and Product Designers. Each track demonstrates how job kits solve that audience's unique problems.

**Rationale**: Specification-driven workflows address different pain points across disciplines. Job kit authority emerges from understanding audience-specific problems deeply.

**Audience Definition**:
- **Geeks**: Early adopters, curious about emerging methodologies, tooling enthusiasts, indie hackers
- **Engineers**: Technical practitioners building complex systems, process optimization advocates
- **Product Managers**: Strategy-focused, roadmap management, stakeholder alignment challenges
- **Product Designers**: Design system governance, design-dev collaboration, iterative process improvement

**Content Track Structure** (each track publishes 2-3 posts per month):
1. **Geek Track**: "How to build your own job kit," tooling deep-dives, spec-kit internals
2. **Engineer Track**: "Building reliable systems through specification," code patterns, error reduction
3. **PM Track**: "How to run product without ambiguity," roadmap clarity, stakeholder alignment
4. **Designer Track**: "Design systems through specification," design token management, collaboration patterns

**Test**: Each piece of content explicitly tags which audience it's written for. Cross-references connect related posts across tracks.

### V. Authority Building Through Original Research

**Principle**: Content must include **original research, data, and insights**—not just explanations of existing frameworks.

**Rationale**: Original research establishes the blog as a thought leader in specification-driven methodology, not just a repackaging of GitHub's spec-kit.

**Application**:
- Conduct surveys with professionals across disciplines on workflow pain points
- Publish case studies from companies using job kits (anonymized if needed)
- Document measurable improvements (time saved, error reduction, productivity gains)
- Share failed experiments and learnings (e.g., "We tried this approach and it didn't work because...")
- Build open-source tools or frameworks that others can build on

**Examples**:
- 📊 "Survey: How Product Managers Currently Plan (And Why It Fails)" with methodology, sample size, results
- 🔬 "Case Study: 50% Reduction in Design-Dev Rework Using Design Specifications"
- 🛠️ "Open-Source Tool: Constitution Generator for Your Domain"

**Test**: At least 20% of published content includes original research, surveys, case studies, or open-source contributions.

### VI. Optimization for AI Agent Discoverability

**Principle**: All content is structured to be readable and extractable by AI agents (Claude, ChatGPT, Perplexity), enabling citation and amplification through AI systems.

**Rationale**: AI systems are now primary discovery mechanisms for professional content. Content optimized for AI extraction reaches more readers and builds authority through AI recommendations.

**Application**:
- **Clear problem-solution structure**: Problem statement → Why it matters → Approach → Concrete example → Results
- **Structured metadata**: JSON-LD ArticleSchema, author authority, publish/update dates
- **Glossary integration**: Define key concepts inline with links to central glossary
- **Code examples**: Language-tagged, copy-able, runnable where possible
- **Summary sections**: "Key Takeaways" and "Conclusion" sections enable clean AI extraction

**Examples**:
- ✅ Use semantic HTML (H1 → H2 → H3 hierarchy)
- ✅ Include "Problem" section, "Solution" section, "Code Example" section
- ✅ Link to related content and job kit patterns
- ❌ Avoid vague headers like "Other Considerations"

**Test**: Each article includes structured metadata and follows the problem-solution-example-results template.

### VII. Incremental, Consistent Publishing

**Principle**: Build authority through **consistent, incremental content delivery** over quarters and years, not viral one-shot posts.

**Rationale**: Job kit authority is a long-term play. Audiences develop trust through consistent pattern delivery, not perfect singular posts. Compound growth beats viral spikes.

**Application**:
- **Publishing cadence**: 2-3 posts per week (across all audience tracks combined)
- **Content calendar**: Plan 12 weeks ahead with content clusters (e.g., "Specification Patterns Cluster" across 4 related posts)
- **Sprint structure**: Each post gets 2-3 weeks (research → draft → peer review → publish)
- **Cross-linking**: New posts reference and link to related historical content

**Timeline**:
- **Months 1-3**: Foundation (12-15 posts establishing core patterns)
- **Months 4-6**: Expansion (20 posts diving into each audience track deeply)
- **Months 7-12**: Authority (30+ posts, audience clusters, original research)

**Test**: Editorial calendar reflects 12-week planning horizon. Content clusters show 3-5 related posts per topic.

### VIII. Measurement & Optimization

**Principle**: Every initiative includes instrumentation for traffic, engagement, and authority metrics. Content performance drives editorial decisions.

**Rationale**: Data-driven content strategy beats opinion. Measurement reveals which patterns resonate with which audiences.

**Application**:
- **Traffic tracking**: Google Analytics 4 with audience track segmentation
- **Engagement metrics**: Time on page, scroll depth, CTA clicks, newsletter signups
- **SEO tracking**: Keyword rankings, backlinks, citation counts
- **Authority metrics**: Inbound links from other sites, mentions in Hacker News/Reddit, social shares
- **Conversion tracking**: CTAs to kits.agentii.ai property, resource downloads, job kit adoptions

**Monthly Dashboard**:
- Traffic by audience track (Geeks vs Engineers vs PMs vs Designers)
- Top performing posts (by traffic, engagement, conversions)
- Keywords ranking in top 10
- Citation/backlink growth
- Newsletter subscriber growth

**Test**: Plans include "Analytics & Instrumentation" section. Weekly publishing includes performance review of previous posts.

---

## Blog-Specific Constraints

### Content Strategy Requirements

Every blog initiative must define:

1. **Blog Mission**: Authority publication on spec-kit methodology as universal problem-solving framework
2. **Target Audiences**: Geeks, Engineers, Product Managers, Product Designers (with cross-domain overlap)
3. **Content Pillars**:
   - Specification Patterns (how to define requirements across professions)
   - Planning & Decomposition (breaking complex work into steps)
   - Constitution Engineering (building governance frameworks)
   - AI-Augmented Workflows (using AI agents with specifications)
   - Job Kit Patterns (domain-specific frameworks)
4. **Publishing Cadence**: 2-3 posts per week (14-16 posts per month across all audience tracks)
5. **Success Metrics**:
   - Traffic: 50K+ monthly organic visitors by Month 12
   - Authority: 100+ inbound links from other technical publications
   - Engagement: 3+ minute average time-on-page, 25%+ CTR to kits.agentii.ai
   - Reach: 5K+ newsletter subscribers, featured in top industry publications

### Editorial Workflow Standards

All blog content follows a **3-pass editorial process** (optimized for consistent publishing):

1. **Research & Outline Pass**: Topic research, problem validation, audience track assignment, keyword research, outline creation
2. **Draft Pass**: Full article with problem statement, solution approach, real-world examples (cross-domain where applicable), code/config examples, key takeaways
3. **Review & Publish Pass**: Technical accuracy validation, SEO optimization, metadata completion, internal linking, image optimization, publication

**Timeline**:
- Foundation posts (Month 1-3): 3 weeks per post (more research needed)
- Expansion posts (Month 4-6): 2 weeks per post (patterns established)
- Authority posts (Month 7+): 1-2 weeks per post (rapid iteration)

**Quality Gates**:
- Article explicitly identifies target audience (Geeks, Engineers, PMs, Designers) or "All audiences"
- Problem statement is concrete and relatable to non-technical professionals
- At least one cross-domain example showing how pattern applies to different professions
- SEO metadata targets a keyword with < 10,000 monthly search volume
- All claims validated or explicitly marked as hypotheses
- Internal links connect to at least 2-3 related articles
- CTA included linking to kits.agentii.ai resources or related job kit patterns

### Distribution Requirements

Every published post must include:

- **SEO Optimization**: Target keyword (primary + 2-3 secondary), meta description (155-160 chars), Open Graph tags, JSON-LD Article schema
- **Internal Linking**: Minimum 3-4 links to related articles within the blog (builds content clusters and topic authority)
- **External Linking**: Citations to original research, GitHub repos, related thought leadership (builds credibility)
- **Multi-Platform Promotion**:
  - Twitter/X thread (problem-focused, linking to article)
  - LinkedIn post (audience-specific, case study angle)
  - Newsletter feature (excerpt + key takeaway)
  - Hacker News submission (if applicable)
  - Community sharing (Dev.to, Reddit r/webdev or r/ProductManagement depending on audience)
- **Social Metadata**: Twitter Card tags, Open Graph preview image, author attribution
- **Permanent URL**: Canonical URL, versioning strategy for updates

### Technical Standards

Blog implementations must meet:

- **Performance**: Lighthouse score ≥90 (mobile and desktop), Core Web Vitals "Good" status
- **Accessibility**: WCAG 2.1 AA compliance, semantic HTML, alt text for all images, keyboard navigation
- **SEO**: Valid structured data (JSON-LD Article schema), sitemap.xml, robots.txt, Open Graph + Twitter Card tags
- **Analytics**: Privacy-compliant tracking (GDPR/CCPA), cookie consent, UTM parameter tracking
- **Security**: HTTPS enforced, CSP headers, dependency vulnerability scanning, XSS protection

---

## Development Workflow

### Slash Command Workflow

The blog-tech-kit workflow follows the spec-driven development pattern with blog-specific adaptations:

1. **`/blogkit.constitution`**: Establish or update blog program governance principles (THIS DOCUMENT)
   - Input: Blog strategy philosophy and principles
   - Output: Updated `.specify/memory/constitution.md`

2. **`/blogkit.specify`**: Define content initiative (e.g., "First 20 foundation posts on Specification Patterns")
   - Input: Content initiative goals, audience tracks, content pillars
   - Output: `specs/{N}-{initiative}/spec.md` with content strategy

3. **`/blogkit.clarify`**: Structured Q&A to resolve underspecified content requirements
   - Input: Specification with questions
   - Output: Updated specification with clarifications

4. **`/blogkit.plan`**: Translate content strategy into implementation plan (platform, tools, workflows)
   - Input: Content initiative specification
   - Output: `plan.md`, `research.md`, `content-calendar.md`

5. **`/blogkit.tasks`**: Generate article-level task breakdown with editorial workflow
   - Input: Implementation plan
   - Output: `tasks.md` with 14-16 article production tasks across all audience tracks

6. **`/blogkit.implement`**: Execute article production tasks systematically
   - Input: Task list
   - Output: Published articles, analytics setup, newsletter configured

### Quality Gates

Before advancing to next phase:

- **Pre-Clarify Gate** (after `/blogkit.specify`):
  - ✅ Content initiative clearly defined (e.g., "Month 1: Foundation Posts")
  - ✅ Audience tracks identified (which tracks are featured)
  - ✅ Content pillars specified
  - ✅ Success metrics aligned with timeline (Month 1, 3, 6, 12 goals)
  - ✅ No technology implementation details in specification

- **Pre-Planning Gate** (after `/blogkit.clarify`):
  - ✅ All clarifications documented
  - ✅ Content strategy passes principle alignment validation (Principles I-III)
  - ✅ Editorial workflow defined (3-pass process)

- **Pre-Implementation Gate** (after `/blogkit.plan`):
  - ✅ Platform and tools selected
  - ✅ Analytics and tracking configured
  - ✅ Distribution channels defined
  - ✅ Technical standards checklist completed

- **Post-Implementation Gate** (after `/blogkit.implement`):
  - ✅ All technical standards met (performance, accessibility, SEO)
  - ✅ Analytics live and tracking correctly
  - ✅ First 4-5 articles published and indexed
  - ✅ Newsletter, social media, distribution channels activated

### Review & Acceptance Checklist

Every specification undergoes validation against this checklist:

- [ ] Content initiative clearly scoped (e.g., "First 20 Foundation Posts" or "Geek Track - Month 1-3")
- [ ] Target audience tracks explicitly identified (Geeks, Engineers, PMs, Designers)
- [ ] Content pillars align with spec-kit methodology (Specification Patterns, Planning, Constitution, AI Workflows, Job Kits)
- [ ] Problem-focused framing (no technology-first positioning)
- [ ] Success metrics measurable and timeline-specific (Month 1, 3, 6, 12)
- [ ] No implementation details leak into specification
- [ ] At least 2-3 cross-domain examples documented
- [ ] Distribution strategy includes 3+ channels (Twitter, LinkedIn, newsletter, etc.)
- [ ] All content passes principle alignment (Principles I-III essential)
- [ ] CTA strategy to kits.agentii.ai defined

---

## Governance

### Authority & Amendments

1. **Constitution Authority**: This document is the governing framework for the Spec-Kit Methodology Blog and all editorial decisions
2. **Amendment Process**:
   - Propose change with rationale and impact analysis
   - Version bump following semantic versioning (MAJOR.MINOR.PATCH)
   - Update dependent templates, plans, and tasks
   - Document changes in version history at top of document
3. **Compliance Review**: All content initiatives and specifications must demonstrate alignment with these principles

### Conflict Resolution

When principles conflict, apply this priority hierarchy:

1. **Authority > Speed**: Principle II (Cross-domain patterns) and V (Original research) take precedence over publishing speed
2. **Transparency > Perfection**: Principle III (Transparency Over Perfection) overrides pressure to hide failures or limitations
3. **Problem-First > Technology-First**: Principle I ensures content remains accessible to cross-disciplinary audiences
4. **Consistency > Virality**: Principle VII (Incremental Publishing) prioritizes long-term authority over viral spikes

### Exception Handling

Exceptions to principles require:

- **Written Justification**: Rationale with risk assessment
- **Documented Alternatives**: Why other approaches were rejected
- **Approval**: Editorial lead or project owner sign-off
- **Temporary Waiver**: Expiration date (max 1 month) with re-evaluation plan
- **Post-Action Review**: Document learnings and update principles if needed

**Common Exception Scenarios**:
- Time-sensitive article on industry event bypassing full 3-pass review
- Rapid-response article on competitive announcement
- Cross-domain experiment violating established content track structure

### Continuous Improvement

- **Monthly Review**: Analyze content performance, traffic sources, audience engagement
- **Quarterly Constitution Review**: Revisit principles against market feedback, competitive analysis, audience surveys
- **Retrospectives**: After each milestone (10 posts, 25 posts, 50K traffic), document what worked and update principles
- **Audience Feedback**: Solicit input from readers, social followers, and cross-domain practitioners
- **Competitive Monitoring**: Track successful blogs in adjacent spaces (product management, design systems, AI) quarterly

---

## Quick Reference: Content Pillars

Each content pillar is demonstrated across multiple audience tracks and professions:

| Pillar | Purpose | Example Topics | Target Audiences |
|--------|---------|-----------------|-----------------|
| **Specification Patterns** | How to define requirements clearly across domains | Writing effective PRDs, design briefs, API contracts, design specs | All (Engineers, PMs, Designers, Geeks) |
| **Planning & Decomposition** | Breaking complex work into executable steps | Breaking down roadmaps, project phases, design systems, engineering epics | Engineers, PMs, Designers |
| **Constitution Engineering** | Building reusable governance frameworks | Creating team standards, design systems, coding standards, editorial guidelines | All |
| **AI-Augmented Workflows** | Using AI agents with structured specifications | AI for code generation, design generation, content generation, strategy | All |
| **Job Kit Patterns** | Domain-specific spec-kit implementations | Engineering-Kit, PM-Kit, Design-Kit, Marketing-Kit | All |

---

## Quick Reference: Success Metrics (Timeline)

| Milestone | Traffic | Authority | Engagement | Reach |
|-----------|---------|-----------|------------|-------|
| Month 1 | 2K visitors | 0 | 2:00 avg time | 500 subscribers |
| Month 3 | 10K visitors | 5+ backlinks | 2:30 avg time | 1.5K subscribers |
| Month 6 | 30K visitors | 30+ backlinks | 3:00 avg time | 3K+ subscribers |
| Month 12 | 50K+ visitors | 100+ backlinks | 3:30 avg time | 5K+ subscribers |

---

**Living Document**: This constitution governs the Spec-Kit Methodology Blog and evolves with market feedback, audience research, and competitive analysis.

**Version**: 2.0.0
**Last Reviewed**: 2025-12-05
**Next Review**: 2026-03-05 (Quarterly)
