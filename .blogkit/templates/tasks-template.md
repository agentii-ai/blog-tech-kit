---

description: "Task list template for blog content production sprints"

---

# Tasks: [BLOG INITIATIVE NAME]

**Input**: Editorial plan from `/specs/[###-feature-name]/plan.md`
**Prerequisites**: plan.md (complete), spec.md (complete), research.md (if present)

**Tests**: Not applicable - this is content production. Validation via editorial checkpoints (quality gates, analytics review, SEO ranking verification).

**Organization**: Tasks are organized by sprint to enable parallel content production and incremental publishing. Each sprint delivers complete, publication-ready blog posts.

## Format: `[ID] [P?] [Sprint] Description`

- **[P]**: Can run in parallel (different content pieces, no dependencies)
- **[Sprint]**: Which sprint this task belongs to (e.g., Sprint 0, Sprint 1, Sprint 2)
- Include exact file paths and post identifiers in descriptions

## Path Conventions

- **Content directory**: `content/posts/` (or equivalent in chosen CMS)
- **Editorial guide**: `editorial-guide.md` (style, tone, voice, citations)
- **Content calendar**: `content-calendar.md` (post timeline and dependencies)
- **Analytics tracking**: `analytics-config.md` (metrics for each post)
- **Draft locations**: Platform-specific (GitHub branches, Google Docs, Notion, etc.)

---

## Sprint 0: Platform Setup & Editorial Foundation

**Purpose**: Prepare blog infrastructure, establish editorial workflows, and define content standards before first post production begins

**Duration**: 1-2 weeks (from plan approval to platform live)

**Checkpoint**: Platform deployed and ready to receive first content

### Platform & Infrastructure Setup

- [ ] T001 [P] Provision hosting and deploy blog platform (CMS + framework + CDN)
- [ ] T002 [P] Configure domain, SSL certificate, DNS settings
- [ ] T003 [P] Set up analytics platform and configure event tracking (pageviews, scroll depth, conversions)
- [ ] T004 [P] Integrate newsletter platform and embed signup forms on blog
- [ ] T005 [P] Configure SEO tools (Google Search Console, site verification, sitemaps)
- [ ] T006 Test blog build pipeline and auto-deploy from content commits
- [ ] T007 Test content preview environment (staging branch/environment)
- [ ] T008 Configure JSON-LD Article schema templates for all posts
- [ ] T009 Create SEO/AI optimization checklist document

### Editorial Foundation

- [ ] T010 Create `editorial-guide.md` with blog voice, tone, style conventions (3-5 page guide)
- [ ] T011 [P] Create post templates (title format, TLDR structure, sections, CTA placement)
- [ ] T012 [P] Create code example template (language tags, complete examples, GitHub links)
- [ ] T013 [P] Create SEO metadata template (meta description format, internal link strategy)
- [ ] T014 Create content calendar timeline mapping first 5 posts to sprint weeks
- [ ] T015 Configure distribution workflow templates (Twitter thread, LinkedIn post, Dev.to cross-post)
- [ ] T016 Set up newsletter template (email structure, preview text, CTA)
- [ ] T017 Document internal link strategy and content cluster plan
- [ ] T018 Test full publish → distribute → measure workflow with test post

**Quality Checkpoint**: Platform live, editorial standards documented, first post ready to schedule

---

## Sprint 1: Foundation Post [Post 1 - Title]

**Goal**: [e.g., "Establish core concept for [Topic]"]
**Timeline**: [e.g., "Weeks 1-3 from sprint start"]
**Cadence**: [e.g., "2-week sprint for practitioner posts, 6-week for authority posts"]
**Target Audience**: [Primary reader persona from spec]
**Target Keyword**: [Primary keyword from spec.md]
**Evidence Tier**: [Tier 1/2/3 per constitution]

### Phase 1: Research & Outline (Days 1-5)

- [ ] T019 Competitive analysis: Research 5-10 existing posts on similar topics (note gaps, unique angles)
- [ ] T020 Keyword research: Identify target keyword and 5-10 related keywords (< 5K monthly search volume)
- [ ] T021 Create detailed outline with H2/H3 structure (10-15 sections for authority post, 5-8 for practitioner)
- [ ] T022 [P] Gather evidence (Tier 1-3): Collect data, benchmarks, case studies for main claims
- [ ] T023 [P] Identify code examples needed (list 3-5 concrete examples with expected output)
- [ ] T024 SME kickoff meeting: Brief technical reviewer on post angle and confirm accuracy approach

