---
description: Create or update the blog content strategy specification from a natural language feature description.
handoffs:
  - label: Build Editorial Plan
    agent: blogkit.plan
    prompt: Create a plan for the blog content strategy. I am building with...
  - label: Clarify Spec Requirements
    agent: blogkit.clarify
    prompt: Clarify blog content strategy requirements
    send: true
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

The text the user typed after `/blogkit.specify` in the triggering message **is** the blog content strategy description. Assume you always have it available in this conversation even if `$ARGUMENTS` appears literally below. Do not ask the user to repeat it unless they provided an empty command.

Given that blog strategy description, do this:

1. **Generate a concise short name** (2-4 words) for the branch:
   - Analyze the blog strategy description and extract the most meaningful keywords
   - Create a 2-4 word short name that captures the essence of the blog strategy
   - Use noun-focused format when possible (e.g., "authority-blog-ml", "practitioner-tutorials", "community-spotlight")
   - Preserve blog type indicators (authority, practitioner, community, thought-leadership)
   - Keep it concise but descriptive enough to understand the blog type at a glance
   - Examples:
     - "I want to create an authority blog for ML engineers" → "authority-blog-ml"
     - "Build practitioner tutorials for LangChain developers" → "practitioner-langchain-tutorials"
     - "Launch community spotlight blog" → "community-spotlight-blog"
     - "Create thought leadership content for AI founders" → "thought-leadership-ai-founders"

2. **Check for existing branches before creating new one**:

   a. First, fetch all remote branches to ensure we have the latest information:
      ```bash
      git fetch --all --prune
      ```

   b. Find the highest feature number across all sources for the short-name:
      - Remote branches: `git ls-remote --heads origin | grep -E 'refs/heads/[0-9]+-<short-name>$'`
      - Local branches: `git branch | grep -E '^[* ]*[0-9]+-<short-name>$'`
      - Specs directories: Check for directories matching `specs/[0-9]+-<short-name>`

   c. Determine the next available number:
      - Extract all numbers from all three sources
      - Find the highest number N
      - Use N+1 for the new branch number

   d. Run the script `.blogkit/scripts/bash/create-new-feature.sh --json "$ARGUMENTS"` with the calculated number and short-name:
      - Pass `--number N+1` and `--short-name "your-short-name"` along with the blog strategy description
      - Bash example: `.blogkit/scripts/bash/create-new-feature.sh --json --number 5 --short-name "authority-blog-ml" "Create authority blog for ML engineers"`
      - PowerShell example: `.blogkit/scripts/bash/create-new-feature.sh --json -Number 5 -ShortName "authority-blog-ml" "Create authority blog for ML engineers"`

   **IMPORTANT**:
   - Check all three sources (remote branches, local branches, specs directories) to find the highest number
   - Only match branches/directories with the exact short-name pattern
   - If no existing branches/directories found with this short-name, start with number 1
   - You must only ever run this script once per feature
   - The JSON is provided in the terminal as output - always refer to it to get the actual content you're looking for
   - The JSON output will contain BRANCH_NAME and SPEC_FILE paths
   - For single quotes in args like "I'm Groot", use escape syntax: e.g 'I'\''m Groot' (or double-quote if possible: "I'm Groot")

3. Load `.blogkit/templates/spec-template.md` to understand required sections.

4. **CRITICAL - Content-First Principle Enforcement**: The spec phase is ONLY for defining blog content strategy (WHAT content and WHY). Technology choices (HOW) belong in the plan phase.

   **Reject ANY of these in the spec phase**:
   - CMS platforms (WordPress, Webflow, Ghost, Hugo, Jekyll)
   - Frameworks (Next.js, Gatsby, Astro, SvelteKit)
   - Hosting providers (Vercel, Netlify, AWS, Cloudflare)
   - Analytics tools (Google Analytics, Plausible, Mixpanel)
   - Newsletter platforms (Mailchimp, Substack, ConvertKit)
   - Any implementation technology

   **If the user mentions technology in their description**:
   - Politely redirect: "Let's focus on your blog content strategy first (blog type, audience, pillars, success metrics). We'll choose the right technology stack in the planning phase after we clarify what content you need."
   - Extract the content strategy intent from their description
   - Proceed with content-focused specification

