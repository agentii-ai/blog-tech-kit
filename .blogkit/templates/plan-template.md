# Editorial & Technical Plan: [BLOG INITIATIVE NAME]

**Branch**: `[###-feature-name]` | **Date**: [DATE] | **Spec**: [link to spec.md]
**Input**: Blog content strategy from `/specs/[###-feature-name]/spec.md`

**Note**: This template is filled in by the `/blogkit.plan` command. See `.blogkit/templates/commands/blogkit.plan.md` for the execution workflow.

## Summary

[Extract from blog spec: blog type, target audience, content pillars + editorial approach from research]

## Editorial Workflow

<!--
  IMPORTANT: Define HOW content will be produced, reviewed, and published.
  Focus on editorial process, not technology choices (those come later in Technical Stack).
-->

### Content Production Process

**Editorial Cycle**: [e.g., "2-week sprint per practitioner post" | "6-week cycle per authority post" | "Weekly community spotlight"]

| Phase | Duration | Activities | Owner |
|-------|----------|------------|-------|
| **Research & Planning** | [e.g., 2-3 days] | Topic selection, competitive analysis, outline development | [Writer/SME] |
| **Drafting** | [e.g., 3-5 days] | Main content, code examples (if applicable), evidence gathering | [Writer] |
| **Technical Review** | [e.g., 2-3 days] | Code validation, accuracy check, production feasibility | [SME/Engineer] |
| **Copyedit** | [e.g., 1-2 days] | Grammar, clarity, SEO optimization, readability | [Editor] |
| **Publish & Distribute** | [e.g., 1 day] | Final review, metadata, publish, social distribution | [Editor/Marketing] |

**Total Cycle Time**: [e.g., ~2 weeks per practitioner post | ~6 weeks per authority post]

### 4-Pass Editorial Quality Control

**Pass 1: Structural Edit**
- Does the outline match the title's promise?
- Is information in logical order?
- Does each section support the main thesis?

**Pass 2: Clarity Edit**
- Is each concept explained before it's used?
- Would someone with different background knowledge follow?
- Is jargon level consistent with target audience?

**Pass 3: Technical Accuracy**
- Do code examples actually run in clean environment?
- Are benchmarks current and properly cited?
- Have things changed since drafting started?
- Does a domain expert who didn't write the post validate the claims?

**Pass 4: SEO & AI Optimization**
- Clear H2/H3 hierarchy for LLM parsing
- Target keyword in first 100 words
- FAQ section for posts 1500+ words (helps AI summarization)
- Links to authoritative external sources
- JSON-LD Article schema present
- Internal links to 2-3 related posts (content cluster)

### Roles & Responsibilities

| Role | Responsibility | Time Commitment |
|------|---------------|-----------------|
| **Writer** | Research, outline, draft, revisions | [e.g., 10-15 hrs/post] |
| **Subject Matter Expert (SME)** | Technical validation, code review, accuracy check | [e.g., 2-3 hrs/post] |
| **Copyeditor** | Grammar, clarity, readability, SEO | [e.g., 2-3 hrs/post] |
| **Reviewer (Optional)** | Pre-publish final check | [e.g., 1 hr/post] |
| **Marketing/Distribution** | Social copy, newsletter, community distribution | [e.g., 2-3 hrs/post] |

**CRITICAL**: Technical validation MUST be done by someone other than the author (per constitution principle: "No Self-Validation").

---

## Technical Stack

<!--
  NOW we choose technology: CMS, frameworks, hosting, analytics, newsletter platform.
  These choices serve the content strategy defined in spec.md.
-->

### Platform Architecture

**Content Management System (CMS)**:
[e.g., "Next.js + MDX (Markdown with React components)" | "Ghost (headless)" | "WordPress + Gutenberg" | NEEDS CLARIFICATION]

**Rationale**: [Why this CMS? Consider: markdown support, developer experience, preview capabilities, version control integration, cost, team familiarity]

