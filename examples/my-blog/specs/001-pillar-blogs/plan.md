# Editorial & Technical Plan: Spec-Kit Pillar Blogs

**Branch**: `001-pillar-blogs` | **Date**: 2025-12-05 | **Spec**: [specs/001-pillar-blogs/spec.md](./spec.md)
**Input**: Blog content strategy from spec-kit methodology pillar blogs specification

---

## Summary

**Blog Type**: Authority + Practitioner Hybrid
**Target Audience**: Methodology Curious Professionals (Geeks, Engineers, PMs, Designers)
**Publishing Cadence**: 2-3 posts per week (8-12/month)
**Editorial Approach**: 3-pass review cycle with SME validation before publication
**Goal**: Establish kits.agentii.ai as canonical authority on spec-driven development and job kit methodology while driving immediate adoption through practitioner guides

**Key Success Metrics**:
- Month 3: 5K monthly visitors | Month 6: 20K | Month 12: 50K+
- 30% of posts achieving page-1 rankings within 3 months
- 50+ backlinks by Month 6, 100+ by Month 12
- 5+ AI system citations (Claude, ChatGPT, Perplexity) by Month 6

---

## Editorial Workflow

### Content Production Process

**Editorial Cycle**:
- **Authority Pillar Posts** (Pillars 1, 2, 4, 5): 4-5 weeks per post
- **Practitioner Guides** (Pillar 3): 2-3 weeks per post
- **Hybrid Model**: Parallel tracks allowing 2-3 simultaneous posts at different stages

| Phase | Duration | Activities | Owner | Tools |
|-------|----------|------------|-------|-------|
| **Research & Planning** | 4-7 days | Keyword research, competitive analysis, outline, angle determination | Writer + SME | Google Docs, Google Search Console, keyword research tools |
| **Drafting** | 7-10 days | Main content development, code examples, evidence gathering, real-world examples | Writer | GitHub (markdown), Google Docs for comments |
| **Technical Review** | 3-5 days | Code validation in clean environment, fact-checking claims, architecture review | SME (non-author) | GitHub PR, test environments |
| **Copyedit & SEO** | 3-5 days | Grammar, clarity, readability, SEO optimization, metadata, heading hierarchy | Copyeditor | Google Docs, Grammarly, Hemingway Editor |
| **Final Review & Publish** | 1-2 days | Final check, metadata validation, social assets, publish, distribution | Marketing + Editor | GitHub merge, publishing platform |
| **Distribution & Monitoring** | 7 days post-publish | Social distribution, community sharing, engagement monitoring, performance tracking | Marketing | Twitter, LinkedIn, Reddit, Dev.to, analytics dashboard |

**Total Cycle Time**:
- Authority posts: 4-5 weeks from research kickoff to full distribution
- Practitioner posts: 2-3 weeks
- Parallel execution: 2-3 posts in flight simultaneously

### 3-Pass Editorial Quality Control

**Pass 1: Structural & Clarity Edit** (Editor)
- Does outline match title's promise and search intent?
- Information in logical order (Problem → Context → Solution → Examples → Results)?
- Each section supports main thesis?
- Would target audience understand key concepts?
- Jargon appropriate for audience level (Geeks, Engineers, PMs, Designers)?

**Pass 2: Technical Accuracy** (SME, non-author)
- Do code examples run in clean environment?
- Are benchmarks current and properly cited?
- Have referenced APIs/tools/methodologies changed since drafting?
- Claims backed by research, data, or documented production experience?
- Architecture decisions justified for target audience?
- **CRITICAL**: SME must NOT be the original author (No Self-Validation principle)

**Pass 3: SEO & AI Optimization** (SEO Editor)
- H1 → H2 → H3 hierarchy clear for LLM extraction?
- Target keyword in: title, first 150 words, meta description?
- JSON-LD Article schema present and complete?
- "Key Takeaways" section included (3-5 bulleted items)?
- FAQ section present (posts 1500+ words)?
- 4-5 internal links to related content naturally placed?
- Meta description 155-160 characters?
- Code examples language-tagged and complete context?
- Open Graph and Twitter Card tags complete?
- Breadcrumb navigation metadata included?

### Roles & Responsibilities

| Role | Responsibility | Hours/Post | Critical Notes |
|------|----------------|----------|-----------------|
| **Writer** | Research, outline, draft, initial revisions based on feedback | 15-20 hrs | Domain expertise in spec-kit or assigned pillar topic |
| **Subject Matter Expert (SME)** | Technical validation, code review, accuracy check, production feasibility | 3-5 hrs | **MUST NOT be author** (constitution principle). Validates all claims. |
| **Copyeditor** | Grammar, clarity, readability, tone consistency, SEO optimization | 4-6 hrs | Works from SME-approved draft. Focuses on audience accessibility. |
| **SEO Specialist** | Final technical SEO check, metadata verification, content structure for AI | 2-3 hrs | Validates JSON-LD, heading hierarchy, keyword placement, internal linking. |
| **Marketing/Distribution** | Social copy creation, newsletter excerpt, community distribution, engagement monitoring | 3-5 hrs | Manages Day 0-7 distribution timeline. Tracks performance. |
| **Editor-in-Chief** | Approval gate before publication, final quality check, compliance with constitution | 1-2 hrs | Spot-check for brand alignment and principle adherence. |

**CRITICAL CONSTRAINT**: Technical validation MUST be completed by SME who did NOT write the post. This prevents confirmation bias and ensures accuracy from fresh perspective (No Self-Validation principle from constitution).

---

## Technical Stack

### Platform Architecture

