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

### Roles & Responsibilities (with FTE Allocation)

| Role | FTE | Hrs/Week | Responsibility | Posts Supported |
|------|-----|----------|----------------|------------------|
| **Writer** | [X] FTE | [X] hrs | Research, outline, draft, revisions | [X] posts/month |
| **SME (Reviewer)** | [X] FTE | [X] hrs | Technical validation, code review, accuracy check | [X] reviews/month |
| **Copyeditor** | [X] FTE | [X] hrs | Grammar, clarity, readability, SEO optimization | [X] edits/month |
| **Marketing** | [X] FTE | [X] hrs | Social copy, newsletter, community distribution | [X] promos/month |
| **Liaison (Optional)** | Ad hoc | As needed | Cross-functional coordination, stakeholder updates | N/A |

**Time Per Post by Type**:

| Post Type | Writer | SME | Editor | Marketing | Total |
|-----------|--------|-----|--------|-----------|-------|
| Authority (6 wk) | 15-25 hrs | 3-4 hrs | 3-5 hrs | 3-4 hrs | 24-38 hrs |
| Practitioner (2 wk) | 8-12 hrs | 2-3 hrs | 2-3 hrs | 2-3 hrs | 14-21 hrs |
| Community (1 wk) | 4-6 hrs | 1-2 hrs | 1-2 hrs | 1-2 hrs | 7-12 hrs |

**Capacity Validation**:
- **Required**: [X] FTE for [Y] posts/month
- **Available**: [Z] FTE
- **Status**: ✅ Sufficient / ❌ Insufficient → [Action if insufficient]

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

### SEO Implementation Checklist (40-Point Gate)

#### Keyword & Content (10 items)
- [ ] Target keyword identified (< 5,000 monthly search volume initially)
- [ ] Search intent validated (informational/transactional/navigational)
- [ ] Keyword in H1 title (natural placement)
- [ ] Keyword in first 100 words of content
- [ ] Keyword in 1-2 H2 headings (natural placement)
- [ ] Keyword in URL slug (hyphenated, lowercase)
- [ ] Long-tail variations included in H3s and body
- [ ] Content length meets blog type requirement (Authority: 1,500+, Practitioner: 800-1,200)
- [ ] Problem-first framing in opening paragraphs
- [ ] Key Takeaways section (3-5 extractable bullets)

#### Metadata & Schema (10 items)
- [ ] Meta title ≤60 characters, includes keyword + brand
- [ ] Meta description 150-160 characters, includes keyword + value + CTA
- [ ] Open Graph tags: og:title, og:description, og:image, og:url, og:type
- [ ] Twitter Card tags: twitter:card (summary_large_image), twitter:title, twitter:description, twitter:image
- [ ] Canonical URL set (self-referencing or pointing to original)
- [ ] JSON-LD Article schema: headline, author, datePublished, dateModified, image
- [ ] JSON-LD Author schema: name, url, jobTitle
- [ ] JSON-LD Organization schema: name, url, logo
- [ ] hreflang tags (if multilingual planned)
- [ ] robots meta (index, follow)

#### Structure & Linking (10 items)
- [ ] H1 → H2 → H3 hierarchy (no skipped levels)
- [ ] 3-7 H2 sections per post
- [ ] Internal links to 3-5 related posts (content cluster strategy)
- [ ] Internal links to hub/pillar page
- [ ] External links to 2-3 authoritative sources
- [ ] Anchor text descriptive (not "click here")
- [ ] Breadcrumb navigation present
- [ ] Table of Contents for posts 2,000+ words
- [ ] FAQ section (4-6 Q&A pairs) for posts 1,500+ words
- [ ] Related posts section at end of article

#### Technical & Performance (10 items)
- [ ] Images optimized (<200KB, WebP format preferred)
- [ ] Image alt text descriptive, includes keyword where natural
- [ ] Lazy loading for below-fold images
- [ ] Core Web Vitals targets: LCP < 2.5s, CLS < 0.1, FID < 100ms
- [ ] Mobile-responsive design tested
- [ ] Page load < 3s on 3G connection
- [ ] Sitemap.xml includes post URL
- [ ] Robots.txt allows indexing
- [ ] No broken internal/external links
- [ ] Code examples language-tagged and tested

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

### Social Distribution Workflow (Hour-by-Hour Day 0)

| Time | Activity | Owner | Platform |
|------|----------|-------|----------|
| **Hour 0** | Publish post, verify SEO/schema | Editor | Blog |
| **Hour 1** | Newsletter sent (automated or manual) | Marketing | ConvertKit |
| **Hour 2** | Twitter/X thread (1 main + 5-7 follow-ups) | Marketing | Twitter |
| **Hour 3** | LinkedIn post (narrative angle) | Marketing | LinkedIn |
| **Hour 4** | Respond to early comments | Writer | All platforms |
| **Hour 6** | Cross-post to Dev.to (with canonical) | Marketing | Dev.to |
| **Hour 8** | Share in Discord/Slack communities | Marketing | Community |

