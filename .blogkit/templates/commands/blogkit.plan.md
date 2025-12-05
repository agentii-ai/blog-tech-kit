---
description: Create an editorial workflow and technical implementation plan for blog operations.
handoffs:
  - label: Generate Tasks
    agent: blogkit.tasks
    prompt: Generate content production tasks based on plan
    send: true
  - label: Clarify Blog Strategy
    agent: blogkit.clarify
    prompt: Clarify any underspecified areas before planning
    send: true
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

The text the user typed after `/blogkit.plan` in the triggering message **is** the technical context for the blog plan. Assume you always have it available in this conversation even if `$ARGUMENTS` appears literally below. Do not ask the user to repeat it unless they provided an empty command.

Given the blog strategy specification and the technical context, create a comprehensive editorial and technical plan:

1. **Load Required Specification Files**:
   - Read `spec.md` from the current feature directory
   - Extract: Blog Type, Target Audience, Content Pillars, Publishing Cadence, Success Criteria

2. **Validate Content-First Principle**:
   - Confirm spec.md contains ZERO technology mentions (no CMS, frameworks, hosting, analytics)
   - If technology found in spec: REJECT and ask user to revise spec first
   - Continue only when spec is Content-First

3. **Parse Technical Context from User Input**:
   - Extract technology choices from $ARGUMENTS
   - Identify: CMS Platform, Framework, Hosting, Analytics, Newsletter, Distribution Tools
   - Document rationale for each choice

4. **Simplicity & Focus Gate**:
   - If user mentions custom CMS BEFORE 10 published posts: WARN "Custom CMS before 10 posts violates Simplicity principle. Recommend using battle-tested platform first."
   - If user mentions overly-complex architecture for blog MVP: WARN "Over-engineered solution detected. Recommend simplifying to core features first."
   - Document warnings but allow override if user explicitly justifies

5. **Generate Research Phase (if needed)**:
   - Check if spec.md contains [NEEDS CLARIFICATION] markers
   - If > 3 markers exist: Create `research.md` with investigation plan
   - If markers exist but ≤ 3: Document clarifications in plan.md Assumptions section

6. **Create Editorial Workflow Section**:
   - Define content production process (Research → Draft → Review → Copyedit → Publish)
   - Map to User Blog Type's recommended timeline:
     - Authority: 6-week sprint per post
     - Practitioner: 2-week sprint per post
     - Community: 1-week sprint per spotlight
     - Thought Leadership: 4-week sprint per piece
   - Define roles: Writer, SME, Copyeditor, Marketing
   - CRITICAL: Technical review by SME who didn't write post (No Self-Validation principle)

7. **Create Technical Stack Section**:
   - Document CMS choice with rationale
   - Document Framework choice with rationale
   - Document Hosting choice with rationale
   - Document Performance Goals (Core Web Vitals, page load times)
   - Validate against Simplicity & Focus principle

8. **Create Tools & Integrations Section**:
   - Analytics platform and metrics tracking
   - Newsletter platform and automation
   - SEO tools and keyword tracking
   - Workflow tools (content planning, drafting, review)
   - Code example validation approach (if technical blog)

9. **Create AI Discoverability & SEO Section**:
   - JSON-LD schema implementation strategy
   - Heading hierarchy standards (H1→H2→H3)
   - Code example best practices
   - SEO implementation checklist (15 items)

10. **Create Distribution Strategy Section**:
    - 3-Tier Model: Owned (blog, newsletter, YouTube)
    - Amplification: Twitter, LinkedIn, Dev.to, Hashnode, Medium
    - Community: Reddit, Hacker News, Discord, Slack, GitHub
    - Social distribution workflow (Day 0-7 timeline)
    - Newsletter strategy (frequency, content structure, growth tactics)

11. **Create Content Calendar & Production Plan**:
    - Year 1 Content Map (Q1-Q4 with post targets)
    - Year 1 Cumulative Targets (traffic, signups, citations, rankings)
    - First 5 Authority Posts (Foundation, Deep Dive, Anti-Pattern, Ecosystem, Benchmark/Data)

12. **Constitution Check (GATE)**:
    - Validate all 8 Core Blog Principles:
      - [ ] Content-First: Spec defined before tech choices
      - [ ] No Self-Validation: SME review by non-author
      - [ ] Simplicity & Focus: No custom CMS before 10 posts
      - [ ] AI-Native Distribution: JSON-LD, H2/H3, FAQ sections
      - [ ] Community Over Broadcast: Plan includes community features
      - [ ] Transparency Over Perfection: Edge cases documented
      - [ ] Long-term Over Quick Wins: 2-3 year strategy
      - [ ] Measurable Outcomes: Each SC has tracking implementation
    - If any principle violated: WARN but allow explicit override
    - Document justification if overriding