**Content Management System (CMS)**: **Next.js 14 (App Router) + MDX**

**Rationale**:
- **Developer-first**: Team comfortable with Git workflows, markdown, version control
- **Performance**: Next.js 14 with App Router provides automatic code splitting, streaming, and excellent Core Web Vitals
- **MDX capability**: Write React components inline with markdown for interactive examples, code sandboxes
- **SEO-ready**: Built-in support for metadata, Open Graph, dynamic sitemap generation, structured data
- **AI-native**: Markdown is natively compatible with LLM training data, easy to export content for AI indexing
- **Version control**: All content in Git, perfect for spec-kit's documentation-as-code philosophy
- **Deployment preview**: Each Git branch gets automatic preview deployment (test before merge)

**Alternative considered**: Hugo (faster builds, simpler) - rejected because team prefers React components for interactive content

---

**Frontend Framework**: **Next.js 14 (App Router) with TailwindCSS**

**Rationale**:
- **App Router**: Newest Next.js paradigm with server components for better SEO and performance
- **Incremental Static Regeneration (ISR)**: Content updates within 60 seconds without rebuilds
- **TypeScript**: Type safety for component library, MDX frontmatter schemas
- **TailwindCSS**: Minimal CSS footprint, excellent Lighthouse scores
- **Dark Mode**: Built-in theme support for developer audience preference

---

**Hosting & Deployment**: **Vercel (Standard Plan)**

**Rationale**:
- **Automatic deployments**: Every push to main branch deploys automatically (minutes, not hours)
- **Preview URLs**: Each PR gets unique preview deployment for content review before merge
- **CDN**: Global edge network ensures <100ms response times (supports SEO Core Web Vitals)
- **Analytics**: Free edge analytics for page performance tracking
- **Cost**: $20-50/month for blog traffic, scales to $200+/month if traffic grows
- **Team workflow**: Seamless GitHub integration, no separate CI/CD setup needed

**Deployment Pipeline**:
1. Writer creates draft in branch (e.g., `post/spec-driven-fundamentals`)
2. Vercel automatically creates preview URL (shared with reviewers)
3. SME + Copyeditor review on preview (sees exact production experience)
4. Merge to main → Automatic production deployment
5. Blog live within 2-3 minutes of merge

---

**Performance Targets** (Lighthouse + Core Web Vitals):
- **Lighthouse**: 90+ score (mobile & desktop)
- **LCP** (Largest Contentful Paint): < 2.5 seconds
- **FID** (First Input Delay): < 100ms
- **CLS** (Cumulative Layout Shift): < 0.1
- **Page load** (3G): < 3 seconds
- **Build time**: < 2 minutes (full), < 30 seconds (incremental)
- **Sitemap generation**: Automatic, updated with each deploy

---

### Tools & Integrations

**Analytics Platform**: **Plausible Analytics (Standard)**

**Rationale**:
- **Privacy-first**: No cookies, GDPR/CCPA compliant (aligns with blog audience values)
- **Simple**: Clear dashboards (pageviews, time-on-page, referrers) without complexity of Google Analytics
- **Automated events**: Track newsletter signups, CTA clicks, code copy events
- **SEO keywords**: Integration with Google Search Console shows search queries driving traffic
- **Cost**: $20/month, reasonable for blog budget

**Metrics Tracked**:
- Pageviews (by post, by pillar)
- Unique visitors (monthly, weekly trends)
- Time on page (average, by post - target: 4+ minutes for authority posts)
- Bounce rate (target: < 40%)
- Referral sources (Google, social, direct, AI systems if trackable)
- Newsletter signup rate (goal: 12% of visitors)
- Internal link clicks (measure content journey effectiveness)

**Monthly Dashboard**: Traffic, top posts, audience geography, referral sources, conversion rates

---

**Newsletter Platform**: **ConvertKit**

**Rationale**:
- **Creator-focused**: Designed for writers + audiences, not marketers
- **Automation**: Auto-email on new post, customizable sequences
- **Subscriber growth**: Built-in referral mechanics (incentivize sharing)
- **Landing page**: Free landing page builder for growth experiments
- **Integrations**: Seamless with blog embed (single signup form)
- **Cost**: Free tier up to 1,000 subscribers, $25/month thereafter

**Newsletter Strategy**:
- **Frequency**: 1-2 emails per week (new post announcements + curated highlights)
- **Content**: Post summary (100-150 words) + 2-3 key takeaways + CTA to read full post
- **Growth**: Newsletter signup forms on every post (target 12% conversion from blog traffic)
- **Segmentation**: Track which pillars subscribers engage with (enable future personalization)
- **Goal**: 5K subscribers by Month 6 (primarily from blog traffic)

---

**SEO Tools**:

1. **Google Search Console** (Free)
   - Track keyword rankings and search queries driving traffic
   - Monitor Core Web Vitals and indexing status
   - Submit sitemaps, fix crawl errors

2. **Google Analytics 4** (Free, alongside Plausible)
   - Advanced funnel analysis (blog → newsletter → product inquiry)
   - User journey tracking
   - Goal tracking (demo requests, SDK downloads)

3. **Ahrefs** (Optional, for Month 3+)
   - Backlink analysis and growth tracking
   - Competitor content analysis
   - Keyword ranking tracking (up to 100 tracked keywords)
   - Cost: $99/month or $990/year

4. **Built-in Tools**:
   - Automatic sitemap.xml generation (Next.js)
   - robots.txt configuration
   - Open Graph + Twitter Card automation
   - JSON-LD schema generation

---

**Content Workflow & Collaboration Tools**:

