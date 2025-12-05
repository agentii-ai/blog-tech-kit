---
description: Generate content production tasks based on editorial plan.
handoffs:
  - label: Execute Implementation
    agent: blogkit.implement
    prompt: Execute content production tasks by sprint
    send: true
  - label: Analyze Progress
    agent: blogkit.analyze
    prompt: Analyze task execution and content quality
    send: true
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

Given the editorial plan (plan.md) and any technical context from the user, generate a comprehensive task breakdown for content production:

1. **Load Required Plan File**:
   - Read `plan.md` from the current feature directory
   - Extract: Editorial Workflow, Content Calendar, First 5 Posts structure, Technical Stack

2. **Validate Plan Completeness**:
   - Confirm plan.md contains all required sections
   - Verify Constitution Check passed (all 8 Blog Principles validated)
   - Verify no [NEEDS CLARIFICATION] markers remain
   - If validation fails: STOP and ask user to complete plan using `/blogkit.plan`

3. **Parse Blog Structure from Plan**:
   - Extract: Blog Type, Target Audience, Content Pillars, Publishing Cadence
   - Identify: First 5 post titles (or post types if titles not yet defined)
   - Extract: Expected timeline for each sprint (from Editorial Workflow section)
   - Identify: Team structure (Writer, SME, Copyeditor, Marketing roles)

4. **Load Sprint 0 Template**:
   - Use `.blogkit/templates/tasks-template.md` Sprint 0: Platform Setup
   - Customize timing based on plan.md (1-2 weeks for platform setup)
   - Customize platform choices from Technical Stack section
   - Customize team roles from Editorial Workflow section

5. **Generate Content Sprint Tasks (Sprints 1-5)**:

   For each of the first 5 posts defined in plan.md:

   a. **Determine Post Type and Timeline**:
      - Post 1 (Foundation): Authority-establishing post on core concept
        - Timeline: 6-week cycle (Authority blogs) or 2-week cycle (Practitioner blogs)
      - Post 2 (Deep Dive): Advanced exploration building on Post 1
        - Timeline: Same as Post 1
      - Post 3 (Anti-Pattern): Credibility through failure documentation
        - Timeline: Same as Post 1
      - Post 4 (Ecosystem): Positioning in broader context
        - Timeline: Same as Post 1
      - Post 5 (Benchmark/Data): Original research establishing authority
        - Timeline: Same as Post 1 + 1 week for research

   b. **Generate Phase 1: Research & Outline Tasks**:
      - Competitive analysis task (find gaps in existing content)
      - Keyword research (target low-competition keywords < 5K/month search volume)
      - Outline creation with H2/H3 structure
      - Evidence gathering (data, screenshots, benchmarks)
      - Code example identification (if technical blog)
      - SME kickoff meeting (brief technical reviewer)

   c. **Generate Phase 2: Draft Tasks**:
      - Main content writing (word count varies by blog type)
      - Code example implementation (with expected output)
      - Diagrams/visuals creation if applicable
      - Internal links to other posts (content cluster strategy)
      - External links to authoritative sources
      - FAQ section creation
      - TLDR summary writing

   d. **Generate Phase 3: Technical Review Tasks**:
      - Code example testing in clean environment (if technical post)
      - SME technical review by non-author (No Self-Validation principle)
      - Accuracy verification of facts and benchmarks
      - Feasibility check (instructions work end-to-end)
      - Security review (if applicable)

   e. **Generate Phase 4: Copyedit & SEO Optimization Tasks**:
      - Structural edit (outline matches content, logical flow)
      - Clarity edit (concepts explained, jargon level appropriate)
      - Grammar/spelling proofread
      - SEO optimization (keyword placement, meta descriptions)
      - H2/H3 hierarchy optimization for LLM parsing
      - Meta description writing (150-160 characters)
      - Open Graph and Twitter Card tags
      - Internal link anchor text optimization
      - Final proofread and formatting

   f. **Generate Phase 5: Publish & Distribute Tasks**:
      - Canonical URL setup
      - Publish scheduling and timing
      - Post verification on homepage
      - JSON-LD schema validation
      - Analytics tracking verification
      - Newsletter sending (Day 0)
      - Social distribution (Twitter thread, LinkedIn, Day 0)
      - Dev.to cross-posting (Day 1-2)
      - Community sharing (Discord/Slack, Day 1-2)
      - Comment monitoring (Days 0-7)

   g. **Generate Phase 6: Measurement & Iteration Tasks**:
      - Initial analytics review (Week 1)
      - Keyword ranking check (Week 1)
      - Social engagement analysis (Day 3)
      - Backlink tracking (Month 1)
      - Performance documentation
      - Lessons learned for next posts

