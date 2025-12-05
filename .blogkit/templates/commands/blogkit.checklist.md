---
description: Generate custom quality checklists tailored to blog type and requirements.
handoffs:
  - label: Execute Tasks
    agent: blogkit.tasks
    prompt: Generate content production tasks after checklist validation
    send: true
  - label: Analyze Quality
    agent: blogkit.analyze
    prompt: Cross-check quality against all checklists
    send: true
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

Generate custom quality checklists based on blog type and content requirements:

1. **Load spec.md and plan.md**:
   - Identify blog type (Authority, Practitioner, Community, Thought Leadership)
   - Extract target audience, content pillars, success criteria
   - Identify content focuses (technical, non-technical, mix)

2. **Generate Blog-Type Specific Checklists**:

   **Authority Blog Checklist** (deep research, citations):
   - [ ] Competitive analysis completed (5-10 competitor posts reviewed)
   - [ ] Unique angle identified (not just summarizing existing content)
   - [ ] Research methodology documented (sources, data, interviews)
   - [ ] Original data/research included (benchmarks, surveys, case studies)
   - [ ] Backlink strategy defined (which sites might link here?)
   - [ ] Internal content cluster documented (which posts link to/from this?)
   - [ ] External expert citations included (quotes, links, references)
   - [ ] SEO potential verified (target keyword < 5K monthly searches)

   **Practitioner Blog Checklist** (practical how-tos, tutorials):
   - [ ] Prerequisites clearly stated upfront
   - [ ] Step-by-step instructions verified in clean environment
   - [ ] Code examples tested and working end-to-end
   - [ ] Expected output shown for each code example
   - [ ] Troubleshooting section included (common issues & fixes)
   - [ ] Time estimate provided (how long to complete?)
   - [ ] Dependencies documented (what needs to be installed?)
   - [ ] Next steps provided (what to learn after completing this?)

   **Community Blog Checklist** (spotlights, case studies):
   - [ ] Subject/contributor given advance notice and approval
   - [ ] Story told in subject's own words (when possible)
   - [ ] Highlights subject's unique contributions to community
   - [ ] Links to subject's work, social, projects included
   - [ ] Call-to-action for community to follow subject
   - [ ] Published on subject's social channels (cross-promotion)
   - [ ] Community members encouraged to comment/engage
   - [ ] Follow-up plan (how will we stay connected?)

   **Thought Leadership Blog Checklist** (executive perspective):
   - [ ] Clear perspective/opinion (not just facts)
   - [ ] Backed by experience/data (credibility)
   - [ ] Industry context provided (market trends, competitor moves)
   - [ ] Forward-looking predictions included (where is industry going?)
   - [ ] Actionable recommendations for leaders
   - [ ] Speaking engagement opportunities referenced
   - [ ] Media-friendly soundbites included (quotable phrases)
   - [ ] Suitable for press release / media outreach

3. **Generate Content-Type Specific Checklists**:

   **Technical Blog Post Checklist**:
   - [ ] Code examples run in clean environment
   - [ ] All code is version-specific (mentions versions used)
   - [ ] Dependencies listed and versioned
   - [ ] Security implications documented (if applicable)
   - [ ] Performance implications mentioned (if applicable)
   - [ ] Common pitfalls/anti-patterns warned against
   - [ ] Links to official documentation included
   - [ ] Compatible with target platform versions

   **Non-Technical Blog Post Checklist**:
   - [ ] Jargon explained before first use
   - [ ] Analogies/metaphors help explain concepts
   - [ ] Visuals break up text (images, diagrams)
   - [ ] Examples use relatable scenarios
   - [ ] Conclusion summarizes key takeaways
   - [ ] Accessible to non-expert readers
   - [ ] Metrics/numbers explained with context
   - [ ] No technical assumptions about reader

4. **Generate SEO & AI Optimization Checklist**:
   - [ ] H1 title contains target keyword
   - [ ] H2/H3 hierarchy logical (no skipping levels)
   - [ ] Target keyword in first 100 words
   - [ ] Internal links to 2-3 related posts
   - [ ] External links to 1-2 authoritative sources
   - [ ] Meta description 150-160 chars, includes keyword
   - [ ] FAQ section present (for posts > 1,500 words)
   - [ ] JSON-LD Article schema will be implemented
   - [ ] Image alt text descriptive and includes keyword (where natural)
   - [ ] Canonical URL set (if cross-posting)
   - [ ] Open Graph tags prepared (og:title, description, image)
   - [ ] Twitter Card tags prepared (twitter:card, title, description, image)

5. **Generate Editorial Review Checklist**:
   - [ ] Spelling/grammar proofread
   - [ ] Voice consistent throughout (matches editorial guide)
   - [ ] Tone matches blog type (authority = formal, practitioner = helpful, community = warm)
   - [ ] Citations formatted consistently
   - [ ] Links use descriptive anchor text (not "click here")
   - [ ] Key terms bolded for emphasis (used sparingly)
   - [ ] Transitions between sections smooth
   - [ ] Conclusion calls reader to action
   - [ ] Links work and point to current content
   - [ ] Images have captions and alt text

6. **Generate Distribution & Analytics Checklist**:
   - [ ] Social copy drafted (Twitter, LinkedIn, Dev.to)
   - [ ] Newsletter preview text written
   - [ ] Analytics events configured (scroll depth, conversions)
   - [ ] Newsletter signup CTA placed at post end
   - [ ] Publish time scheduled (optimal: Tue-Thu 7-9 AM EST)
   - [ ] Social distribution timeline created (Day 0, 1-2, 3-7)
   - [ ] Community platforms identified for sharing
   - [ ] Backlink/citation tracking set up
   - [ ] Performance baseline established (traffic goal, engagement goal)

7. **Output Checklists**:
   - Create markdown file at `FEATURE_DIR/checklists/quality-checklist.md`
   - Include all relevant checklists (based on blog type + content type)
   - Use consistent checkbox format: `- [ ] Item description`
   - Group by category with headers
   - Include brief why for each section

8. **Report Completion**:
   - Show checklist file path
   - Display checklist categories and item counts
   - Show recommended workflow: Use checklist during editorial process
   - Offer next step: `/blogkit.tasks` to generate production tasks

**NOTE**: Checklists are quality gates. Review before publishing to catch issues early.
