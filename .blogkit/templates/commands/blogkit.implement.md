---
description: Execute content production tasks systematically with quality control and progress tracking.
handoffs:
  - label: Analyze Results
    agent: blogkit.analyze
    prompt: Analyze implementation results and quality metrics
    send: true
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

Execute content production tasks systematically from tasks.md with quality gates and progress tracking:

1. **Load Required Files**:
   - Read `tasks.md` from current feature directory
   - Read `plan.md` to understand tech stack and quality standards
   - Read `editorial-guide.md` (if exists) for style/voice standards
   - Extract blog type, editorial workflow, team roles

2. **Parse Task Breakdown**:
   - Extract all sprint phases (Sprint 0, Sprint 1-5)
   - Extract all task phases within each sprint (Research, Draft, Review, Copyedit, Publish, Measure)
   - Identify task dependencies and sequential/parallel execution markers [P]
   - Build execution graph (tasks must complete in order respecting dependencies)

3. **Initialize Execution Tracking**:
   - Create or load execution state file: `.blogkit/execution-state.md`
   - Track: Current sprint, current phase, tasks completed, tasks in progress, blockers
   - Initialize progress dashboard:
     ```
     Blog Content Production Progress
     ════════════════════════════════════════
     Sprint 0: Platform Setup
       [████████░░░░░░░░░░░░░░░░] 40% (8/20 tasks)

     Sprint 1: Foundation Post
       [░░░░░░░░░░░░░░░░░░░░░░░░] 0% (0/38 tasks)
     ```

4. **Validate Preconditions**:
   - Verify all required files exist (spec.md, plan.md, tasks.md)
   - Verify Constitution Check passed (from plan.md)
   - Verify no [NEEDS CLARIFICATION] markers remain in spec/plan
   - Verify team roles and SME assignments documented
   - If preconditions fail: STOP and report what's missing

5. **Execute Sprint 0: Platform Setup** (if starting):
   - Orchestrate platform setup tasks (18 tasks total)
   - Verify deployment successful (platform live on domain)
   - Confirm analytics configured (tracking enabled)
   - Confirm newsletter integrated (signup working)
   - Confirm SEO configured (XML sitemap, robots.txt, GSC)
   - Quality gate: All platform tasks checked off
   - On completion: Mark Sprint 0 COMPLETE, ready for first post

6. **Execute Content Sprints (Sprints 1-5)**:

   For each sprint (one post per sprint):

   **Phase 1: Research & Outline** (6 tasks):
   - Competitive analysis documented
   - Keyword research complete (target keyword < 5K/month)
   - Outline created with H2/H3 structure
   - Evidence gathered (links, screenshots, benchmarks)
   - Code examples listed (if technical)
   - SME kickoff scheduled
   - Quality gate: Outline reviewed by SME before drafting

   **Phase 2: Draft** (7 tasks):
   - Main content written (word count per blog type)
   - Code examples implemented and tested
   - Visuals created or sourced
   - Internal links drafted (2-3 related posts)
   - External links added (1-2 authoritative sources)
   - FAQ section written
   - TLDR summary written
   - Quality gate: Draft complete and readable (spell check pass)

   **Phase 3: Technical Review** (5 tasks):
   - Code examples tested in clean environment
   - SME technical review by NON-AUTHOR (critical gate)
   - Accuracy verified (facts, benchmarks, citations current)
   - Feasibility confirmed (instructions work end-to-end)
   - Security review (if applicable)
   - Quality gate: SME sign-off on accuracy

   **Phase 4: Copyedit & SEO** (9 tasks):
   - Structural edit (outline matches content, logical flow)
   - Clarity edit (concepts explained, jargon appropriate)
   - Grammar/spelling proofread
   - SEO optimization (keyword placement, meta description)
   - H2/H3 hierarchy optimized for LLM parsing
   - Meta description written (150-160 chars)
   - Open Graph and Twitter Card tags added
   - Internal link anchor text optimized
   - Final proofread and formatting
   - Quality gate: SEO checklist 100% complete

   **Phase 5: Publish & Distribute** (10 tasks):
   - Canonical URL verified
   - Publish time scheduled (optimal: Tue-Thu 7-9 AM EST)
   - Post published and verified on homepage
   - JSON-LD schema validated
   - Analytics tracking verified
   - Newsletter sent to subscribers (Day 0)
   - Twitter thread posted (3-5 tweets, Day 0)
   - LinkedIn post created (Day 0)
   - Dev.to cross-post (Day 1-2)
   - Community sharing executed (Discord/Slack, Day 1-2)
   - Quality gate: Post live and distributed to all channels

   **Phase 6: Measurement & Iteration** (6 tasks):
   - Analytics reviewed after 1 week (traffic, engagement, scroll depth)
   - Keyword rankings checked (target keyword + related keywords)
   - Social engagement analyzed (3-day metrics)
   - Backlinks identified (month 1)
   - Performance documented in analytics-log.md
   - Lessons learned captured for next post
   - Quality gate: Performance baseline established