5. Follow this execution flow:

    1. Parse user description from Input
       If empty: ERROR "No blog strategy description provided"
    2. Extract key blog concepts from description
       Identify: blog type, target audience, content themes, publishing goals
    3. For unclear aspects:
       - Make informed guesses based on refs/2_define_for_specify.md blog principles
       - Only mark with [NEEDS CLARIFICATION: specific question] if:
         - The choice significantly impacts blog type or audience
         - Multiple blog types are equally valid (e.g., Authority vs. Practitioner)
         - No reasonable default exists
       - **LIMIT: Maximum 3 [NEEDS CLARIFICATION] markers total**
       - Prioritize clarifications by impact: blog type > audience definition > content pillars > success metrics
    4. Fill Content Journeys section (how users discover and consume content)
       If no clear content flow: Use defaults from template (Search, Social, AI Citation)
    5. Generate Content Requirements (CR-001 to CR-020)
       Each requirement must be testable
       Use reasonable defaults for unspecified details (document assumptions in Assumptions section)
    6. Define Success Criteria (SC-001 to SC-016)
       Create measurable, technology-agnostic outcomes
       Align metrics with blog type (Authority: backlinks & citations, Practitioner: tutorial engagement, Community: contributor growth)
    7. Identify Content Pillars (3-5 problem-focused themes)
    8. Return: SUCCESS (spec ready for editorial planning)

6. Write the specification to SPEC_FILE using the blog template structure, replacing placeholders with concrete details derived from the blog strategy description (arguments) while preserving section order and headings.

7. **Specification Quality Validation**: After writing the initial spec, validate it against blog-specific quality criteria:

   a. **Create Spec Quality Checklist**: Generate a checklist file at `FEATURE_DIR/checklists/requirements.md` using this blog-specific validation structure:

      ```markdown
      # Blog Content Strategy Quality Checklist: [BLOG NAME]

      **Purpose**: Validate blog content strategy completeness and quality before proceeding to editorial planning
      **Created**: [DATE]
      **Feature**: [Link to spec.md]

      ## Content-First Quality

      - [ ] NO technology choices present (no CMS, frameworks, hosting, tools)
      - [ ] Focused on content strategy (blog type, audience, pillars)
      - [ ] Written for editorial/marketing stakeholders (not developers)
      - [ ] All mandatory sections completed (Blog Type, Audience, Pillars, Publishing Cadence)

      ## Blog Type & Audience Clarity

      - [ ] Blog type explicitly declared (Authority | Practitioner | Community | Thought Leadership)
      - [ ] Target audience persona defined with specific pain points
      - [ ] Primary audience's "where they are" documented (platforms, communities)
      - [ ] Content strategy aligns with blog type (e.g., Authority = 6-12 month ROI, deep research)

      ## Content Requirements

      - [ ] No [NEEDS CLARIFICATION] markers remain
      - [ ] Content requirements are testable and unambiguous
      - [ ] Success criteria are measurable (traffic, engagement, conversions)
      - [ ] Success criteria are technology-agnostic (no mentions of specific tools)
      - [ ] All content journeys are defined (Discovery, Social, AI Citation)
      - [ ] Edge cases identified (e.g., content doesn't rank, competitor publishes first)
      - [ ] Content scope clearly bounded (in-scope vs. out-of-scope)
      - [ ] Publishing cadence realistic for team capacity

      ## Content Pillar Quality

      - [ ] 3-5 content pillars defined
      - [ ] Each pillar is problem-focused (not technology-focused)
      - [ ] Each pillar has clear product connection
      - [ ] Example topics provided for each pillar
      - [ ] Pillars aligned with audience pain points

      ## Feature Readiness

      - [ ] All content requirements have clear acceptance criteria
      - [ ] Content journeys cover primary discovery channels
      - [ ] Blog strategy meets measurable outcomes defined in Success Criteria
      - [ ] No implementation details leak into specification (Content-First gate passed)

      ## Notes

      - Items marked incomplete require spec updates before `/blogkit.clarify` or `/blogkit.plan`
      ```

   b. **Run Validation Check**: Review the spec against each checklist item:
      - For each item, determine if it passes or fails
      - Document specific issues found (quote relevant spec sections)
      - **CRITICAL**: Check for technology mentions (CMS, frameworks, hosting, tools) - these violate Content-First principle

   c. **Handle Validation Results**:

      - **If all items pass**: Mark checklist complete and proceed to step 8

      - **If items fail (excluding [NEEDS CLARIFICATION])**:
        1. List the failing items and specific issues
        2. Update the spec to address each issue
        3. **If technology mentions found**: Remove them and note "Technology choices deferred to plan phase"
        4. Re-run validation until all items pass (max 3 iterations)
        5. If still failing after 3 iterations, document remaining issues in checklist notes and warn user

      - **If [NEEDS CLARIFICATION] markers remain**:
        1. Extract all [NEEDS CLARIFICATION: ...] markers from the spec
        2. **LIMIT CHECK**: If more than 3 markers exist, keep only the 3 most critical (blog type > audience > pillars > metrics) and make informed guesses for the rest
        3. For each clarification needed (max 3), present options to user in this format:

           ```markdown
           ## Question [N]: [Topic]

           **Context**: [Quote relevant spec section]

           **What we need to know**: [Specific question from NEEDS CLARIFICATION marker]

           **Suggested Answers**:

           | Option | Answer | Implications |
           |--------|--------|--------------|
           | A      | [First suggested answer] | [What this means for the blog strategy] |
           | B      | [Second suggested answer] | [What this means for the blog strategy] |
           | C      | [Third suggested answer] | [What this means for the blog strategy] |
           | Custom | Provide your own answer | [Explain how to provide custom input] |

           **Your choice**: _[Wait for user response]_
           ```

        4. **CRITICAL - Table Formatting**: Ensure markdown tables are properly formatted:
           - Use consistent spacing with pipes aligned
           - Each cell should have spaces around content: `| Content |` not `|Content|`
           - Header separator must have at least 3 dashes: `|--------|`
           - Test that the table renders correctly in markdown preview
        5. Number questions sequentially (Q1, Q2, Q3 - max 3 total)
        6. Present all questions together before waiting for responses
        7. Wait for user to respond with their choices for all questions (e.g., "Q1: A, Q2: Custom - [details], Q3: B")
        8. Update the spec by replacing each [NEEDS CLARIFICATION] marker with the user's selected or provided answer
        9. Re-run validation after all clarifications are resolved

   d. **Update Checklist**: After each validation iteration, update the checklist file with current pass/fail status