**Framework**:
[e.g., "Next.js 14 (App Router)" | "Astro" | "SvelteKit" | "Hugo (static)" | NEEDS CLARIFICATION]

**Rationale**: [Why this framework? Consider: build performance, SEO capabilities, developer experience, content preview, incremental adoption]

**Hosting & Deployment**:
[e.g., "Vercel (auto-deploy from main branch)" | "Netlify" | "Cloudflare Pages" | "AWS S3 + CloudFront" | NEEDS CLARIFICATION]

**Rationale**: [Why this host? Consider: deployment speed, cost, CDN performance, preview environments, team workflows]

**Performance Goals**:
- Page load: [e.g., < 2 seconds on 3G, < 1 second on cable]
- Core Web Vitals: [e.g., LCP < 2.5s, FID < 100ms, CLS < 0.1]
- Build time: [e.g., < 3 minutes for full site, < 30 seconds for incremental]

### Tools & Integrations

**Analytics Platform**:
[e.g., "Plausible (privacy-first)" | "Google Analytics 4" | "PostHog" | NEEDS CLARIFICATION]

**Metrics Tracked**: [e.g., "Page views, time on page, scroll depth, referrers, conversion events (newsletter signup, demo request)"]

**Newsletter Platform**:
[e.g., "ConvertKit (automated sequences)" | "Mailchimp" | "Substack (separate channel)" | NEEDS CLARIFICATION]

**Integration**: [e.g., "Embedded signup forms on blog, auto-send new posts to subscribers"]

**SEO Tools**:
[e.g., "Google Search Console (rankings)" | "Ahrefs (backlinks)" | "Built-in sitemap generation" | NEEDS CLARIFICATION]

**Purpose**: [Track keyword rankings, backlink growth, search traffic sources]

**Content Workflow Tools**:
[e.g., "Notion (planning calendar)" | "Google Docs (drafting)" | "GitHub Pull Requests (review workflow)" | NEEDS CLARIFICATION]

**Code Example Validation**:
[e.g., "Run all code examples in CI/CD on publish" | "Manual testing in clean environment" | NEEDS CLARIFICATION]

---

## AI Discoverability & SEO Optimization

### AI-Native Content Structure

**JSON-LD Schema Implementation**:
- Article schema (headline, author, datePublished, dateModified)
- Author schema (name, url, description)
- Organization schema (logo, sameAs links)

**Heading Hierarchy for LLM Parsing**:
- H1: Title only (one per page)
- H2: Major sections (3-7 per post)
- H3: Subsections (as needed for detail)

**Explicit Concept Definitions**:
- Define key terms before first use
- Include FAQ section for posts 1500+ words
- Use semantic HTML (not divs for everything)

**Code Example Best Practices for AI**:
- Use language tags in code blocks (```python, ```javascript)
- Include complete, runnable examples (not fragments)
- Add context comments explaining what the code does
- Link to full GitHub repo when applicable

### SEO Implementation Checklist

- [ ] Target keyword identified (< 5,000 monthly search volume for low competition)
- [ ] Keyword in: Title, H2, first 100 words, meta description, URL slug
- [ ] Meta description 150-160 characters
- [ ] Open Graph tags (og:title, og:description, og:image)
- [ ] Twitter Card tags (twitter:card, twitter:title, twitter:description, twitter:image)
- [ ] Canonical URL set
- [ ] Image alt text descriptive and includes keyword where natural
- [ ] Internal links to 2-3 related posts (content cluster strategy)
- [ ] External links to 1-2 authoritative sources (signals credibility)
- [ ] Sitemap generated automatically
- [ ] Robots.txt configured (allow indexing)

---

## Distribution Strategy

### 3-Tier Distribution Model

**Tier 1: Owned Channels (Direct Control)**
- Company blog (primary home)
- Email newsletter (automated: new post = new email)
- YouTube (if video content planned)