| Tool | Purpose | Team |
|------|---------|------|
| **GitHub** | Content version control, PR review workflow | All |
| **Google Docs** | Collaborative drafting (comments, suggestions) | Writer + SME + Editor |
| **Notion** (Optional) | Editorial calendar, task tracking, content briefs | Editor + Marketing |
| **Grammarly** | Grammar and clarity checks during copyedit | Copyeditor |
| **Hemingway Editor** | Readability scoring (target: Grade 10-12 for authority) | Copyeditor |
| **Figma** (Optional) | Diagram and visual asset creation | Designer (if available) |

**Preferred Workflow**:
1. Editor creates content brief in Notion (topic, pillar, keyword, outline)
2. Writer drafts in Google Docs (SME can comment in real-time)
3. Upon SME approval, Writer converts to Markdown in GitHub branch
4. Copyeditor edits in GitHub (review Markdown directly)
5. SEO specialist validates on Vercel preview
6. Merge to main → Auto-publish

---

**Code Example Validation**:

**Approach**: GitHub Actions CI/CD on publish
- All code examples extracted into separate test files
- Executed in clean environment (Python, JavaScript interpreters as needed)
- Must pass without errors before merge
- Links to full runnable repos provided

**Fallback** (if CI/CD complex): Manual testing
- Each code example tested in clean environment before drafting completes
- Screenshots of working examples included in post
- Documented versions of tools/frameworks used

---

## AI Discoverability & SEO Optimization

### Nextra-Inspired SEO Architecture (referencing @refs/seo-nextra-kit.md)

**Content Structure & Hierarchy**:
- **Clear URL structure**: `/specification-patterns/`, `/job-kits/`, `/ai-workflows/` (pillar-based paths)
- **Breadcrumb navigation**: Metadata support for site structure understanding
- **Semantic HTML**: Proper heading hierarchy (H1 → H2 → H3 → H4)
- **Related posts**: Sidebar with 5-7 related articles for topical authority
- **Content clusters**: All Pillar 1 posts link to each other; Pillar 2 posts form cross-domain cluster

**Site Structure**:
```
blog/
├── index (homepage with latest posts, pillar overview)
├── specification-patterns/
│   ├── what-is-spec-driven-development/ (hub post, 3000+ words)
│   ├── spec-kit-vs-traditional-development/
│   ├── 4-file-architecture-explained/
│   └── [Pillar 1 posts link to each other]
├── job-kits/
│   ├── job-kit-patterns-across-professions/ (hub post)
│   ├── pm-kit-for-product-managers/
│   ├── design-kit-design-systems/
│   └── [Pillar 2 posts form cross-domain cluster]
├── building-custom-kits/
│   ├── how-to-build-your-own-job-kit/
│   ├── constitution-writing-guide/
│   └── [Pillar 3 practitioner guides]
├── research-insights/
│   ├── survey-how-teams-plan/
│   └── [Pillar 4 original research]
└── ai-workflows/
    ├── ai-agents-interpreting-specifications/
    └── [Pillar 5 AI integration posts]
```

---

### AI-Native Content Structure

**JSON-LD Article Schema** (Required for all posts):
```json
{
  "@context": "https://schema.org",
  "@type": "BlogPosting",
  "headline": "[Post title]",
  "description": "[Meta description]",
  "author": {
    "@type": "Person",
    "name": "[Author name]",
    "url": "[Author bio URL]"
  },
  "datePublished": "[ISO date]",
  "dateModified": "[ISO date]",
  "image": "[Feature image URL]",
  "keywords": ["keyword1", "keyword2"],
  "articleBody": "[Content]"
}
```

**Heading Hierarchy for LLM Parsing** (Strictly enforced):
- **H1**: Post title only (1 per page)
- **H2**: Major sections (3-7, includes: Problem, Solution, Implementation, Results, Takeaways)
- **H3**: Subsections (2-5 per H2, detailed explanations)
- **H4**: Details only (rarely used, sub-subsections)

**Example Structure for Authority Post**:
```
# [H1] What is Spec-Driven Development? Complete Mental Model
  ## [H2] The Problem: Why Specifications Fail
    ### [H3] Ambiguity Costs (Research-backed)
    ### [H3] Rework from Miscommunication
  ## [H2] The Solution: Spec-Driven Development Framework
    ### [H3] 4-File Architecture
    ### [H3] How It Works Across Professions
  ## [H2] Real-World Results & Case Studies
    ### [H3] Engineering Team Example
    ### [H3] Product Management Example
  ## [H2] Key Takeaways (Extractable for AI)
  ## [H2] Getting Started
```

---

**Explicit Concept Definitions**:
- Define key terms in first mention (e.g., "Spec-Driven Development (SDD) is...")
- Glossary section for posts 2000+ words
- Link to foundational concepts (e.g., Pillar 1 posts from Pillar 2+ posts)
- FAQ section for posts 1500+ words (AI systems extract FAQs for synthesis)

**Code Example Best Practices for AI**:
- Use language tags: ` ```python`, ` ```javascript`, ` ```yaml`
- Complete, runnable examples (not fragments)
- Context comments explaining what code does
- Link to full GitHub repos for extended code
- Include error examples + how to fix them

**Example Code Block**:
````markdown
```python
# Constitutional guidance for AI agents
constitution = {
  "rules": [
    "Validate all inputs before processing",
    "Fail explicitly with clear error messages"
  ]
}