### Phase 2: Draft (Days 6-15)

- [ ] T025 Write main content (1,500-3,000 words for authority, 800-1,200 for practitioner)
- [ ] T026 Add code examples with comments and expected output (3-5 complete, runnable examples)
- [ ] T027 [P] Create diagrams/visuals if applicable (architecture, workflow, comparison charts)
- [ ] T028 [SEO] Add internal links to 3-5 related posts (content cluster strategy, link to hub page)
- [ ] T029 [SEO] Add external links to 2-3 authoritative sources (credibility signals, Tier 1-2 sources)
- [ ] T030 Create FAQ section (4-6 FAQs from common reader questions, helps AI summarization)
- [ ] T031 Write TLDR and Key Takeaways section (3-5 extractable bullets for AI systems)
- [ ] T032 Write Limitations section (150+ words for authority posts, honest about edge cases)

### Phase 3: Technical Review `[NO SELF-VALIDATION]` (Days 16-19)

- [ ] T033 [NO SELF-VALIDATION] Code example testing: Run all code in clean environment, verify output
- [ ] T034 [NO SELF-VALIDATION] SME technical review by non-author (designated technical reviewer)
- [ ] T035 [NO SELF-VALIDATION] Evidence tier validation: Verify all claims have Tier 1-3 support
- [ ] T036 [NO SELF-VALIDATION] Accuracy check: Verify facts, benchmarks, citations are current
- [ ] T037 Feasibility check: Confirm all instructions/tutorials work end-to-end
- [ ] T038 Security review: Check for security implications or warnings needed

### Phase 4: Copyedit & SEO Optimization (Days 20-23)

- [ ] T039 Structural edit: Confirm outline matches content, information flows logically
- [ ] T040 Clarity edit: Ensure concepts explained before use, jargon appropriate for audience
- [ ] T041 Grammar/spelling: Proofread for errors, consistency with editorial guide
- [ ] T042 [SEO] Keyword optimization: Target keyword in title, H2, first 100 words, URL slug
- [ ] T043 [SEO] H1→H2→H3 hierarchy: Ensure clear heading structure for LLM parsing
- [ ] T044 [SEO] Meta description: Write 150-160 characters with target keyword and CTA
- [ ] T045 [SEO] Open Graph and Twitter Card tags: Verify preview renders correctly
- [ ] T046 [SEO] Internal link anchor text: Optimize for keyword relevance
- [ ] T047 [SEO] 40-point SEO checklist gate: Verify all items before publish
- [ ] T048 Final proofread and formatting check

### Phase 5: Publish & Distribute (Days 24-28)

- [ ] T049 [SEO] Create canonical URL and verify no duplicate content issues
- [ ] T050 Schedule post publish date and time (optimal: Tuesday-Thursday, 7-9 AM EST)
- [ ] T051 Publish post and verify it appears on blog homepage
- [ ] T052 [SEO] Verify JSON-LD schema renders correctly (test with schema.org validator)
- [ ] T053 Verify analytics tracking fires on page load (test with browser console)
- [ ] T054 Send post to newsletter subscribers (Day 0, Hour 1)
- [ ] T055 Create Twitter thread (1 main + 5-7 follow-ups with key takeaways, Day 0)
- [ ] T056 Create LinkedIn post with excerpt and link (Day 0)
- [ ] T057 Cross-post to Dev.to with canonical link (Day 1-2)
- [ ] T058 Share in relevant Discord/Slack communities (Day 1-2, follow community rules)
- [ ] T059 Submit to Hacker News if appropriate (Tue-Thu, 7-9 AM EST)
- [ ] T060 Monitor and respond to all comments within 24 hours (Day 0-7)

### Phase 6: Measurement & Iteration (Ongoing)