6. **Generate Post-Sprint Measurement Tasks**:
   - Aggregate analytics across all 5 posts
   - Identify top/underperforming posts
   - Keyword analysis (rankings, search traffic)
   - Backlink analysis (citations, partnerships)
   - Content cluster effectiveness analysis
   - Audience segment analysis
   - Conversion analysis
   - Iteration plan for next content wave
   - Editorial guide refinement

7. **Apply Blog-Type Specific Customization**:

   **Authority Blog** (longer cycles, focus on citations):
   - Extend timelines to 6-week cycles per post
   - Add benchmark/data collection to research phase
   - Emphasize backlink tracking in measurement
   - Add "media outreach" task for data posts
   - Longer content depth (1,500-3,000 words)

   **Practitioner Blog** (faster cycles, focus on engagement):
   - Use 2-week cycles per post
   - Simplify evidence gathering (focus on practical examples)
   - Shorten content (800-1,200 words)
   - Add "completion rate" tracking for tutorials
   - Focus on tutorial engagement metrics

   **Community Blog** (spotlight format, high frequency):
   - Use 1-week sprint per spotlight
   - Simplify each phase (focused profile structure)
   - Add "contributor outreach" and "spotlight coordination" tasks
   - Emphasize community engagement metrics
   - Add "relationship building" tasks

   **Thought Leadership Blog** (quarterly, focus on visibility):
   - Use 4-week cycles
   - Add "speaking invitation tracking" task
   - Add "media citation tracking" task
   - Emphasize executive visibility and thought leadership metrics

8. **Identify Dependencies**:
   - Mark Sprint 0 as prerequisite for all content sprints
   - Mark Sprint 1 completion as prerequisite for Sprint 2 (content cluster dependency)
   - Mark Sprints 3-5 as independent (can run in parallel with Sprint 1-2)
   - Document parallelization opportunities clearly

9. **Create Task Validation Checklist**:
   - Generate checklist at `FEATURE_DIR/checklists/tasks-validation.md`:
     ```markdown
     # Content Production Task Validation: [BLOG NAME]

     - [ ] All 5 posts have complete task breakdown (6 phases each)
     - [ ] Sprint 0 platform setup tasks defined
     - [ ] Editorial workflow tasks reflect blog type (authority/practitioner/community)
     - [ ] Technical review tasks include non-author SME validation (No Self-Validation)
     - [ ] SEO optimization tasks comprehensive (keywords, headings, schema)
     - [ ] Distribution workflow tasks include all 3 tiers (Owned, Amplification, Community)
     - [ ] Measurement tasks include analytics, rankings, backlinks, engagement
     - [ ] Sprint dependencies clearly documented
     - [ ] Parallel execution opportunities identified (marked with [P])
     - [ ] Timeline aligns with blog type (Authority 6-week, Practitioner 2-week, etc.)
     - [ ] All tasks are actionable and have clear acceptance criteria
     - [ ] Content cluster strategy documented (internal linking between posts)
     ```

10. **Write Tasks File**:
    - Generate TASKS_FILE at `specs/[NNN-feature]/tasks.md`
    - Use `.blogkit/templates/tasks-template.md` as structure
    - Fill Sprint 0 with customized platform setup tasks
    - Fill Sprints 1-5 with post-specific content production tasks
    - Add Post-Sprint Measurement section
    - Remove unused sections from template
    - Add specific post titles where known