13. **Create Project Structure Section**:
    - Documentation directory structure (spec, plan, research, editorial-guide, content-calendar)
    - Blog repository structure (4 options: Next.js+MDX, Ghost, Hugo, WordPress+Headless)
    - Ask user to choose or accept default (Next.js + MDX for technical blogs)

14. **Create Phases & Milestones Section**:
    - Phase 0: Research (if clarifications needed)
    - Phase 1: Platform Setup & Editorial Foundation (1-2 weeks)
    - Phase 2: Content Production (first 5 posts, 12-15 weeks)
    - Phase 3: Measurement & Iteration (3 months)

15. **Generate Success Criteria Tracking Implementation**:
    - For each SC from spec.md, define:
      - Measurement tool (Plausible, ConvertKit, manual search)
      - Tracking formula (if applicable)
      - Review cadence (weekly, monthly, quarterly)

16. **Identify Dependencies & Constraints**:
    - Editorial team (Writer, SME, Copyeditor, Marketing)
    - Tools & platforms (CMS, hosting, analytics, newsletter, domain)
    - Content resources (SMEs, code repos, design assets)
    - External dependencies (GitHub, DNS, CDN)
    - Budget and timeline constraints
    - SEO and legal constraints

17. **Create Risk Mitigation Plan**:
    - Risk: Content doesn't rank → Mitigation: Keyword research, low-competition focus
    - Risk: Writer capacity → Mitigation: Start 1/month, hire freelancer if traction
    - Risk: Technical errors → Mitigation: Mandatory SME review, CI/CD testing
    - Risk: Over-engineering → Mitigation: Follow Simplicity principle
    - Risk: Competitor content → Mitigation: Monitor weekly, pivot angle if needed

18. **Generate Quickstart Guide** (optional):
    - Create `quickstart.md` with:
      - Getting started checklist for first post
      - Platform deployment instructions
      - SEO metadata template
      - Newsletter signup setup
      - Social distribution template

19. **Write Plan File**:
    - Generate PLAN_FILE at `specs/[NNN-feature]/plan.md`
    - Use `.blogkit/templates/plan-template.md` as structure
    - Fill all sections with content from steps 1-18
    - Replace placeholders with actual values
    - Remove unused sections

20. **Plan Quality Validation**:
    - Create validation checklist at `FEATURE_DIR/checklists/plan-validation.md`:

      ```markdown
      # Editorial Plan Validation Checklist: [BLOG NAME]

      - [ ] Editorial workflow defined (roles, timelines, quality control)
      - [ ] Technical stack chosen (CMS, framework, hosting, analytics, newsletter)
      - [ ] AI optimization strategy documented (JSON-LD, heading hierarchy, code examples)
      - [ ] Distribution strategy defined (3-tier model)
      - [ ] Content calendar mapped (Year 1 plan, first 5 posts)
      - [ ] Constitution Check passed (all 8 principles validated)
      - [ ] Success criteria tracking defined (how each SC will be measured)
      - [ ] Dependencies and constraints documented
      - [ ] Risks identified with mitigations
      - [ ] No [NEEDS CLARIFICATION] markers remain in plan (or research.md created)
      - [ ] Simplicity & Focus gate passed (no over-engineering)
      - [ ] All handoff links to referen documentation present
      ```

    - Review plan against each item:
      - If all pass: Mark complete, proceed to step 21
      - If items fail: List failures, update plan to address, re-validate (max 2 iterations)

21. **Report Completion**:
    - Display plan file path (PLAN_FILE)
    - Display validation checklist status (✓ PASS or ✗ FAIL with issues)
    - Show Next Steps:
      1. Review plan.md for accuracy
      2. Approve tech stack choices
      3. Run `/blogkit.tasks` to generate content production tasks
      4. Proceed to Phase 1: Platform Setup

**NOTE**: The plan bridges Content-First specification (spec.md) with implementation reality (tech choices). It defines HOW to execute the content strategy while respecting blog-tech-kit principles.

## General Guidelines

### Content-First Enforcement

The specification phase was Content-First (no technology). NOW we make technology choices. This plan documents those choices and validates they serve the content strategy (not vice versa).

**Re-validate Content-First gate**: Spec.md should contain ZERO:
- CMS platforms (WordPress, Ghost, Webflow, etc.)
- Frameworks (Next.js, Astro, Hugo, etc.)
- Hosting (Vercel, Netlify, AWS, etc.)
- Analytics tools (Google Analytics, Plausible, etc.)
- Newsletter platforms (Mailchimp, Substack, ConvertKit, etc.)

If spec.md mentions technology: STOP and ask user to revise spec using `/blogkit.specify`.

### Simplicity & Focus Principle

