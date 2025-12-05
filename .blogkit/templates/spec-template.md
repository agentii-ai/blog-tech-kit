# Blog Content Strategy Specification: [BLOG/CONTENT INITIATIVE NAME]

**Feature Branch**: `[###-feature-name]`
**Created**: [DATE]
**Status**: Draft
**Input**: User description: "$ARGUMENTS"

<!--
  IMPORTANT: This specification defines WHAT content you want to create and WHY.
  DO NOT include HOW it will be implemented (CMS, frameworks, hosting, tech stack).

  Focus on:
  - Content strategy and audience needs
  - Blog type and content pillars
  - Publishing cadence and success metrics
  - Distribution and engagement goals

  Technology choices belong in plan.md, NOT here.
-->

## Blog Type Declaration *(mandatory)*

<!--
  Define which blog type you're building. This determines content strategy and success metrics.
-->

**Blog Type**: [Authority | Practitioner | Community | Thought Leadership]

**Rationale**: [Why this blog type? What business/audience need does it address?]

**Content Strategy Alignment**:
- **Authority**: Deep research, original insights, canonical content (6-12 month ROI)
- **Practitioner**: Tutorials, how-to guides, production patterns (1-3 month ROI)
- **Community**: Contributor spotlights, case studies, user stories (ongoing engagement)
- **Thought Leadership**: Executive perspective, industry analysis, vision pieces (brand building)

---

## Target Audience *(mandatory)*

### Primary Audience

**Persona**: [e.g., "Senior ML Engineers building production LLM systems"]

**Use Cases**:
- [Primary use case 1]
- [Primary use case 2]
- [Primary use case 3]

**Pain Points**:
- [Pain point 1 that content will address]
- [Pain point 2 that content will address]
- [Pain point 3 that content will address]

**Where They Are**:
- [Platform/community 1 where they hang out]
- [Platform/community 2 where they hang out]
- [Platform/community 3 where they hang out]

### Secondary Audience *(optional)*

**Persona**: [e.g., "Engineering Managers evaluating AI tools"]