8. Report completion with branch name, spec file path, checklist results, and readiness for the next phase (`/blogkit.clarify` or `/blogkit.plan`).

**NOTE:** The script creates and checks out the new branch and initializes the spec file before writing.

## General Guidelines

## Quick Guidelines

- Focus on **WHAT** content you need and **WHY** it matters for your audience.
- Avoid HOW to implement (no CMS, frameworks, hosting, analytics tools).
- Written for editorial/marketing stakeholders, not developers.
- DO NOT create any checklists that are embedded in the spec. That will be a separate command.

### Section Requirements

- **Mandatory sections**: Blog Type Declaration, Target Audience, Content Pillars, Publishing Cadence, User Scenarios & Content Journeys, Content Requirements, Success Criteria
- **Optional sections**: Secondary Audience, Out of Scope, Assumptions, Dependencies, Constraints, Related Content
- When a section doesn't apply, remove it entirely (don't leave as "N/A")

### For AI Generation

When creating this blog spec from a user prompt:

1. **Make informed guesses**: Use context from refs/2_define_for_specify.md (blog writing principles) to fill gaps
2. **Document assumptions**: Record reasonable defaults in the Assumptions section
3. **Limit clarifications**: Maximum 3 [NEEDS CLARIFICATION] markers - use only for critical decisions that:
   - Significantly impact blog type or audience definition
   - Have multiple reasonable blog types with different implications (Authority vs. Practitioner)
   - Lack any reasonable default
4. **Prioritize clarifications**: blog type > audience definition > content pillars > success metrics > publishing cadence
5. **Think like an editor**: Every vague content requirement should fail the "testable and unambiguous" checklist item
6. **Common areas needing clarification** (only if no reasonable default exists):
   - Blog type choice (Authority vs. Practitioner vs. Community when equally valid)
   - Target audience technical level (beginner vs. intermediate vs. advanced)
   - Content pillar prioritization (if 5+ themes compete for focus)