# AI agent reads and follows constitution
agent = SpecDrivenAgent(constitution=constitution)
result = agent.execute(specification)
```

**Run this in:** Python 3.10+
**Dependencies:** `pip install spec-kit-ai`
**Full example:** [GitHub Repo Link](github.com/example)
````

---

**"Key Takeaways" Section** (Extractable for AI systems):
Every post 1500+ words MUST include a bulleted "Key Takeaways" section (3-5 items). AI systems extract and synthesize these into summaries.

```markdown
## Key Takeaways

- **Specification clarity reduces rework**: Teams using structured specifications report 50%+ reduction in engineering rework (cite research)
- **Job kits apply universally**: The same pattern works across professions (link to job kit examples)
- **Start simple**: Begin with constitution-spec-plan-tasks cycle; add tools/automation after 5-10 cycles
- **Measure outcomes**: Define success criteria before implementation; track and iterate
```

---

### SEO Implementation Checklist (Pre-Publish Gate)

**Keyword & Targeting** (Week 1 of writing):
- [ ] Primary keyword identified (< 10,000 monthly search volume Month 1-3, lower = better)
- [ ] Secondary keywords identified (2-3, related long-tail variants)
- [ ] Search intent validated (match user need, not just keyword volume)
- [ ] Competitive analysis done (top 5 posts ranking for keyword reviewed)

**On-Page SEO** (During copyedit, Pass 3):
- [ ] Keyword naturally placed in: title, first 150 words, H2 headings
- [ ] Meta description 155-160 characters, includes keyword, compelling
- [ ] URL slug descriptive and keyword-optimized (e.g., `/building-custom-kits/how-to-build-your-own-job-kit/`)
- [ ] H1 → H2 → H3 hierarchy clear and semantic
- [ ] "Key Takeaways" section present (3-5 items, extractable for AI)
- [ ] FAQ section present (posts 1500+ words)

**Structured Data & Markup** (Technical check):
- [ ] JSON-LD Article schema complete and valid
- [ ] Open Graph tags: og:title, og:description, og:image, og:url
- [ ] Twitter Card tags: twitter:card, twitter:title, twitter:description, twitter:image
- [ ] Canonical URL set (self-referential for single posts)
- [ ] Author schema includes author bio + URL
- [ ] Breadcrumb navigation metadata included

**Content Structure for AI**:
- [ ] Explicit concept definitions (no jargon without explanation)
- [ ] Code examples language-tagged and complete context
- [ ] External links to 2+ authoritative sources (credibility signals)
- [ ] Internal links to 4-5 related posts (content cluster for topic authority)

**Images & Visuals**:
- [ ] All images have descriptive alt text (includes keyword where natural)
- [ ] Feature image optimized (< 200KB, high quality for social)
- [ ] Diagrams/flowcharts included (complex topics benefit from visuals)
- [ ] Visual hierarchy clear (headers, formatting, emphasis)

**Readability & Accessibility**:
- [ ] Readability score: Flesch-Kincaid Grade 10-14 (authority), 10-12 (practitioner)
- [ ] Sentence variety (mix short and long sentences)
- [ ] Paragraph breaks (3-5 sentences max per paragraph)
- [ ] WCAG 2.1 AA compliance (color contrast, keyboard navigation)
- [ ] No auto-playing media (videos should require click)

**Distribution Readiness**:
- [ ] Social media assets created (Twitter thread template, LinkedIn post template)
- [ ] Newsletter excerpt prepared (100-150 words)
- [ ] Hacker News title crafted (if applicable, "Show HN" format)
- [ ] Reddit/community copy prepared (if applicable)
- [ ] CTA clear and visible (newsletter signup, related post, product)

---

## Distribution Strategy

### 3-Tier Distribution Model (referencing @refs/blog-ai-kit.md top blogs)

**Tier 1: Owned Channels** (Direct audience control)
- **Company blog** (kits.agentii.ai/blog - primary home)
- **Email newsletter** (ConvertKit - 1-2 emails/week, 5K target subscribers Month 6)
- **RSS feed** (auto-generated by Next.js)
- **YouTube** (optional, video tutorials for top-performing posts Month 4+)

**Tier 2: Amplification Platforms** (Extend reach 10-50x)
- **Twitter/X** (daily presence, threading strategy)
- **LinkedIn** (2-3x per week, audience-specific framing)
- **Dev.to** (cross-post within 48 hours, canonical link back)
- **Hashnode** (developer-specific, Month 2+)
- **Medium** (optional, less priority than Dev.to)

**Tier 3: Community Engagement** (Highest intent, slowest ramp)
- **Hacker News** ("Show HN" for authority posts, Tue/Wed/Thu 7-9 AM EST)
- **Reddit** (r/ProductManagement, r/webdev, r/programming, r/design - community-relevant subreddits)
- **Discord/Slack** (AIEngineer Slack, LangChain Discord, product communities - share only when relevant)
- **GitHub Discussions** (if spec-kit repo has discussions)
- **Indie Hackers** (product-focused audience)

---

### Social Distribution Workflow (Day 0-14 Post-Publish)

**Day 0 (Publish Day)**:
- [ ] Publish post on main blog (8 AM UTC for maximum reach)
- [ ] Newsletter auto-sends to subscribers (ConvertKit integration)
- [ ] Twitter thread posted (3-7 tweets, key takeaways, link, CTA)
  - Tweet 1: Hook + problem statement
  - Tweets 2-5: Key insights, examples, solutions
  - Tweet 6: Key takeaway + link
  - Tweet 7: CTA (newsletter signup, reply with thoughts)
- [ ] LinkedIn post (narrative angle, audience-specific, link, CTA)
- [ ] Monitor comments/replies on all platforms (respond within 4 hours)

**Day 1-2 (Amplification)**:
- [ ] Cross-post to Dev.to with canonical URL tag (if post 1000+ words)
- [ ] Share in relevant Slack/Discord communities (Genuine participation, 1-2 communities max)
- [ ] Respond to all comments on blog, Twitter, LinkedIn
- [ ] Retweet/like supportive responses (amplify reach)

**Day 3-7 (Authority Building)**:
- [ ] If eligible: Submit to Hacker News as "Show HN" (Tuesday-Thursday, 7-9 AM EST)
- [ ] Share in Reddit communities (1-2 relevant subreddits, genuine engagement)
- [ ] Email partners/influencers for potential coverage
- [ ] Check if featured in "People Also Ask" or other search features

**Week 2-4 (Sustained Engagement)**:
- [ ] Monitor Hacker News comments (if submitted), respond thoughtfully
- [ ] Track Reddit thread (engage with genuine questions, defend arguments)
- [ ] Check keyword rankings on Google Search Console (should see improvement by Day 10-14)
- [ ] Gather backlinks (external sites linking to post)
- [ ] Identify opportunities for guest posts (complement with external coverage)

---

### Content Repurposing & Long-Tail Strategy

**Each Authority Post Generates**:
- 1 Twitter thread (5-7 tweets)
- 1 LinkedIn post (250-300 words, narrative angle)
- 1 Newsletter segment (100-150 words summary)
- 1 Dev.to cross-post (with canonical link)
- 3-5 social media quote graphics (key takeaways as standalone graphics)
- 1 "TL;DR" snippet (100 words for AI systems)
- Follow-up opportunity identified (Next related post in cluster)

**Measurement & Optimization** (Week 2 post-publish):
- Check traffic sources (organic search vs. social vs. referral)
- Analyze time-on-page (target 4+ minutes for authority, 2+ for practitioner)
- Newsletter signup rate from this post (target 12%+)
- Identify low-performing sections (scroll-through data from Plausible)
- Plan content refresh if underperforming (Month 4+)

---

## Content Calendar & Production Plan

### Year 1 Quarterly Targets

**Q1 (Foundation Phase)**: 24-28 posts total
- 4-5 Pillar 1 posts (Spec-Driven Development Fundamentals)
- 3-4 Pillar 2 posts (Job Kit Patterns - introduce 1-2 professions)
- 3-4 Pillar 3 posts (Building Custom Kits)
- 2-3 Pillar 4 posts (Original Research, Case Studies)
- 2-3 Pillar 5 posts (AI-Augmented Workflows)
- **Focus**: SEO foundation, keyword authority, building backlink relationships
- **Target**: 5K monthly visitors by end of Q1

**Q2 (Expansion Phase)**: 30-35 posts total
- 4-5 Pillar 2 posts (Complete all profession coverage: PM, Design, Sales, Operations, Marketing)
- 5-6 Pillar 3 posts (Deep implementation guides, audience-specific templates)
- 4-5 Pillar 5 posts (AI workflows, Claude Code integration, case studies)
- 2-3 Pillar 1 posts (Refresh, extend with advanced concepts)
- 2-3 Pillar 4 posts (Second wave original research)
- **Focus**: Audience-specific content tracks, expanded reach, product adoption
- **Target**: 20K monthly visitors by end of Q2

**Q3 (Authority Phase)**: 35-40 posts total
- Maintain 2-3 posts/week across all pillars
- 3+ original research projects or case studies (high-effort, high-reward)
- Introduction of community-contributed content (guest posts from spec-kit practitioners)
- Advanced implementation guides for niche use cases (vertical-specific kits)
- **Focus**: Defend SEO positions, thought leadership, community engagement
- **Target**: 35K monthly visitors by end of Q3

**Q4 (Maturity Phase)**: 30-35 posts total
- Consolidation + strategy shift based on Q1-Q3 learnings
- Refresh of top-performing posts (based on analytics)
- Advanced content (AI-driven automation, multi-agent patterns, enterprise kits)
- Year-end retrospective (what worked, what didn't, Year 2 strategy)
- **Focus**: Sustained authority, product integration, brand lift
- **Target**: 50K+ monthly visitors by end of Q4

---

### Year 1 Cumulative Targets

| Metric | Month 3 | Month 6 | Month 9 | Month 12 |
|--------|---------|---------|---------|----------|
| **Monthly Visitors** | 5K | 20K | 35K | 50K+ |
| **Newsletter Subscribers** | 1.5K | 3K | 4K | 5K+ |
| **Page-1 Keywords** | 10+ | 20+ | 35+ | 50+ |
| **Backlinks** | 10-15 | 50+ | 75+ | 100+ |
| **AI Citations** | 2-3 | 5+ | 12+ | 20+ |
| **Guest Post Offers** | 1-2 | 3-5 | 5-8 | 8-10 |
| **Domain Authority** | 15-18 | 25-30 | 32-35 | 35-40 |

---

### First 5 Authority Posts (Foundation Set)

These 5 posts form the SEO foundation for all other content. Published Month 1-2.

**Post 1: Pillar 1 Hub - "What is Spec-Driven Development? Complete Mental Model"**
- **Word Count**: 3,500+
- **Target Keyword**: "spec-driven development" (3K search volume, moderate competition)
- **Goal**: Establish foundational understanding, hub post for Pillar 1
- **Includes**: 4-file architecture diagram, comparison table (vs. agile/traditional), case study
- **Internal Links**: To future Pillar 1 posts (2-3), Pillar 2 posts (1-2)
- **Timeline**: Week 1-4 (Research, Draft, SME Review, Copyedit)

**Post 2: Pillar 2 Cross-Domain - "How Product Managers Use Spec-Driven Development"**
- **Word Count**: 2,500
- **Target Keyword**: "product manager specifications" (1.5K search volume, low competition)
- **Goal**: Show job kit pattern in PM domain, drive PM audience engagement
- **Includes**: PM-specific constitution example, spec template, case study
- **Audience**: Product managers, product leads
- **Internal Links**: Post 1 (foundation), other Pillar 2 posts (as published)
- **Timeline**: Week 2-5

**Post 3: Pillar 3 Practitioner - "How to Build Your Own Job Kit (7-Step Framework)"**
- **Word Count**: 2,000
- **Target Keyword**: "how to build job kit" or "job kit framework" (500-1K search volume, very low competition)
- **Goal**: Drive adoption with actionable how-to guide
- **Includes**: Step-by-step framework, template downloads, checklist
- **Includes**: Code examples in YAML (constitution template)
- **Internal Links**: Post 1 (foundation), Post 2 (examples from other domains)
- **Timeline**: Week 3-6

**Post 4: Pillar 4 Original Research - "Survey: How Teams Currently Plan (And Why It Fails)"**
- **Word Count**: 2,500+
- **Target Keyword**: "team planning problems" or "requirements specification failures" (2-3K search volume)
- **Goal**: Generate backlinks through original research, establish authority
- **Includes**: Survey methodology, data visualization, key findings, analysis
- **Audience**: CTOs, engineering leaders, project managers
- **Internal Links**: Post 1-3 (connect research to solutions)
- **Timeline**: Week 4-8 (Research takes longer)

**Post 5: Pillar 5 AI Integration - "How to Use Claude Code with Spec-Driven Development"**
- **Word Count**: 2,000
- **Target Keyword**: "Claude Code specifications" or "AI agents with specifications" (2-4K search volume)
- **Goal**: Showcase product value, demonstrate kits.agentii.ai positioning
- **Includes**: Step-by-step tutorial, code examples, screenshot walkthrough, case study
- **Audience**: Developers, AI engineers, technical founders
- **Internal Links**: Post 1 (foundation), Post 3 (how to build kit)
- **Timeline**: Week 5-8

---

## Constitution Check (8 Principles Validation)

| Principle | Definition | Validation ✓ | Implementation |
|-----------|-----------|----------|-----------------|
| **Content-First** | Tech choices AFTER content strategy | ✓ PASS | Spec.md defined first (zero tech mentions), plan.md adds tech only now |
| **No Self-Validation** | SME review by non-author | ✓ PASS | Editorial workflow requires Pass 2 review by different person |
| **Simplicity & Focus** | No custom CMS before 10 posts | ✓ PASS | Using battle-tested Next.js + Vercel, no custom infrastructure |
| **AI-Native Distribution** | JSON-LD, H2/H3, FAQ sections | ✓ PASS | All posts include JSON-LD, heading hierarchy, key takeaways (FAQ-like) |
| **Community Over Broadcast** | Amplify community voices | ✓ PASS | Tier 3 distribution includes Reddit, HN, Discord/Slack community engagement |
| **Transparency Over Perfection** | Document edge cases, failures | ✓ PASS | Risk mitigation plan (below) addresses potential failures + contingencies |
| **Long-term Over Quick Wins** | 2-3 year strategy | ✓ PASS | Year 1 plan spans 12 months with Q1-Q4 progression, not viral chasing |
| **Measurable Outcomes** | Each SC has tracking implementation | ✓ PASS | 16 success criteria from spec.md, each has measurement tool defined (below) |

**Conclusion**: All 8 principles validated ✓. Plan adheres to constitution.

---

## Success Criteria Tracking Implementation

For each Success Criterion from spec.md, define how it will be measured:

### Content Performance & SEO Metrics

| SC | Success Criterion | Measurement Tool | Formula/Check | Review Cadence |
|----|-------------------|------------------|------|-----------------|
| SC-001 | 5K visitors Month 3, 20K Month 6, 50K+ Month 12 | Plausible Analytics | Monthly unique visitors graph | Weekly (reported monthly) |
| SC-002 | 60%+ organic search traffic by Month 6 | Plausible + Google Analytics | (Organic visits / Total visits) * 100 | Monthly |
| SC-003 | 4+ min avg time-on-page | Plausible Analytics | Average duration per post | Weekly |
| SC-004 | 30% posts page-1 for target keyword within 3 months | Google Search Console | Keyword rankings (position < 11) | Weekly |
| SC-005 | 3+ backlinks per post within 6 months | Ahrefs (Month 2+) or manual | Backlinks per post avg | Bi-weekly (automated export) |

### Engagement & Adoption Metrics

| SC | Success Criterion | Measurement Tool | Formula/Check | Review Cadence |
|----|-------------------|------------------|------|-----------------|
| SC-006 | 12%+ newsletter signup rate | ConvertKit | (Signups / Blog visitors) * 100 | Weekly |
| SC-007 | 100+ social shares per post (2 weeks) | Twitter/LinkedIn native analytics | Sum of likes/retweets + DEV.to shares | Per post (2 weeks post-publish) |
| SC-008 | 25%+ internal link CTR | Plausible (event tracking) | Internal link clicks / post visitors | Weekly |
| SC-009 | 15% of visitors go to kits.agentii.ai pages | Plausible + Google Analytics | Visitors who navigate to product site | Weekly |

### Authority & Thought Leadership Metrics

| SC | Success Criterion | Measurement Tool | Formula/Check | Review Cadence |
|----|-------------------|------------------|------|-----------------|
| SC-010 | 50+ backlinks Month 6, 100+ Month 12 | Ahrefs | Total backlink count (filtered for quality) | Bi-weekly |
| SC-011 | 5+ AI citations Month 6, 20+ Month 12 | Manual (quarterly check) | Search "site:[domain]" + "ai agent" in Claude, ChatGPT, Perplexity | Quarterly |
| SC-012 | Featured in 2+ publications by Month 12 | Manual tracking | List of external publications mentioning blog | Quarterly |
| SC-013 | 3+ guest post invitations by Month 12 | Email tracking | Inbound emails offering collaboration | Ongoing tracking |

### Business Impact Metrics

| SC | Success Criterion | Measurement Tool | Formula/Check | Review Cadence |
|----|-------------------|------------------|------|-----------------|
| SC-014 | 10% of inquiries cite blog by Month 6 | CRM note tracking | (Blog-attributed inquiries / Total inquiries) * 100 | Monthly |
| SC-015 | 5K newsletter subscribers by Month 6 | ConvertKit | Total subscriber count | Weekly |
| SC-016 | 2+ customer quotes from blog by Month 12 | CRM tracking | References to blog in customer success stories | Quarterly |

---

## Dependencies & Constraints

### Editorial Team Requirements

**Minimum Team** (for 8-12 posts/month):
- **1 Full-time Writer/Editor** (15-20 hrs/post × 2-3 posts/week = 30-60 hrs/week)
- **1 Part-time SME** (3-5 hrs/post × 2-3 posts/week = 6-15 hrs/week)
- **1 Part-time Copyeditor** (4-6 hrs/post × 2-3 posts/week = 8-18 hrs/week)
- **1 Part-time Marketing/Distribution** (3-5 hrs/post × 2-3 posts/week = 6-15 hrs/week)

**Total**: ~60-110 hours/week for 8-12 posts/month
**Cost estimate** (US rates): $8K-12K/month in salaries

**Scaling options** (if capacity constrained):
- Month 1-3: In-house team only
- Month 4-6: Consider freelance writer (£15-30/hr) for 1-2 posts/month
- Month 7+: Build community contribution program (pay top community authors $100-300 per guest post)

---

### Technology Infrastructure

**Services & Costs** (Year 1):
| Service | Tier | Cost | Notes |
|---------|------|------|-------|
| Vercel Hosting | Pro | $50/mo | Scales to $500+/mo with traffic, auto-scales on popularity |
| Plausible Analytics | Standard | $20/mo | Privacy-first, no cookies, GDPR compliant |
| ConvertKit Newsletter | Standard | $0-25/mo | Free up to 1K subscribers, $25/mo 1K-10K |
| Domain (kits.agentii.ai) | Annual | $15 | Already owned |
| Ahrefs SEO Tool | Lite | $99/mo | Start Month 2+, can drop if budget tight |
| **Total** | | ~$185/mo | ~$2.2K/year |

**GitHub & Figma** (assumed free/existing):
- GitHub: Free tier sufficient for blog
- Figma: Free tier for diagrams (or use Excalidraw/Mermaid for free)

---

### Content Resources & Expertise

**Domain Experts Needed**:
- **Spec-Kit Expert** (for Pillar 1 validation): GitHub spec-kit creators or experienced practitioners
- **Cross-Domain Practitioners**: PMs, designers, engineers, founders using spec-kits
- **AI/LLM Expert** (for Pillar 5): Experience with Claude, AI agents, prompt engineering

**Content Assets Needed**:
- GitHub access (repo links, code examples)
- Permission from case study subjects (anonymized if needed)
- Diagrams/flowcharts (can be created with Mermaid or Figma)

---

### External Dependencies

**Critical**:
- GitHub spec-kit repository (for linking, benchmarking)
- Domain registration (kits.agentii.ai - already owned)
- Email delivery (ConvertKit, Mailchimp - for newsletter)
- DNS configuration (pointing to Vercel)

**Important**:
- Google Search Console setup (for keyword tracking)
- Google Analytics 4 property (for detailed analytics)
- Ahrefs account (for backlink tracking, Month 2+)

**Optional**:
- Social media accounts (Twitter, LinkedIn - assumed active)
- Discord/Slack communities (for community distribution)

---

### Budget & Timeline Constraints

**Budget**: ~$2.2K/year in tools + $8K-12K/month in team (if hiring)
**Existing**: Domain + GitHub + Vercel free tier already in place

**Timeline**:
- Week 1-2: Team onboarding, tool setup, first content brief
- Week 3-4: First 2 posts in pipeline (concurrent drafting)
- Week 5+: Full production cadence (2-3 posts/week)
- Month 3: First major success metrics visible (5K traffic, 30% of posts ranking page 1)

---

## Risk Mitigation Plan

| Risk | Likelihood | Impact | Mitigation | Contingency |
|------|-----------|--------|------------|------------|
| **Content doesn't rank** (no SEO traction) | Medium | High | Keyword research pre-writing, focus low-competition keywords Month 1-3, internal linking strategy | Month 4: Repurpose underperforming posts as guest articles elsewhere |
| **Writer capacity burnout** (8-12 posts/month too much) | Medium | High | Start conservative (6-8 posts/month), hire freelancer if trending underserves | Reduce cadence to 1-2 posts/week, focus on quality over quantity |
| **Low newsletter conversion** (< 12% signup rate) | Low | Medium | Clear CTAs, landing page optimization, email incentive (free template) | A/B test signup form location, offer improved lead magnet |
| **Technical errors in code examples** (damages credibility) | Low | High | SME code review + CI/CD testing of examples | Manual testing checklist, version pinning for all code |
| **Competitor content outranks** (GitHub, Anthropic blogs) | Medium | Medium | Angle differentiation (job kits angle unique), focus audience-specific content, original research | Monitor weekly, pivot angle/examples within 2 weeks of competitor post |
| **Negative comments/trolling on Hacker News** | Low | Low | Respond with data/evidence, address valid criticism, move on | Don't escalate, focus on supportive community members |
| **Tool failure** (Vercel down, ConvertKit outage) | Very Low | Medium | Use backup tools (Netlify for hosting, Mailchimp for email) | Maintain DNS/email redundancy |
| **Over-engineering delays launch** | Medium | High | Follow Simplicity principle, use battle-tested stack (Next.js + Vercel + ConvertKit) | Revert to simpler solution immediately |

---

## Phases & Milestones

### Phase 0: Research & Setup (Week 1-2, if needed)
- [ ] Gather missing specifications (if any)
- [ ] Team onboarding on editorial workflow
- [ ] Tool setup (Plausible, ConvertKit, GitHub branch strategy)
- [ ] Content calendar planning

### Phase 1: Platform Setup & Editorial Foundation (Week 1-2)
- [ ] Next.js + MDX blog deployed to Vercel
- [ ] Domain SSL certificate (auto-Vercel)
- [ ] Newsletter signup form embedded
- [ ] Analytics tracking verified
- [ ] GitHub PR workflow tested
- [ ] First content brief prepared

### Phase 2: Content Production (Week 3-14, ~12 weeks)
- [ ] Publish first 24-28 foundation posts (Weeks 3-14)
- [ ] All 5 authority posts completed (Weeks 4-10)
- [ ] SEO optimization applied to all posts
- [ ] Internal linking strategy executed (content clusters)
- [ ] Distribution cadence established (Twitter, LinkedIn, Dev.to)
- [ ] Newsletter grows to 1.5K subscribers

### Phase 3: Measurement & Iteration (Week 15-18, ~4 weeks at end of Month 3)
- [ ] Analyze traffic patterns (organic vs. social vs. referral)
- [ ] Identify top-performing posts (traffic, engagement, conversions)
- [ ] Conduct SEO audit (keyword rankings, backlinks, technical issues)
- [ ] Iterate on underperforming content (refresh, reposition)
- [ ] Plan Q2 expansion (Pillar 2 & 3 focus)
- [ ] Target metrics: 5K monthly visitors, 1.5K subscribers, 10+ page-1 keywords

---

## Project Structure

### Blog Repository Structure
```
kits.agentii.ai/
├── app/                          # Next.js app directory
│   ├── blog/
│   │   ├── [slug]/               # Individual post routes
│   │   └── page.tsx              # Blog index/homepage
│   ├── layout.tsx                # Global layout
│   └── page.tsx                  # Homepage
├── content/                       # All blog posts (MDX)
│   ├── specification-patterns/
│   │   ├── what-is-spec-driven-development.mdx
│   │   └── ...
│   ├── job-kits/
│   │   ├── pm-kit-for-product-managers.mdx
│   │   └── ...
│   └── ...
├── public/                        # Static assets (images, diagrams)
│   ├── images/
│   ├── diagrams/
│   └── ...
├── lib/                           # Utilities
│   ├── generateRss.ts            # RSS feed generation
│   ├── generateSitemap.ts        # Sitemap generation
│   ├── getAllPosts.ts            # Post fetching
│   └── metadata.ts               # SEO metadata helpers
├── package.json                  # Dependencies (Next.js, MDX, Tailwind, etc.)
├── next.config.js                # Next.js configuration
├── tailwind.config.js            # Tailwind CSS config
├── tsconfig.json                 # TypeScript config
├── .gitignore
└── README.md
```

### Documentation Directory
```
docs/
├── editorial-guide.md            # Writer guidelines, tone, standards
├── seo-checklist.md              # Pre-publish SEO verification
├── content-templates/
│   ├── authority-post-template.md
│   ├── practitioner-guide-template.md
│   └── research-case-study-template.md
├── keyword-strategy.md           # Keyword targets by pillar/quarter
└── brand-guidelines.md           # Voice, tone, audience-specific language
```

---

## Next Steps (Prerequisites for `/blogkit.tasks`)

Before generating tasks, verify:

- [ ] **Editorial team confirmed** (writer, SME, copyeditor minimum identified)
- [ ] **Technology stack approved** (Next.js + Vercel + ConvertKit + Plausible all acceptable)
- [ ] **Budget approved** ($2.2K/year tools + team salaries)
- [ ] **First content brief ready** (Pillar 1 hub post outline prepared)
- [ ] **Domain & GitHub configured** (kits.agentii.ai DNS pointing to Vercel, repo created)
- [ ] **Success metrics dashboard drafted** (Plausible and ConvertKit accounts created)

**Once approved, next command**: `/blogkit.tasks`
This will generate Month 1-3 article-level tasks with dependencies, sequencing, and team assignments.

---

## References & Resources

**SEO Best Practices**: @refs/seo-nextra-kit.md (Nextra/Next.js site architecture, content structure, keyword strategy)
**AI Blog Best Practices**: @refs/blog-ai-kit.md (Tier 1-6 blogs, key themes in AI content, context engineering patterns)
**Spec-Kit Philosophy**: @refs/README_spec-kit.md (core concepts, supported agents, methodology)
**Blog Principles**: Constitution document (8 core blog principles, governance)