**Day 1-2 (Amplification):**
- [ ] Monitor engagement metrics (likes, shares, comments)
- [ ] Respond to all comments within 24 hours
- [ ] Cross-post to Hashnode/Medium if planned (with canonical URL)
- [ ] Create quote graphics for social re-sharing

**Day 3-7 (Community):**
- [ ] Submit to Hacker News (Tue/Wed/Thu, 7-9 AM EST)
- [ ] Share in Reddit communities (genuine value-add, not promotional)
- [ ] Monitor backlinks and AI citations (manual check)
- [ ] Engage with any community discussion threads

### Content Repurposing (Per Post)

| Asset | Format | Timeline | Owner |
|-------|--------|----------|-------|
| Twitter thread | 1 main + 5-7 tweets | Day 0 | Marketing |
| LinkedIn post | Long-form narrative | Day 0 | Marketing |
| Quote graphics | 3-5 images | Day 1 | Marketing |
| Newsletter segment | Excerpt + CTA | Day 0 | Marketing |
| Cross-post | Dev.to/Hashnode | Day 1 | Marketing |
| Podcast talking points | If applicable | Week 2 | Writer |

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

## Constitution Check (with Implementation Evidence)

*GATE: Must pass before beginning production. Re-check after first 3 posts published.*

[Gates determined based on constitution file in .blogkit/memory/constitution.md]

### Principle Alignment Table

| # | Principle | Status | Implementation Evidence |
|---|-----------|--------|-------------------------|
| I | **Content-First** | ✅/❌ | [e.g., "spec.md completed before plan.md, no tech choices in spec"] |
| II | **Principle-Driven Content** | ✅/❌ | [e.g., "Blog type declared (Authority), content pillars problem-first"] |
| II-A | **Evidence Standards** | ✅/❌ | [e.g., "Evidence tier identified per pillar, no Tier 4 claims"] |
| II-B | **Honest Limitations** | ✅/❌ | [e.g., "Limitations section required in editorial checklist"] |
| III | **Test-First Quality** | ✅/❌ | [e.g., "Success criteria defined in spec, tracking tools mapped"] |
| IV | **SEO-First Architecture** | ✅/❌ | [e.g., "40-point SEO checklist, keywords per pillar, JSON-LD templates"] |
| IV-A | **AI-Native Distribution** | ✅/❌ | [e.g., "JSON-LD schema, H1→H2→H3 hierarchy, FAQ sections required"] |
| V | **Incremental Delivery** | ✅/❌ | [e.g., "4-quarter content calendar, first 5 posts detailed"] |
| VI | **Observability & Measurement** | ✅/❌ | [e.g., "Plausible + GSC configured, monthly dashboard review"] |
| VII | **Simplicity & Focus** | ✅/❌ | [e.g., "Next.js + MDX (proven stack), no custom CMS before 10 posts"] |
| VIII | **Versioning** | ✅/❌ | [e.g., "Plan versioned, breaking changes documented"] |

**Principle Validation Summary**:
- Principles Passed: [X]/11
- Principles Failed: [X]/11 (list which ones)
- **Overall Status**: ✅ Ready / ❌ Blocked on [principle]

### Complexity Review

> **Fill ONLY if Constitution Check has violations that must be justified**

| Principle Violated | Justification | Risk Accepted By | Expiration |
|--------------------|---------------|------------------|------------|
| [e.g., VII Simplicity] | [e.g., "Team has Next.js expertise"] | [Owner] | [Date] |

**Note**: Exceptions expire after 3 months and require re-evaluation per constitution governance.

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

## Budget & Tool Costs

### Monthly Tool Costs

| Tool | Purpose | Cost/Month | Annual |
|------|---------|------------|--------|
| **Hosting** (Vercel/Netlify) | Deployment, CDN | $[X] | $[X] |
| **Analytics** (Plausible/GA4) | Traffic tracking | $[X] | $[X] |
| **Newsletter** (ConvertKit) | Email automation | $[X] | $[X] |
| **SEO Tools** (Ahrefs/GSC) | Keyword tracking | $[X] | $[X] |
| **Domain** | Custom URL | $[X] | $[X] |
| **Total Tools** | | **$[X]/mo** | **$[X]/yr** |

### Team Costs (if applicable)