**Tier 2: Amplification Platforms (Extend Reach)**
- Twitter/LinkedIn (share within 24 hours of publish)
- Dev.to (cross-post within 48 hours with canonical link)
- Hashnode (if developer-focused)
- Medium (optional, with canonical link back)

**Tier 3: Community Engagement (Highest Intent)**
- Reddit (r/MachineLearning, r/LangChain, r/programming - post genuinely, not promotionally)
- Hacker News ("Show HN" on Tue/Wed/Thu, 7-9 AM EST for best visibility)
- Discord/Slack communities (share when relevant to conversation)
- GitHub Discussions (if open-source project blog)

### Social Distribution Workflow

**Day 0 (Publish):**
- [ ] Publish post on blog
- [ ] Send newsletter to subscribers automatically
- [ ] Tweet thread (3-5 tweets) with key takeaways
- [ ] LinkedIn post (text + link)

**Day 1-2 (Amplification):**
- [ ] Cross-post to Dev.to with canonical link
- [ ] Share in relevant Discord/Slack communities (genuine participation, not spam)
- [ ] Respond to all comments on blog and social platforms

**Day 3-7 (Community):**
- [ ] Submit to Hacker News if appropriate (Show HN format)
- [ ] Share in Reddit communities (follow community rules, add value)
- [ ] Monitor backlinks and citations

### Newsletter Strategy

**Frequency**: [e.g., "Every new post (2-4x/month)" | "Weekly digest + new posts" | "Monthly roundup"]

**Content Structure**:
- Subject line: [e.g., "Post title + hook"]
- Preview text: [e.g., "One-sentence value proposition"]
- Email body: [e.g., "TLDR + excerpt + CTA to read full post"]

**Growth Tactics**:
- [ ] Signup CTA at end of every post
- [ ] Exit-intent popup (optional, test conversion vs. annoyance)
- [ ] Social proof (e.g., "Join 5,000+ AI engineers")
- [ ] Welcome sequence for new subscribers (3-5 emails introducing best content)

---

## Content Calendar & Production Plan

### Year 1 Content Map

| Quarter | Focus | Target Posts | Cumulative Traffic Goal | Key Metrics |
|---------|-------|--------------|-------------------------|-------------|
| **Q1: Foundation** | Establish core concepts from Pillar 1 | [e.g., 3-4 authority posts] | [e.g., 5K/month] | [e.g., 2-3 backlinks/post] |
| **Q2: Depth** | Expand Pillar 2, add practitioner guides | [e.g., 4-5 how-to posts] | [e.g., 20K/month] | [e.g., 10+ keyword rankings] |
| **Q3: Proof** | Original research, benchmarks, case studies | [e.g., 2-3 data posts] | [e.g., 35K/month] | [e.g., 5-10 external citations] |
| **Q4: Scale** | Double down on high-performing pillars | [e.g., 4-6 posts on winners] | [e.g., 50K/month] | [e.g., 20+ top-10 rankings] |

**Year 1 Cumulative Targets**:
- 50K+ monthly organic traffic
- 500-1000 blog-sourced signups (demos, SDK downloads, newsletter)
- 5-10 high-quality external citations (other blogs, documentation)
- 20+ keyword rankings in top 10 (Google)

### The First 5 Authority Posts

These 5 posts establish authority, generate backlinks, and create content cluster foundation:

| Post # | Type | Purpose | Timeline | Expected Outcome |
|--------|------|---------|----------|------------------|
| **1** | Foundation Post | Establish core concept | [e.g., Weeks 1-3] | 3-5K organic traffic, 5-10 backlinks |
| **2** | Deep Dive | Deepen understanding | [e.g., Weeks 4-6] | Build on Post 1 rankings |
| **3** | Anti-Pattern | Credibility through honesty | [e.g., Weeks 7-9] | High shareability, community trust |
| **4** | Ecosystem Post | Position in context | [e.g., Weeks 10-12] | Ecosystem partnerships, backlinks |
| **5** | Benchmark/Data | Authority through research | [e.g., Weeks 13-15] | 20-50 backlinks, media citations |