**WARN if user requests**:
- Custom CMS before 10 published posts
- Multiple frameworks or architectures
- Overly-complex deployment pipelines
- Premium platform upgrades before traffic justifies

**Recommended defaults**:
- CMS: Next.js + MDX (for technical blogs) or Ghost (for non-technical)
- Hosting: Vercel (free tier, auto-deploy from GitHub)
- Analytics: Plausible (privacy-first, simple)
- Newsletter: ConvertKit (creator-focused, good integrations)
- Editing: GitHub Pull Requests (for markdown blogs)

### Editorial Workflow Recommendations

**Authority Blog Timeline**: 6-week sprint per post
- Week 1: Research & Planning (competitive analysis, outline, angle)
- Week 2: Drafting (main content, code examples, evidence)
- Week 3: Review & Revision (structural, technical, clarity edits)
- Week 4: Polish (SEO, metadata, final edits)
- Week 5: Distribution prep (social copy, newsletter, graphics)
- Week 6: Publish & Measure (post, distribute, monitor performance)

**Practitioner Blog Timeline**: 2-week sprint per post
- Days 1-2: Research & outline (topic, competitive analysis)
- Days 3-4: Draft (main content, working code)
- Days 5-6: Review (code testing, clarity, accuracy)
- Days 7-8: Polish (SEO, examples, copyedit)
- Days 9-10: Publish & distribute
- Days 11-14: Monitor & iterate

### Constitution Principles Reference

**8 Core Blog Principles** (must validate all):

| Principle | Definition | Implementation |
|-----------|-----------|-----------------|
| **Content-First** | Technology choices AFTER content strategy | Spec.md has ZERO tech mentions |
| **No Self-Validation** | SME review by non-author | Editorial workflow requires SME review |
| **Simplicity & Focus** | No custom CMS before 10 posts | Use battle-tested platforms |
| **AI-Native Distribution** | JSON-LD, H2/H3, FAQ sections | Plan documents these requirements |
| **Community Over Broadcast** | Blog amplifies community | Distribution plan includes community channels |
| **Transparency Over Perfection** | Edge cases, failure modes documented | Plan addresses risks and mitigations |
| **Long-term Over Quick Wins** | 2-3 year strategy, not viral chasing | Content calendar spans 12 months+ |
| **Measurable Outcomes** | Every SC has tracking implementation | Plan documents how each SC measured |

### Tech Stack Decision Framework

**Choose CMS based on blog type**:

| Blog Type | Recommended CMS | Rationale |
|-----------|-----------------|-----------|
| **Authority** | Next.js + MDX or Astro | Markdown + versioning, fast builds, SEO-ready |
| **Practitioner** | Next.js + MDX | Code examples, components, markdown |
| **Community** | Ghost or Webflow | Visual editor for non-developers, easy contributions |
| **Thought Leadership** | Ghost or WordPress | Editorial simplicity, easy image handling |

**Choose Hosting based on team**:

| Team Type | Recommended Host | Rationale |
|-----------|------------------|-----------|
| **Developer team** | Vercel (free tier) | Auto-deploy from GitHub, instant scaling |
| **Non-technical team** | Netlify (free tier) | Visual builds, CMS integrations |
| **Enterprise** | AWS/Cloudflare | Full control, custom infrastructure |

### Success Criteria Measurement Implementation

**Example mapping** (from spec.md → plan.md):

- **SC-001**: "Achieve 50K monthly visitors by Month 6"
  - Tool: Plausible Analytics
  - Tracking: Monthly unique visitors dashboard
  - Review: Monthly, reported in Phase 3 iteration

- **SC-005**: "10% newsletter signup rate"
  - Tool: ConvertKit
  - Tracking: (signups / visitors) * 100
  - Review: Weekly A/B testing

- **SC-011**: "5 citations in AI systems within 12 months"
  - Tool: Manual search (ChatGPT, Claude, Perplexity)
  - Tracking: Quarterly check
  - Review: Quarterly in Phase 3

### Validation Checklist Items

Before `/blogkit.tasks`, verify:

- [ ] Editorial workflow defined (roles, timelines, passes)
- [ ] Technical stack chosen (all 5 components: CMS, Framework, Hosting, Analytics, Newsletter)
- [ ] AI optimization documented (JSON-LD, H2/H3, FAQ, code examples)
- [ ] Distribution strategy defined (all 3 tiers, Day 0-7 timeline)
- [ ] Content calendar mapped (Year 1 quarters, first 5 posts detailed)
- [ ] Constitution Check passed (all 8 principles validated)
- [ ] Success criteria tracking defined (tool, formula, cadence for each SC)
- [ ] No over-engineering detected (Simplicity gate passed)
- [ ] Risks identified with concrete mitigations
- [ ] Dependencies documented (team, tools, resources)