7. **Quality Gate Implementation**:

   **Critical Gates (STOP if failed)**:
   - SME technical review by NON-AUTHOR (No Self-Validation)
   - SEO checklist 100% complete before publish
   - Post lives on correct domain with analytics firing
   - Content-First principle maintained (NO technology mentions in spec)

   **Blocking Gates (ASK user to proceed)**:
   - Post underperforming after 1 week (< 50% traffic goal)
   - Keyword not ranking after 1 month
   - High bounce rate (> 50%) or low time-on-page (< 1 minute)
   - Community feedback indicates accuracy issues

   **Progress Gates (inform but continue)**:
   - Task completed
   - Phase completed
   - Sprint completed
   - Milestone reached

8. **Progress Reporting**:

   After each task completion:
   ```
   ✓ T019: Competitive analysis complete
     Phase 1: Research & Outline [████████░░] 6/7 tasks
     Sprint 1: Foundation Post [████░░░░░░] 6/38 tasks (Phase 1/6)
   ```

   After each phase completion:
   ```
   ✓ PHASE COMPLETE: Research & Outline
     All 6 tasks completed
     Quality gate: PASS (outline reviewed by SME)
     Next: Begin Phase 2 - Draft
   ```

   After each sprint completion:
   ```
   ✓ SPRINT COMPLETE: Sprint 1 - Foundation Post
     All 38 tasks completed
     Post published: "How to Build AI Systems" (2,847 words)
     Performance: 1.2K pageviews, 3:45 avg time-on-page, 8% newsletter signup
     Next: Begin Sprint 2 - Deep Dive Post
   ```

9. **Blocker Handling**:

   If quality gate fails:
   ```
   ⚠ QUALITY GATE FAILED

   Gate: SME Technical Review
   Issue: SME found factual inaccuracy in section 3
   Details: "Code example uses deprecated API (v1.x instead of v2.x)"

   Action Required:
   1. Update content to correct factual error
   2. Re-run SME technical review
   3. Confirm gate status before proceeding to copyedit

   Options:
   - (a) Fix now and re-check
   - (b) Pause and manual review needed
   - (c) Skip technical review (NOT recommended - violates No Self-Validation)
   ```

10. **Task State Management**:
    - Update tasks.md to mark completed tasks as [X]
    - Maintain execution state in `.blogkit/execution-state.md`
    - Track blockers and resolutions
    - Document timestamps for each phase completion

11. **Execution Modes**:

    **Full Sprint Execution** (default):
    - Execute all 38 tasks for current sprint
    - Run through all 6 phases sequentially
    - Measure and iterate at end

    **Phase-Only Execution** (flag: `--phase N`):
    - Execute only a specific phase of current sprint
    - Useful for recovery or re-running phase
    - Respects quality gates for that phase

    **Parallel Content** (flag: `--parallel N`):
    - While Sprint 1 is in Copyedit, start Sprint 2 Research
    - Useful for multi-person teams
    - Requires role assignment (Writer A on Sprint 1, Writer B on Sprint 2)

12. **Report Completion**:
    - Display final sprint/post summary
    - Show performance metrics against success criteria
    - Recommend next steps (continue to next sprint, iterate current, pause)
    - Offer options to proceed to Sprint N or run `/blogkit.analyze` for cross-artifact review