---

## Constitution Check

*GATE: Must pass before beginning production. Re-check after first 3 posts published.*

[Gates determined based on constitution file in .blogkit/memory/constitution.md]

**Blog-Specific Principles**:

- [ ] **Content-First**: Technology choices made AFTER content strategy defined (spec.md → plan.md)
- [ ] **No Self-Validation**: Technical review by SME who didn't write the post
- [ ] **Simplicity & Focus**: No custom CMS before 10 published posts (use battle-tested platform)
- [ ] **AI-Native Distribution**: JSON-LD schema, clear H2/H3 hierarchy, FAQ sections present
- [ ] **Community Over Broadcast**: Blog features community work, contributors share their features
- [ ] **Transparency Over Perfection**: Edge cases documented, failure modes shared honestly
- [ ] **Long-term Over Quick Wins**: Blog strategy designed for 2-3 year compounding, not viral moments
- [ ] **Measurable Outcomes**: Every success criterion from spec.md has tracking implementation defined

**Complexity Review**:

> **Fill ONLY if Constitution Check has violations that must be justified**

[Example: "Custom CMS chosen before 10 posts - Justification: Team already has Next.js expertise, no additional complexity"]

---

## Project Structure

### Documentation (this feature)

```text
specs/[###-feature]/
├── plan.md              # This file (/blogkit.plan command output)
├── spec.md              # Content strategy (/blogkit.specify command output)
├── research.md          # Phase 0 output (if [NEEDS CLARIFICATION] present in spec)
├── editorial-guide.md   # Phase 1 output (style guide, tone, voice)
├── content-calendar.md  # Phase 1 output (first 5 posts mapped to quarters)
└── tasks.md             # Phase 2 output (/blogkit.tasks command - NOT created by /blogkit.plan)
```

### Blog Repository Structure

<!--
  ACTION REQUIRED: Replace the placeholder tree below with the concrete layout
  for this blog. Delete unused options and expand the chosen structure with
  real paths. The delivered plan must not include Option labels.
-->

```text
# [REMOVE IF UNUSED] Option 1: Next.js + MDX (DEFAULT for practitioner/authority blogs)
src/
├── app/
│   ├── blog/
│   │   ├── [slug]/page.tsx     # Individual blog post pages
│   │   └── page.tsx            # Blog index
│   ├── layout.tsx
│   └── page.tsx
├── components/
│   ├── BlogPost.tsx
│   ├── CodeBlock.tsx           # Syntax highlighted code
│   ├── NewsletterSignup.tsx
│   └── SEO/
│       ├── JsonLd.tsx          # JSON-LD schema components
│       └── MetaTags.tsx
└── content/
    └── posts/
        ├── 001-foundation-post.mdx
        ├── 002-deep-dive.mdx
        └── ...

# [REMOVE IF UNUSED] Option 2: Ghost (headless CMS) - for editorial teams preferring WYSIWYG
ghost-content/
└── [Managed in Ghost Admin UI - no local files]

frontend/
├── src/
│   ├── pages/
│   │   ├── blog/[slug].tsx     # Fetches from Ghost Content API
│   │   └── blog/index.tsx
│   └── components/
└── public/

# [REMOVE IF UNUSED] Option 3: Hugo (static site) - for community/simple blogs
content/
└── posts/
    ├── 001-foundation-post.md
    ├── 002-deep-dive.md
    └── ...

layouts/
├── _default/
│   ├── baseof.html
│   ├── single.html
│   └── list.html
└── partials/

# [REMOVE IF UNUSED] Option 4: WordPress + Headless - for existing WordPress users
wordpress/
└── [Managed in WordPress Admin]

frontend/
├── src/
│   ├── pages/
│   │   └── blog/[slug].tsx     # Fetches from WordPress REST API
│   └── components/
└── public/
```