11. **Report Completion**:
    - Display tasks file path (TASKS_FILE)
    - Display task count by sprint (e.g., "Sprint 0: 18 tasks, Sprint 1: 38 tasks")
    - Show total task count
    - Display validation checklist status (✓ PASS or ✗ FAIL with issues)
    - Show Next Steps:
      1. Review tasks.md for accuracy and timeline
      2. Assign team members to tasks (Writer, SME, Copyeditor, Marketing)
      3. Adjust timelines if team capacity differs from plan estimates
      4. Run `/blogkit.implement` to execute tasks in sprint order
      5. Proceed to Phase 1: Platform Setup (Sprint 0)

**NOTE**: Tasks bridge the editorial plan (what to write) with implementation reality (when and how). Each sprint is independently publishable and measurable.

## General Guidelines

### Task Generation Best Practices

1. **Each sprint is independently publishable**: At the end of each sprint, one post should be complete and ready to publish
2. **Build content clusters**: Ensure internal links between posts are documented in task descriptions
3. **Parallelize where possible**: Research phases for Posts 2-5 can start while Post 1 drafting is underway
4. **Blog-type specific timing**: Authority = 6 weeks/post, Practitioner = 2 weeks/post, Community = 1 week/post
5. **No Self-Validation principle**: Every post requires technical review by someone other than the author

### Task Naming Conventions

- Descriptive task titles that explain WHAT needs to be done (not just code/title)
- Include specific file paths or post identifiers where applicable
- Estimate task duration (quick = 1-2 hours, medium = 2-4 hours, complex = 4-6+ hours)
- Cross-reference related tasks when dependencies exist

### Distribution Strategy Tasks

Ensure tasks include all 3 tiers from plan.md:

1. **Tier 1 (Owned Channels)**: Blog post, newsletter email, YouTube/video
2. **Tier 2 (Amplification)**: Twitter, LinkedIn, Dev.to, Hashnode, Medium
3. **Tier 3 (Community)**: Reddit, Hacker News, Discord, Slack, GitHub

### Measurement Task Strategy

For each post, create measurement tasks at:
- Day 1: Initial publish verification
- Day 3: Social engagement check
- Week 1: Analytics review (traffic, engagement, scroll depth)
- Week 1: Keyword ranking check
- Month 1: Backlink analysis
- Quarterly: Content cluster effectiveness and iteration planning

### Sprint Dependencies

```
Sprint 0 (Platform Setup)
    ↓
Sprint 1 (Post 1 Foundation) ←→ Sprint 2-5 can research in parallel
    ↓
Sprint 2 (Post 2 Deep Dive)
    ↓
[Post 3, 4, 5 can run in parallel or sequentially depending on team capacity]
    ↓
Post-Sprint Measurement (quarterly review after all posts have matured)
```

### Task Estimation

Typical task breakdown by sprint:

- **Sprint 0**: ~18 tasks (platform setup + editorial foundation)
- **Each Content Sprint**: ~38 tasks per post
  - Research & Outline: 6 tasks
  - Draft: 7 tasks
  - Technical Review: 5 tasks
  - Copyedit & SEO: 9 tasks
  - Publish & Distribute: 10 tasks
  - Measurement: 6 tasks
- **Post-Sprint Measurement**: ~11 tasks (quarterly analysis)
- **Total for first 5 posts**: ~195 tasks

### When NOT to Generate Tasks

- If plan.md contains [NEEDS CLARIFICATION] markers (ask user to complete plan first)
- If Constitution Check not passed (ask user to revise plan)
- If blog type not clearly defined (ask for clarification)

### How Blog Type Affects Tasks

**Authority Blog Tasks:**
- Emphasis on competitive analysis (detailed gap analysis)
- Longer drafting timelines
- More rigorous technical review
- Media outreach for benchmark posts
- Backlink acquisition strategy
- Citations in AI systems tracking

**Practitioner Blog Tasks:**
- Emphasis on code examples and runnable tutorials
- Quick iteration cycles
- Testing in clean environment mandatory for code posts
- Completion rate tracking for tutorials
- Community feedback rapid incorporation

**Community Blog Tasks:**
- Contributor coordination and outreach
- Shorter, profile-focused tasks
- High-frequency publishing support
- Community growth metrics
- Relationship maintenance tasks

**Thought Leadership Blog Tasks:**
- Speaking engagement tracking
- Media citation monitoring
- Executive visibility metrics
- Industry analysis depth
- Quarterly reflection/synthesis posts