**Use Cases**: [How they'll use this content differently]

---

## Content Pillars *(mandatory)*

<!--
  3-5 core themes that align with product value and audience needs.
  Each pillar should be problem-first, not technology-first.
-->

### Pillar 1: [Problem-Focused Title]

**Description**: [What problem does this pillar address?]

**Example Topics**:
- [Topic 1]
- [Topic 2]
- [Topic 3]

**Product Connection**: [How does this relate to your product/service?]

---

### Pillar 2: [Problem-Focused Title]

**Description**: [What problem does this pillar address?]

**Example Topics**:
- [Topic 1]
- [Topic 2]
- [Topic 3]

**Product Connection**: [How does this relate to your product/service?]

---

### Pillar 3: [Problem-Focused Title]

**Description**: [What problem does this pillar address?]

**Example Topics**:
- [Topic 1]
- [Topic 2]
- [Topic 3]

**Product Connection**: [How does this relate to your product/service?]

---

[Add Pillars 4-5 if needed, following the same format]

---

## Publishing Cadence *(mandatory)*

**Frequency**: [e.g., "2-4 posts per month" | "1 post per quarter" | "4-8 posts per month"]

**Rationale**: [Why this cadence? Consider team capacity and blog type]

**Content Calendar Strategy**:
- **Month 1-3**: [Foundation phase - what types of posts?]
- **Month 4-6**: [Expansion phase - what types of posts?]
- **Month 7-12**: [Authority phase - what types of posts?]

---

## User Scenarios & Content Journeys *(mandatory)*

<!--
  How will different audiences discover, consume, and engage with your content?
-->

### Content Journey 1 - [e.g., "Discovery via Search"] (Priority: P1)

**Scenario**: [User searches for "[specific problem]" on Google, finds your post, reads it, and...]

**Why this priority**: [e.g., "SEO is primary driver of organic traffic"]

**Success Indicators**:
- [e.g., "User spends 3+ minutes on post"]
- [e.g., "User clicks internal links to related content"]
- [e.g., "User shares post or bookmarks it"]

**Content Requirements**:
- SEO-optimized titles and meta descriptions
- Clear problem-solution structure
- Internal links to content cluster
- Code examples (if practitioner blog)

---

### Content Journey 2 - [e.g., "Viral Discovery via Social"] (Priority: P2)

**Scenario**: [User sees post shared on Twitter/LinkedIn, clicks through, reads, and...]

**Why this priority**: [e.g., "Social amplification extends reach"]

**Success Indicators**:
- [e.g., "Post gets 50+ shares on primary platform"]
- [e.g., "User follows blog/newsletter after reading"]
- [e.g., "User comments or engages with thread"]

**Content Requirements**:
- Attention-grabbing hooks and TLDR
- Twitter thread-friendly structure
- Shareable quotes and takeaways
- Visual assets (diagrams, screenshots)

---

### Content Journey 3 - [e.g., "AI Citation & Discovery"] (Priority: P3)

**Scenario**: [User asks ChatGPT/Claude about "[topic]", AI cites your post, user clicks through...]

**Why this priority**: [e.g., "AI systems are becoming primary discovery channel"]

**Success Indicators**:
- [e.g., "Post appears in AI system responses"]
- [e.g., "User finds comprehensive answer in post"]
- [e.g., "User explores related content"]

**Content Requirements**:
- Clear heading hierarchy (H1 → H2 → H3)
- Structured data (JSON-LD Article schema)
- Explicit key concept definitions
- Complete, extractable code examples

---

[Add more content journeys as needed]

### Edge Cases

- What if content doesn't rank in search within 3 months?
- How do we handle outdated content (e.g., API changes)?
- What if viral post drives traffic but low conversion?
- How do we respond to negative comments or criticism?
- What if competitor publishes similar content first?

---

## Content Requirements *(mandatory)*

<!--
  Functional requirements for content production and distribution.
  Focus on WHAT needs to happen, not HOW it's implemented.
-->

### Content Production

- **CR-001**: Each post MUST follow 4-pass editorial process (research → draft → review → final edit)
- **CR-002**: Code examples MUST be tested in clean environment before publication
- **CR-003**: Posts MUST include minimum 2-3 internal links to related content
- **CR-004**: Posts MUST target specific keyword with < 5,000 monthly search volume (low competition)
- **CR-005**: Technical claims MUST be validated by domain expert (not the author)

### Content Quality

- **CR-006**: Posts MUST be 1,500+ words for Authority blog | 800-1,200 words for Practitioner | varies for Community
- **CR-007**: Posts MUST include clear problem statement in first 2 paragraphs
- **CR-008**: Posts MUST include practical takeaways or action items
- **CR-009**: Posts MUST pass readability check (Flesch-Kincaid grade level appropriate for audience)
- **CR-010**: Posts MUST include meta description (150-160 characters) and Open Graph tags

### AI Discoverability

- **CR-011**: Posts MUST use clear heading hierarchy (H1 → H2 → H3) for AI extraction
- **CR-012**: Key concepts MUST be explicitly defined (not assumed)
- **CR-013**: Code examples MUST include language tags and complete context
- **CR-014**: Posts MUST include JSON-LD Article schema for structured data
- **CR-015**: Posts MUST include summary section for AI systems to extract

### Distribution & Engagement

- **CR-016**: Each post MUST have promotion plan (social, newsletter, community)
- **CR-017**: Posts MUST be shared within 24 hours of publication across Tier 1 channels
- **CR-018**: Posts MUST be cross-posted to relevant platforms (Dev.to, Medium) within 48 hours
- **CR-019**: High-performing posts MUST be submitted to Hacker News (if appropriate)
- **CR-020**: Post performance MUST be tracked in analytics dashboard (traffic, engagement, conversions)

### Key Content Elements *(include if applicable)*

- **Blog Post**: Title, TLDR, Background, Main Content (H2/H3), Code Examples (if applicable), Results, Lessons Learned, Conclusion & CTA, FAQ
- **Content Cluster**: Hub page with 8-12 related posts, internal linking strategy, topic authority signals
- **Newsletter**: Excerpt, CTA to read full post, related content recommendations
- **Social Assets**: Twitter thread, LinkedIn post, visual quote cards

---

## Success Criteria *(mandatory)*

<!--
  Define measurable outcomes. These must be technology-agnostic and measurable.
  Align metrics with blog type (Authority, Practitioner, Community, Thought Leadership).
-->

### Content Performance Metrics

- **SC-001**: Achieve [X] monthly unique visitors by Month [N]
- **SC-002**: Maintain [X]% organic search traffic (not paid/social only)
- **SC-003**: Average [X] minutes time-on-page across all posts
- **SC-004**: [X]% of posts rank on page 1 for target keyword within 3 months

### Engagement & Distribution Metrics

- **SC-005**: [X]% newsletter signup rate from blog traffic
- **SC-006**: Average [X] social shares per post within first week
- **SC-007**: [X]% comment rate on posts (if comments enabled)
- **SC-008**: [X] backlinks per post from external sources within 6 months

### Business Impact Metrics

- **SC-009**: [X]% reduction in developer CAC (customer acquisition cost) attributed to blog
- **SC-010**: [X]% of demo requests or SDK downloads originate from blog traffic
- **SC-011**: [X] citations in AI systems (ChatGPT, Claude, Perplexity) within 12 months
- **SC-012**: [X] speaking/podcast invitations for team members (thought leadership indicator)

### Authority & Brand Metrics

- **SC-013**: Achieve Domain Authority [X] (Moz/Ahrefs) by Month [N]
- **SC-014**: [X]% increase in branded search queries (company name + problem)
- **SC-015**: [X] guest post invitations or cross-promotion opportunities
- **SC-016**: [X]% of target keywords where blog appears in "People Also Ask" boxes

---

## Out of Scope *(optional)*

<!--
  Explicitly define what's NOT included in this content strategy.
-->

- Multilingual content (English only for v1)
- Video content (text/images only for v1)
- Podcast or audio versions
- Community forums or discussion boards
- Premium/gated content tiers
- Personalization engine
- AI-generated content (human-written only)

---

## Assumptions *(optional)*

- Editorial team has capacity for [N] posts per month
- Team includes domain expert for technical review
- Analytics tracking (Google Analytics or equivalent) will be available
- Social media accounts (Twitter/LinkedIn) are active and maintained
- Newsletter platform integration possible (e.g., Mailchimp, Substack)
- Target audience is English-speaking developers
- Posts will remain public (no paywall) for v1
- Content will be licensed under [Creative Commons / All Rights Reserved]

---

## Dependencies *(optional)*

- **Editorial Team**: Writers, technical reviewers, copyeditors
- **Domain Expertise**: Access to subject matter experts for validation
- **Design Resources**: Diagrams, screenshots, visual assets (if needed)
- **Analytics Platform**: Google Analytics, Plausible, or equivalent
- **Social Media Presence**: Active Twitter/LinkedIn accounts
- **Newsletter Platform**: Mailchimp, Substack, ConvertKit, or equivalent
- **SEO Tools**: Ahrefs, SEMrush, or Google Search Console for keyword research

---

## Constraints *(optional)*

- Editorial team capacity: [N] posts per month maximum
- Budget for freelance writers: $[X]/month (if applicable)
- Technical review must be completed by someone other than author
- All posts must pass legal/compliance review (if regulated industry)
- Posts cannot include confidential customer data or trade secrets
- Content must align with company brand guidelines
- Posts must meet accessibility standards (WCAG 2.1 AA minimum)

---

## Related Content or Examples *(optional)*

- **Reference Blogs**: [List successful blogs in your space that inspire this strategy]
- **Competitive Analysis**: [Key competitors' content strategies and gaps you'll fill]
- **Internal Documentation**: Links to brand guidelines, content style guide, legal policies
- **Research Sources**: `refs/1_principles_for_constitution.md`, `refs/2_define_for_specify.md`

---

## Validation Checklist

Before moving to `/blogkit.plan`, verify:

- [ ] Blog type explicitly defined (Authority, Practitioner, Community, or Thought Leadership)
- [ ] Target audience persona documented with specific pain points
- [ ] 3-5 content pillars defined and aligned with product value
- [ ] Publishing cadence realistic for team capacity
- [ ] Success criteria measurable and blog-type-appropriate (at least 3 metrics)
- [ ] NO technology implementation details (CMS, frameworks, hosting) present in this spec
- [ ] Content requirements are testable and unambiguous
- [ ] All [NEEDS CLARIFICATION] markers resolved (max 3 total)
- [ ] Content pillars address problems first, not technologies

---

**Note**: This specification focuses on content strategy only. Technical implementation (platform, CMS, tools, hosting) will be defined in `plan.md` after running `/blogkit.plan`.

---

## Example: Authority Blog for AI/LLM Developers

### Blog Type Declaration

**Blog Type**: Authority

**Rationale**: Position our company as the canonical reference for building effective AI agents in production. Authority blog targets high-intent decision makers (CTOs, engineering leads) who need to understand patterns, trade-offs, and best practices before committing to a technology or architecture.

**Content Strategy Alignment**: Deep research, original insights, canonical content (6-12 month ROI). Each post establishes authority and becomes a referenced resource in industry discussions.

### Target Audience

**Primary Audience**:
- **Persona**: Senior ML/Software Engineers (5+ years) building production LLM systems
- **Use Cases**:
  - Evaluating whether to use agents vs. traditional ML
  - Understanding how to structure multi-agent systems reliably
  - Learning patterns for error handling and guardrails in production agents
- **Pain Points**:
  - Documentation is scattered across multiple sources
  - Most examples are demos, not production-grade code
  - No clear patterns for structuring complex agent workflows
- **Where They Are**: Hacker News, DEV.to, Engineering Twitter, AI Discord communities, LangChain Slack

### Content Pillars

**Pillar 1: Production-Grade Agent Patterns**
- How to structure agents for reliability and observability
- Error handling, retries, and circuit breakers in multi-agent systems
- Testing agents in staging vs. production

**Pillar 2: Context Engineering for AI Systems**
- How to architect prompts and context for consistency
- Measuring prompt performance and iterating
- Reducing hallucination through structured context

**Pillar 3: Multi-Agent Orchestration**
- Coordinating specialized agents for complex tasks
- Communication patterns between agents
- Resource constraints and cost optimization

### Publishing Cadence
- Target: 2 Authority posts per month + 2 tutorials/practitioner posts
- Authority posts: 2,000-4,000 words, 4-6 week research/writing cycle
- Practitioner posts: 800-1,500 words, 2-week cycle
- Total: ~15 posts in first 6 months

### Success Metrics
- **Authority Blog Success**: 50+ high-quality backlinks in month 6, 5K+ monthly pageviews to authority posts, 3+ citations by other technical blogs
- **Team Thought Leadership**: 10+ speaking invitations from these posts, media mentions citing the blog
- **Engagement**: Average time-on-page > 4 minutes, 2+ internal links per post followed
- **Product Impact**: 30%+ of inbound demo requests cite blog as discovery source