**Structure Decision**: [Document the selected structure and reference the real directories captured above]

**Rationale**: [Why this structure? Consider: team familiarity, content preview needs, build performance, version control integration]

---

## Phases & Milestones

### Phase 0: Research (Optional - if [NEEDS CLARIFICATION] present in spec)

**Gate**: Triggered automatically if spec.md contains > 3 [NEEDS CLARIFICATION] markers

**Deliverable**: `research.md` with answers to clarification questions

**Timeline**: [e.g., 3-5 days]

**Activities**:
- Competitive blog analysis (what do successful competitors publish?)
- Audience research (where does target audience hang out? what do they search for?)
- Keyword research (which keywords are low competition, high intent?)
- Tool evaluation (if tech stack choices still unclear)

### Phase 1: Platform Setup & Editorial Foundation

**Gate**: Must complete before first post

**Deliverables**:
- Blog platform deployed (CMS, framework, hosting)
- Analytics configured (tracking pageviews, conversions)
- Newsletter platform integrated
- Editorial style guide (`editorial-guide.md`)
- Content calendar for first 5 posts (`content-calendar.md`)
- SEO/AI optimization checklist

**Timeline**: [e.g., 1-2 weeks]

**Activities**:
- Set up chosen tech stack (CMS + framework + hosting)
- Configure analytics (Plausible, GA4, etc.)
- Integrate newsletter platform (ConvertKit, Mailchimp, etc.)
- Create editorial style guide (tone, voice, code style, citation format)
- Map first 5 posts to content calendar
- Create JSON-LD schema templates
- Test build + deploy workflow

### Phase 2: Content Production (First 5 Posts)

**Gate**: Platform setup complete (Phase 1)

**Deliverable**: First 5 authority posts published, distributed, measured

**Timeline**: [e.g., 12-15 weeks for 5 posts at 2-3 weeks/post]

**Activities** (per post):
- Research & outline (2-3 days)
- Draft (3-5 days)
- Technical review (2-3 days)
- Copyedit (1-2 days)
- Publish & distribute (1 day)
- Monitor performance (ongoing)

### Phase 3: Measurement & Iteration

**Gate**: 3 months after first post published

**Deliverable**: Performance report + iteration plan

**Timeline**: [e.g., 1 week analysis]