- [ ] T061 Day 1: Initial traffic and engagement baseline check
- [ ] T062 Week 1: Review analytics (pageviews, time on page, scroll depth, referrers)
- [ ] T063 Week 1: [SEO] Check keyword rankings in GSC for target + related keywords
- [ ] T064 Week 1: Analyze social engagement (shares, likes, comments)
- [ ] T065 Month 1: Identify backlinks and external citations (Ahrefs/GSC)
- [ ] T066 Month 1: Check AI citations (ChatGPT, Claude, Perplexity manual search)
- [ ] T067 Document performance in `analytics-log.md` (traffic, engagement, conversions)
- [ ] T068 Identify content improvements for future posts (what worked, what didn't)

**Quality Checkpoint**: Post published, distributed, and performing per baseline expectations (analytics tracked, keyword indexed, initial social engagement measured)

---

## Sprint 2: Deep Dive Post [Post 2 - Title]

**Goal**: [e.g., "Deepen understanding of [Topic]"]
**Timeline**: [e.g., "Weeks 4-6 from sprint start"]
**Dependencies**: Sprint 1 post published and indexed (builds on Post 1 traffic)

### Phase 1: Research & Outline

- [ ] T063 Competitive analysis: How have competitors expanded on this topic? What gaps exist?
- [ ] T064 Audience research: What are readers asking about Post 1 in comments/social?
- [ ] T065 Content clustering: Identify 2-3 specific angles that link to Post 1
- [ ] T066 Create outline (similar structure to Post 1 with deeper technical depth)
- [ ] T067 [P] Gather advanced examples and case studies specific to post angle

### Phase 2: Draft

- [ ] T068 Write main content building on Post 1 (deeper technical examples, advanced use cases)
- [ ] T069 Add 4-6 code examples with more complex scenarios
- [ ] T070 [P] Create advanced diagrams or interactive examples if applicable
- [ ] T071 Link to Post 1 in introduction and conclusion (content cluster)
- [ ] T072 Add external references and citations from thought leaders

### Phase 3: Technical Review

- [ ] T073 SME review of advanced concepts and accuracy
- [ ] T074 Performance validation (ensure code examples run efficiently)

### Phase 4: Copyedit & SEO

- [ ] T075 Structure and clarity review
- [ ] T076 Grammar and consistency check
- [ ] T077 Target keyword in title, H2, first 100 words, meta description
- [ ] T078 Ensure internal links to Post 1 and other related content
- [ ] T079 Verify heading hierarchy and metadata

### Phase 5: Publish & Distribute

- [ ] T080 Publish and verify on blog
- [ ] T081 Highlight Post 1 relationship in social copy (content cluster strategy)
- [ ] T082 Send newsletter to subscribers
- [ ] T083 Post on Twitter, LinkedIn, Dev.to
- [ ] T084 Share in communities (Day 1-2)
- [ ] T085 Monitor engagement and respond to comments

### Phase 6: Measurement

- [ ] T086 After 1 week: Compare performance to Post 1 (establish baseline trends)
- [ ] T087 Check cross-post traffic (Post 1 → Post 2 internal link traffic)
- [ ] T088 Document performance and insights

**Quality Checkpoint**: Post 2 published and indexed; Post 1 traffic impact measured (both posts working as content cluster)

---

## Sprint 3: Anti-Pattern Post [Post 3 - Title]

**Goal**: [e.g., "Build credibility through honest failure documentation"]
**Timeline**: [e.g., "Weeks 7-9"]
**Dependencies**: Posts 1-2 establish authority base

### Phase 1: Research & Outline

- [ ] T089 Identify common mistakes in post topic (anti-patterns, pitfalls, failures)
- [ ] T090 Gather real examples of these anti-patterns (from code, projects, experiences)
- [ ] T091 Document lessons learned from each anti-pattern
- [ ] T092 Create outline: Common Mistake #1 → Lesson, Mistake #2 → Lesson, etc.
- [ ] T093 Plan for high shareability (anti-pattern posts often get community amplification)

### Phase 2: Draft

- [ ] T094 Write honest failures/mistakes (builds trust, high engagement)
- [ ] T095 Provide code examples showing anti-pattern AND correct approach
- [ ] T096 Add real-world case studies of teams hitting these mistakes

### Phase 3: Technical Review

- [ ] T097 Verify anti-patterns are accurately described
- [ ] T098 Confirm solutions are correct and tested
- [ ] T099 Ensure no security issues revealed by mistake documentation

### Phase 4: Copyedit & SEO

- [ ] T100 Clarity edit: Make anti-patterns obvious but not condescending
- [ ] T101 Target keyword in title, H2, first 100 words
- [ ] T102 Internal links: Reference Posts 1-2 as "right way" examples
- [ ] T103 Add FAQ section (address defensive questions anti-pattern posts can trigger)

### Phase 5: Publish & Distribute

- [ ] T104 Publish and verify
- [ ] T105 Emphasize credibility angle in social copy ("Lessons learned the hard way...")
- [ ] T106 Send newsletter
- [ ] T107 Post on Twitter, LinkedIn, Dev.to
- [ ] T108 Share in communities (expect high engagement)
- [ ] T109 Monitor comments and respond to skeptics professionally

### Phase 6: Measurement

- [ ] T110 Track engagement metrics (shares typically higher than how-to posts)
- [ ] T111 Monitor sentiment (anti-pattern posts can trigger defensive responses)
- [ ] T112 Document community feedback and citations

**Quality Checkpoint**: Anti-pattern post published; community trust amplification measured

---

## Sprint 4: Ecosystem Post [Post 4 - Title]

**Goal**: [e.g., "Position in broader ecosystem context"]
**Timeline**: [e.g., "Weeks 10-12"]

### Phase 1: Research & Outline

- [ ] T113 Map ecosystem: What adjacent tools/projects/concepts are relevant?
- [ ] T114 Identify potential partners/ecosystem players to mention
- [ ] T115 Create outline: Ecosystem overview → How post topic fits → Integration points
- [ ] T116 Plan for backlinks: Ecosystem posts often generate citations from related projects

### Phase 2: Draft

- [ ] T117 Write ecosystem context and positioning
- [ ] T118 Add comparison table (post topic vs. related approaches)
- [ ] T119 Link to 5-10 related projects/tools in ecosystem
- [ ] T120 Create integration examples showing how this fits with other tools

### Phase 3: Technical Review

- [ ] T121 Verify ecosystem mapping is accurate and current
- [ ] T122 Confirm links to external projects are correct and their status current

### Phase 4: Copyedit & SEO

- [ ] T123 Clarity: Assume reader is new to ecosystem
- [ ] T124 Target keyword in title, H2, first 100 words
- [ ] T125 Internal links to Posts 1-3
- [ ] T126 External links to ecosystem projects (good SEO signal)

### Phase 5: Publish & Distribute

- [ ] T127 Publish and verify
- [ ] T128 Reach out to ecosystem projects mentioned (increase backlink potential)
- [ ] T129 Send newsletter
- [ ] T130 Post on Twitter, LinkedIn, Dev.to
- [ ] T131 Share in relevant communities
- [ ] T132 Engage with ecosystem projects that respond/retweet

### Phase 6: Measurement

- [ ] T133 After 2 weeks: Track backlinks from ecosystem mentions
- [ ] T134 Monitor if ecosystem projects link back to post
- [ ] T135 Document partnership/collaboration opportunities that emerge

**Quality Checkpoint**: Ecosystem relationships established; backlink acquisition visible

---

## Sprint 5: Benchmark/Data Post [Post 5 - Title]

**Goal**: [e.g., "Establish authority through original research"]
**Timeline**: [e.g., "Weeks 13-15"]

### Phase 1: Research & Outline

- [ ] T136 Define research methodology (survey, benchmark, analysis, experiment)
- [ ] T137 Gather data or run experiment (this post should have original data)
- [ ] T138 Analyze results and create visualizations
- [ ] T139 Create outline: Methodology → Results → Implications → Conclusions
- [ ] T140 Plan for high-impact citations (data posts often cited in media, research)

### Phase 2: Draft

- [ ] T141 Write methodology section (transparent, reproducible approach)
- [ ] T142 Present results with data visualizations (charts, graphs, tables)
- [ ] T143 Add interpretation and business implications
- [ ] T144 Create downloadable results (spreadsheet, raw data) for credibility
- [ ] T145 Link results to earlier posts showing practical application

### Phase 3: Technical Review

- [ ] T146 Verify methodology is sound and limitations documented
- [ ] T147 Double-check all data and calculations for accuracy
- [ ] T148 Ensure conclusions are supported by data (no over-claims)

### Phase 4: Copyedit & SEO

- [ ] T149 Clarity: Explain any research jargon for general audience
- [ ] T150 Target keyword in title, H2, first 100 words
- [ ] T151 Meta description emphasizes data/original research angle
- [ ] T152 Internal links to Posts 1-4 (how they informed this research)
- [ ] T153 Add FAQ section (address questions about methodology)

### Phase 5: Publish & Distribute

- [ ] T154 Publish and verify
- [ ] T155 Create data visualization social graphics (these posts get high shares)
- [ ] T156 Send newsletter with data highlights
- [ ] T157 Post on Twitter, LinkedIn, Dev.to
- [ ] T158 Share with media contacts and analyst groups
- [ ] T159 Submit to relevant news aggregators
- [ ] T160 Engage with media outlets that cite the data

### Phase 6: Measurement

- [ ] T161 After 1 month: Track backlinks and media citations
- [ ] T162 Monitor if data is cited in other blogs, research, news
- [ ] T163 Document PR value and business impact
- [ ] T164 Measure if posts become "industry standard reference" (authority milestone)

**Quality Checkpoint**: Data post published; media attention and citations tracked; authority established

---

## Post-Sprint Measurement & Iteration (Quarterly Review)

**Purpose**: Analyze performance across all sprints and iterate on future content

**Timeline**: Month 3 analysis (after all first 5 posts have had 4+ weeks to mature)

### Content Performance Analysis

- [ ] MEAS-001 Aggregate analytics: Traffic, engagement, conversions across all 5 posts
- [ ] MEAS-002 Identify top-performing post (most traffic, longest time on page, highest shares)
- [ ] MEAS-003 Identify underperforming post (lowest traffic, high bounce rate)
- [ ] MEAS-004 [SEO] Keyword analysis: Which posts rank? Which keywords are we winning?
- [ ] MEAS-005 [SEO] Backlink analysis: Which posts get cited most? Any partnerships emerging?
- [ ] MEAS-006 Content cluster analysis: Are internal links driving traffic as expected?
- [ ] MEAS-007 Audience analysis: What audience segments are engaged? Where are readers coming from?

### Business Impact Analysis

- [ ] MEAS-008 Conversion analysis: Which posts drive newsletter signups?
- [ ] MEAS-009 Product impact: Which posts drive demo requests or SDK downloads?
- [ ] MEAS-010 AI citation check: Are posts cited by ChatGPT, Claude, Perplexity?
- [ ] MEAS-011 Speaking/PR opportunities: Any invitations from blog authority?
- [ ] MEAS-012 CAC impact: Has blog reduced customer acquisition cost?

### Iteration Planning

- [ ] MEAS-013 Create iteration plan: Double down on winning themes, refresh underperformers
- [ ] MEAS-014 Document lessons learned for future posts
- [ ] MEAS-015 Update editorial guide with refined best practices
- [ ] MEAS-016 Plan next content wave based on performance data

**Quality Checkpoint**: Performance baseline established; iteration plan for future posts created

---

## Dependencies & Execution Order

### Sprint Dependencies

- **Sprint 0**: No dependencies - can start immediately (foundation for all content)
- **Sprint 1 (Post 1)**: Depends on Sprint 0 completion (platform live)
- **Sprint 2 (Post 2)**: Depends on Sprint 1 publication (builds on Post 1)
- **Sprint 3 (Post 3)**: Can start immediately after Sprint 0 (no dependency on Posts 1-2, but benefits from authority buildup)
- **Sprint 4 (Post 4)**: Can start immediately after Sprint 0 (ecosystem context independent)
- **Sprint 5 (Post 5)**: Can start immediately after Sprint 0 (research timeline independent)
- **Post-Sprint Measurement**: Depends on all 5 posts published and 4+ weeks to mature

### Within Each Sprint

- Research & Outline before Draft
- Draft before Technical Review
- Technical Review before Copyedit (must verify accuracy first)
- Copyedit & SEO before Publish
- Publish before Distribution workflows
- Measurement happens after publishing

### Parallel Opportunities

- **Sprint 0**: All tasks marked [P] can run in parallel (infrastructure setup, templates, SEO config)
- **Within each sprint**:
  - Phase 1 (Research) tasks marked [P] can run in parallel
  - Phase 2 (Draft) tasks marked [P] can run in parallel
  - Multiple sprints can run in parallel if team capacity allows (e.g., one person working on Post 1 while another researches Post 2)
- **Between sprints**: While Post 1 measurement runs (Week 3), Post 2 can start research simultaneously

---

## Sprint Parallelization Visualization

```
Week:    1    2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18
         |----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|
Sprint 0 [====]                                                         (Platform Setup)
Sprint 1      [==========]                                              (Post 1: Foundation)
Sprint 2                [==========]                                    (Post 2: Deep Dive)
Sprint 3                     [==========]                               (Post 3: Anti-Pattern) [P]
Sprint 4                          [==========]                          (Post 4: Ecosystem) [P]
Sprint 5                               [===============]                (Post 5: Benchmark/Data)
Measure                                              [====]             (Quarterly Review)

Legend:
[====] = Sprint duration
[P]    = Can run in parallel with prior sprint (if team capacity allows)
```

**Parallelization Rules**:
- Sprint 0 must complete before any content sprint starts
- Sprint 1 must publish before Sprint 2 starts (content cluster dependency)
- Sprints 3-5 can overlap with prior sprints if team has capacity
- Post-Sprint Measurement requires all 5 posts published + 4 weeks maturation

---

## Implementation Strategy

### MVP Approach (First 5 Authority Posts)

1. Complete Sprint 0: Platform Setup (1-2 weeks)
2. Complete Sprint 1: Foundation Post (2-3 weeks after Sprint 0)
3. **VALIDATE**: Post 1 is published, indexed, generating organic traffic
4. Complete Sprints 2-5 in parallel (3-4 content streams if team capacity allows)
5. After 4-6 weeks on market: Run Post-Sprint Measurement & Iteration
6. Use learnings to plan next content wave

### Incremental Publishing

- Sprint 0 complete → Blog goes live
- Sprint 1 complete → First post published (Day 1 of blog)
- Sprint 2 complete → Second post (continues content flow)
- Sprint 3 complete → Third post (builds authority)
- Sprint 4 complete → Fourth post (ecosystem positioning)
- Sprint 5 complete → Fifth post (original research)
- After Month 2: Complete post-sprint measurement
- Decide: Continue with Post 6+ or pivot based on performance

### Content Team Structure

**Minimum team** (one person):
- Blog owner handles all roles with SME support for technical review

**Recommended team**:
- Writer: Handles research, draft, distribution
- SME (Subject Matter Expert): Technical review, accuracy verification
- Copyeditor: Grammar, SEO, clarity
- Marketing: Distribution, social copy, newsletter

**Large team**:
- Multiple writers working on posts in parallel
- Dedicated SME for technical review (rotation)
- Dedicated copyeditor
- Dedicated distribution specialist

---

## Effort Summary (Template)

**Fill in after completing task breakdown:**

| Role | Sprint 0 | Sprint 1 | Sprint 2 | Sprint 3 | Sprint 4 | Sprint 5 | Post-Sprint | Total |
|------|----------|----------|----------|----------|----------|----------|-------------|-------|
| Writer | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs |
| SME | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs |
| Editor | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs |
| Marketing | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs |
| Tech Lead | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs | [X] hrs |
| **Total** | **[X]** | **[X]** | **[X]** | **[X]** | **[X]** | **[X]** | **[X]** | **[X]** |

**Reference Estimates** (from eval_tasks.md):
- Sprint 0: ~40-50 hours total
- Authority Post Sprint: ~80-90 hours total
- Practitioner Post Sprint: ~50-60 hours total
- Post-Sprint Measurement: ~15-20 hours total

---

## Validation Checklist

Before starting content production, verify:

### Task Completeness
- [ ] All 6 phases defined per sprint (Research, Draft, Review, Edit, Publish, Measure)
- [ ] Sprint 0 includes all platform setup and editorial foundation tasks
- [ ] Each post sprint includes [SEO] tasks at every phase
- [ ] Technical Review phase includes [NO SELF-VALIDATION] markers
- [ ] Measurement phase includes AI citation check task

### SEO Integration
- [ ] [SEO] Keyword research task in Phase 1
- [ ] [SEO] Internal/external linking tasks in Phase 2
- [ ] [SEO] 40-point checklist gate task in Phase 4
- [ ] [SEO] JSON-LD and canonical URL tasks in Phase 5
- [ ] [SEO] Keyword ranking check in Phase 6

### Operational Readiness
- [ ] Target keyword defined per sprint
- [ ] Evidence tier documented per sprint
- [ ] Quality checkpoints defined per sprint
- [ ] Parallel opportunities marked with [P]
- [ ] Dependencies explicit between sprints
- [ ] Effort summary completed with hour estimates

### Constitution Alignment
- [ ] [NO SELF-VALIDATION] enforced on all technical review tasks
- [ ] Limitations section task included for authority posts
- [ ] Evidence tier validation task in Phase 3
- [ ] FAQ and Key Takeaways tasks for AI discoverability

---

## Notes

- [P] tasks = different sections, can be worked in parallel
- [Sprint] label maps task to specific sprint for traceability
- Each sprint should be independently completable and testable
- Commit content changes after each phase (Research → Draft → Review → Publish)
- Stop at any checkpoint to validate sprint deliverable independently
- Post measurement determines success (analytics, engagement, conversions)
- If post underperforms, document reasons for iteration next sprint
- Content cluster strategy (Posts 1-5 interlinked) maximizes SEO impact
- Anti-pattern posts often outperform how-to posts for shares
- Benchmark/data posts generate highest backlinks and citations