**Examples of reasonable defaults** (don't ask about these):

- Publishing cadence: 2-4 posts/month for Practitioner, 1/quarter for Authority
- Content length: 1,500+ words for Authority, 800-1,200 for Practitioner
- SEO optimization: Target keywords with < 5,000 monthly search volume (low competition)
- Distribution: Twitter/LinkedIn + newsletter + Dev.to cross-posting
- AI optimization: JSON-LD Article schema, clear H2/H3 hierarchy, internal linking

### Success Criteria Guidelines

Success criteria for blogs must be:

1. **Measurable**: Include specific metrics (traffic, time-on-page, conversion rate, backlinks, citations)
2. **Technology-agnostic**: No mention of analytics tools, CMS platforms, or implementation details
3. **Audience-focused**: Describe outcomes from reader/business perspective, not technical systems
4. **Blog-type-aligned**: Authority = citations/backlinks, Practitioner = engagement/conversions, Community = contributor growth
5. **Verifiable**: Can be tested/validated without knowing implementation technology

**Good examples**:

- "Achieve 50K monthly unique visitors by Month 6"
- "Maintain average 3+ minutes time-on-page across all posts"
- "15% of posts rank on page 1 for target keyword within 3 months"
- "10 backlinks per post from external sources within 6 months"
- "5 citations in AI systems (ChatGPT, Claude, Perplexity) within 12 months"
- "10% newsletter signup rate from blog traffic"

**Bad examples** (technology-specific):

- "Google Analytics shows 50K visitors" (tool-specific, use "Achieve 50K monthly visitors")
- "Plausible analytics tracks engagement" (platform-specific)
- "WordPress SEO plugin score above 80" (CMS-specific)
- "Next.js page load time under 1 second" (framework-specific)
- "Ghost platform uptime 99.9%" (implementation detail)

### Content-First Principle Enforcement

**REJECT these mentions in spec phase** (defer to plan phase):

- **CMS Platforms**: WordPress, Ghost, Webflow, Contentful, Strapi, Hugo, Jekyll, Gatsby
- **Frameworks**: Next.js, Astro, SvelteKit, Remix, Nuxt, 11ty
- **Hosting**: Vercel, Netlify, AWS, Cloudflare Pages, GitHub Pages
- **Analytics**: Google Analytics, Plausible, Mixpanel, PostHog, Fathom
- **Newsletter**: Mailchimp, Substack, ConvertKit, Beehiiv, Ghost Newsletter
- **SEO Tools**: Ahrefs, SEMrush, Moz, Screaming Frog
- **Any implementation technology or tool selection**

**Redirect users**: "Let's define your content strategy first (blog type, audience, content pillars, success metrics). We'll choose the best technology stack in the planning phase (`/blogkit.plan`) based on your content needs."

### Blog Type Guidance

Use refs/2_define_for_specify.md to guide blog type selection:

| Blog Type | Best For | Publishing Cadence | ROI Timeline | Key Metrics |
|-----------|----------|-------------------|--------------|-------------|
| **Authority** | Canonical source of truth, deep research | 1 post/quarter | 6-12 months | Backlinks, citations, keyword rankings |
| **Practitioner** | How-to guides, tutorials, production patterns | 2-4 posts/month | 1-3 months | Engagement, conversions, tutorial completion |
| **Community** | User spotlights, case studies, contributor stories | Weekly cadence | Ongoing engagement | Contributor growth, community amplification |
| **Thought Leadership** | Executive perspective, industry analysis, vision | 1-2 posts/quarter | Brand building | Speaking invitations, media citations, executive visibility |

**When to clarify blog type** (only if truly ambiguous):

- User description fits multiple types equally well
- User mentions conflicting goals (e.g., "weekly authority posts" - frequency mismatch)
- User's audience and goals suggest different blog types

**Otherwise, make an informed guess** based on:
- Audience technical level (advanced = Authority, intermediate = Practitioner, mixed = Community)
- Publishing frequency mentioned (frequent = Practitioner, infrequent = Authority)
- Business stage (early = Practitioner for quick wins, mature = Authority for differentiation)