**NOTE**: Implementation execution is methodical and gated. Quality matters more than speed. No publishing without SME review of accuracy.

## Execution Guidelines

### Sprint 0 (Platform Setup) Checklist

Before first post:
- [ ] Domain configured and SSL verified
- [ ] Blog platform deployed (CMS/Framework/Hosting live)
- [ ] Analytics configured (pageviews, scroll depth, conversions tracked)
- [ ] Newsletter platform integrated (signup forms working)
- [ ] SEO tools configured (GSC, Analytics, sitemap)
- [ ] Editorial guide created and team trained
- [ ] SME assignments confirmed
- [ ] Content calendar finalized for Posts 1-5

### Per-Post Quality Gates

**Research Phase**:
- [ ] Outline has clear H2/H3 hierarchy (no skipping levels)
- [ ] SME kickoff scheduled and confirmed

**Draft Phase**:
- [ ] Code examples tested in clean environment
- [ ] Word count matches blog type (Authority: 1,500-3,000, Practitioner: 800-1,200)
- [ ] All links are current and working

**Technical Review Phase**:
- [ ] SME review by NON-AUTHOR (different person than writer)
- [ ] All code examples verified working
- [ ] Facts and benchmarks are current

**Copyedit & SEO Phase**:
- [ ] H2/H3 hierarchy verified
- [ ] Target keyword in title, first H2, first 100 words
- [ ] Meta description 150-160 chars with target keyword
- [ ] Internal links (2-3 posts) and external links (1-2 sources)
- [ ] JSON-LD schema template ready
- [ ] FAQ section present (for posts > 1,500 words)
- [ ] Open Graph and Twitter Card tags prepared

**Publish Phase**:
- [ ] Canonical URL set
- [ ] Published to correct domain
- [ ] Analytics tracking fires (check console on live page)
- [ ] Newsletter sent to subscribers
- [ ] Social distribution executed (Twitter, LinkedIn, Day 0)
- [ ] Community sharing completed (Discord/Slack, Day 1-2)

**Measurement Phase**:
- [ ] Analytics reviewed after 1 week
- [ ] Keyword rankings checked
- [ ] Social engagement tracked
- [ ] Performance documented
- [ ] Lessons learned for next post

### Failure Recovery

If a task fails or blocker occurs:

1. **Identify failure**: What task/phase failed and why?
2. **Assess impact**: Does it block other tasks or can work continue?
3. **Get decision**: Ask user how to proceed (fix, skip, pause)
4. **Document**: Record blocker in execution state
5. **Resume**: Continue from next unblocked task

Example blockers:
- **SME unavailable**: Can't proceed with Technical Review (gate fails)
- **Post underperforming**: Measurement shows goal not met (ask to iterate)
- **Platform issue**: Domain down or analytics misconfigured (pause until fixed)

### Team Coordination

For multi-person teams:
- Assign Writer to Draft/Research phases
- Assign SME to Technical Review (MUST be different person)
- Assign Copyeditor to Copyedit & SEO phase
- Assign Marketing to Publish & Distribute phase
- Each role executes assigned tasks in order

### Performance Targets

**Authority Blog**:
- Week 1: 500-1K pageviews
- Month 1: 2-5K pageviews
- Month 3: 5-20K pageviews
- Goal: 5-10 backlinks per post

**Practitioner Blog**:
- Week 1: 200-500 pageviews
- Month 1: 1-3K pageviews
- Month 3: 3-10K pageviews
- Goal: 3-5 backlinks, high tutorial completion rate

**Community Blog**:
- Week 1: 100-300 pageviews
- Month 1: 500-2K pageviews
- Focus: Engagement and community growth over traffic

**Thought Leadership**:
- Week 1: 300-1K pageviews
- Month 1: 2-5K pageviews
- Focus: Media citations, speaking invitations

If actual performance significantly below targets after 1 month, iterate on:
- Topic selection (higher search volume)
- Distribution strategy (more channels)
- Content quality (deeper research, better examples)
- SEO optimization (better keyword targeting)