| Role | Hours/Month | Rate | Cost/Month |
|------|-------------|------|------------|
| Writer | [X] hrs | $[X]/hr | $[X] |
| SME | [X] hrs | $[X]/hr | $[X] |
| Editor | [X] hrs | $[X]/hr | $[X] |
| Marketing | [X] hrs | $[X]/hr | $[X] |
| **Total Team** | | | **$[X]/mo** |

### Total Monthly Budget

| Category | Cost |
|----------|------|
| Tools | $[X] |
| Team | $[X] |
| **Total** | **$[X]/mo** |

---

## Constraints

**Editorial Capacity**: [e.g., "1 writer, part-time (20 hrs/week) = max 2 practitioner posts/month"]

**Budget**: [e.g., "$500/month hosting + analytics + newsletter" | "$2,000/month including freelance writers"]

**Timeline**: [e.g., "First post published within 3 weeks of plan approval"]

**Technical Constraints**: [e.g., "Must use existing company infrastructure (AWS)" | "Team only knows JavaScript frameworks"]

**Legal/Compliance**: [e.g., "All posts must pass legal review (regulated industry)" | "Cannot include confidential customer data"]

**SEO Constraints**: [e.g., "Avoid keywords already owned by competitors (rank #1 for 5+ years)" | "Focus on long-tail keywords < 5K search volume"]

---

## Risks & Mitigations (with Owners)

| # | Risk | Impact | Likelihood | Mitigation | Owner |
|---|------|--------|------------|------------|-------|
| 1 | **Content doesn't rank** | High | Medium | Keyword research upfront, target < 5K volume keywords, build backlinks through ecosystem partnerships, refresh after 90 days if no traction | Writer + Marketing |
| 2 | **Writer capacity insufficient** | Medium | High | Start with 1 post/month, hire freelancer if traction proven, batch content creation, reduce cadence before quality | Writer |
| 3 | **Technical accuracy errors** | High | Low | Mandatory SME review by non-author (NO SELF-VALIDATION), test all code examples in CI, document evidence tier for claims | SME |
| 4 | **Platform costs exceed budget** | Low | Low | Start with free tier (Vercel, Netlify), upgrade only when traffic > 50K/month, monitor costs monthly | Tech Lead |
| 5 | **Competitor publishes first** | Medium | Medium | Monitor competitor blogs weekly, pivot angle if needed, add unique data/research, cite competitor fairly | Writer |
| 6 | **SME reviewer bottleneck** | Medium | Medium | Batch reviews weekly, train backup reviewer, simplify review checklist, set 72-hour SLA | SME |
| 7 | **Algorithm/ranking change** | High | Low | Diversify traffic sources (newsletter, social), monitor GSC weekly, adapt within 2 weeks | Marketing |
| 8 | **Viral post, low conversion** | Medium | Low | Add contextual CTAs, improve lead magnets, A/B test offers, add email capture before full content | Marketing |
| 9 | **Writer burnout** | High | Medium | Sustainable cadence (quality > quantity), content batching, freelance backup, celebrate wins | Writer |

**Risk Review Cadence**: Monthly review in Phase 3 analysis

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

### Editorial & Operations
- [ ] Editorial workflow defined (4-pass process, roles, timelines)
- [ ] Roles defined with FTE allocation and hours per post type
- [ ] Team capacity validated (Required FTE ≤ Available FTE)
- [ ] Dependencies and constraints documented
- [ ] Risks identified with mitigations and owners (minimum 8 risks)
- [ ] Budget documented (tool costs + team costs if applicable)

### Technical Stack
- [ ] Technical stack chosen with rationale (CMS, framework, hosting, analytics, newsletter)
- [ ] Performance targets defined (Core Web Vitals: LCP, CLS, FID)
- [ ] Repository structure defined and documented
- [ ] Code validation process defined (CI/CD or manual testing)

### SEO & AI Optimization
- [ ] 40-point SEO checklist present and customized
- [ ] JSON-LD schema templates defined (Article, Author, Organization)
- [ ] Heading hierarchy requirements documented (H1→H2→H3)
- [ ] AI discoverability strategy documented (FAQ sections, Key Takeaways)

### Distribution & Measurement
- [ ] Distribution strategy defined (3-tier model with Day 0-7 timeline)
- [ ] Newsletter strategy defined (frequency, structure, growth tactics)
- [ ] Content calendar mapped (Year 1 plan, first 5 posts detailed)
- [ ] Success criteria tracking implementation defined (tool + formula per SC)

### Governance
- [ ] Constitution Check passed (all principles validated with evidence)
- [ ] No [NEEDS CLARIFICATION] markers remain (or research phase planned)
- [ ] Plan version documented (for future change tracking)

---

**Note**: This plan defines HOW to execute the content strategy from spec.md. Technology choices are now locked in. Tasks.md (generated by `/blogkit.tasks`) will break this plan into actionable sprints.