**Activities**:
- Analyze traffic sources (organic, social, referral)
- Identify top-performing posts (traffic, engagement, conversions)
- Identify underperforming posts (low traffic, high bounce rate)
- Keyword ranking analysis (which posts rank? which don't?)
- Backlink analysis (which posts get cited?)
- Community feedback review (comments, social engagement)
- Iteration plan: double down on winners, refresh losers

**Metrics to Review**:
- Monthly unique visitors
- Average time on page
- Newsletter signup rate (% of blog visitors)
- Blog-sourced signups (demos, SDK downloads)
- Keyword rankings (top 10, top 3, #1 positions)
- Backlinks per post
- Social shares
- Citations in AI systems (ChatGPT, Perplexity, Claude)

---

## Dependencies

**Editorial Team**:
- Writer (internal or freelance)
- Subject Matter Expert (technical validation)
- Copyeditor (grammar, SEO)
- Marketing (distribution)

**Tools & Platforms**:
- CMS platform (Next.js/Ghost/Hugo/WordPress)
- Hosting (Vercel/Netlify/AWS)
- Analytics (Plausible/GA4)
- Newsletter (ConvertKit/Mailchimp)
- Domain + SSL certificate

**Content Resources**:
- Access to domain experts for technical validation
- Code examples repository (if technical blog)
- Design resources (diagrams, screenshots, social images)

**External Dependencies**:
- GitHub (for version control, if applicable)
- DNS provider (for custom domain)
- CDN (often included with hosting provider)

---

## Constraints

**Editorial Capacity**: [e.g., "1 writer, part-time (20 hrs/week) = max 2 practitioner posts/month"]

**Budget**: [e.g., "$500/month hosting + analytics + newsletter" | "$2,000/month including freelance writers"]

**Timeline**: [e.g., "First post published within 3 weeks of plan approval"]

**Technical Constraints**: [e.g., "Must use existing company infrastructure (AWS)" | "Team only knows JavaScript frameworks"]

**Legal/Compliance**: [e.g., "All posts must pass legal review (regulated industry)" | "Cannot include confidential customer data"]

**SEO Constraints**: [e.g., "Avoid keywords already owned by competitors (rank #1 for 5+ years)" | "Focus on long-tail keywords < 5K search volume"]

---

## Risks & Mitigations

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| **Content doesn't rank** | High (no organic traffic) | Medium | Keyword research upfront, target low-competition keywords, build backlinks through ecosystem partnerships |
| **Writer capacity insufficient** | Medium (slow publishing) | High | Start with 1 post/month, hire freelancer if traction proven, reuse content cluster strategy to amplify fewer posts |
| **Technical accuracy errors** | High (trust damage) | Low | Mandatory SME review by non-author, test all code examples in CI/CD |
| **Platform costs exceed budget** | Low (blog still functions) | Low | Start with free tier (Vercel, Netlify), upgrade only when traffic justifies it |
| **Competitor publishes similar content first** | Medium (less differentiation) | Medium | Monitor competitor blogs weekly, pivot angle if needed, add unique data/research |

---

## Success Criteria Tracking Implementation

[For each success criterion in spec.md, define HOW it will be measured]

**Example from spec.md**:
- SC-001: "Achieve 50K monthly unique visitors by Month 6"
  - **Tool**: Plausible Analytics dashboard
  - **Tracking**: Monthly unique visitors metric
  - **Review**: Monthly review in Phase 3

- SC-005: "10% newsletter signup rate from blog traffic"
  - **Tool**: ConvertKit conversion tracking
  - **Formula**: (newsletter signups / blog unique visitors) * 100
  - **Review**: Weekly review, A/B test signup CTA placement

- SC-011: "5 citations in AI systems within 12 months"
  - **Tool**: Manual search in ChatGPT, Claude, Perplexity for target keywords
  - **Tracking**: Quarterly manual check, document citations
  - **Review**: Quarterly review in Phase 3

---

## Next Steps

1. **Approve this plan** → Proceed to Phase 0 (if research needed) or Phase 1 (platform setup)
2. **Run `/blogkit.tasks`** → Generate actionable task breakdown by sprint and content pillar
3. **Begin Phase 1** → Set up platform, analytics, newsletter, editorial guide
4. **Launch Phase 2** → Start producing first 5 authority posts
5. **Monitor & Iterate** → Measure performance after 3 months, double down on winners

---

**Validation Checklist**:

Before moving to `/blogkit.tasks`, verify:

- [ ] Editorial workflow defined (roles, timelines, quality control)
- [ ] Technical stack chosen (CMS, framework, hosting, analytics, newsletter)
- [ ] AI optimization strategy documented (JSON-LD, heading hierarchy, code examples)
- [ ] Distribution strategy defined (3-tier model: owned, amplification, community)
- [ ] Content calendar mapped (Year 1 plan, first 5 posts)
- [ ] Constitution Check passed (all 8 Core Blog Principles validated)
- [ ] Success criteria tracking implementation defined (how each SC will be measured)
- [ ] No [NEEDS CLARIFICATION] markers remain (or research phase planned)
- [ ] Dependencies and constraints documented
- [ ] Risks identified with mitigations

---

**Note**: This plan defines HOW to execute the content strategy from spec.md. Technology choices are now locked in. Tasks.md (generated by `/blogkit.tasks`) will break this plan into actionable sprints.
