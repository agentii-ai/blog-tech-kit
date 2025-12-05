---
description: Identify underspecified areas in blog content spec through structured Q&A.
handoffs:
  - label: Revise Specification
    agent: blogkit.specify
    prompt: Revise blog content strategy based on clarifications
    send: true
  - label: Create Editorial Plan
    agent: blogkit.plan
    prompt: Create editorial plan based on clarified specification
    send: true
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

Given the blog content strategy specification (spec.md), identify underspecified areas and ask clarification questions:

1. **Load and Analyze spec.md**:
   - Read spec.md from current feature directory
   - Scan for [NEEDS CLARIFICATION] markers and vague sections
   - Identify ambiguous areas in: Blog Type, Target Audience, Content Pillars, Success Criteria

2. **Prioritize Clarifications**:
   - Priority 1 (Scope Impact): Blog type, target audience definition, content pillar focus
   - Priority 2 (Quality Impact): Publishing cadence, content length, quality standards
   - Priority 3 (Distribution Impact): Distribution channels, social strategy, engagement goals
   - **LIMIT**: Ask MAXIMUM 3 clarification questions across all priorities

3. **Generate Clarification Questions**:
   - For each clarification need, create a focused question with 3-4 suggested answers
   - Include context from spec.md showing why clarification is needed
   - Provide implications of each answer option
   - Format as markdown table for clarity

4. **Present Questions to User**:
   - Number questions Q1, Q2, Q3 (max 3)
   - Present all questions together before waiting for responses
   - Use clear markdown formatting with tables for options
   - Include context quotes from spec.md

5. **Wait for Responses**:
   - Ask user to respond with format: "Q1: [Option], Q2: [Custom answer], Q3: [Option]"
   - Accept option letters (A, B, C, Custom) or full custom text
   - Wait for complete set of responses before proceeding

6. **Update spec.md**:
   - Replace [NEEDS CLARIFICATION] markers with user's answers
   - Add "Clarifications" section documenting Q&A pairs
   - Maintain all existing spec content unchanged
   - Preserve formatting and structure

7. **Validate Updates**:
   - Confirm spec.md no longer contains [NEEDS CLARIFICATION] markers (or max 1-2 remaining)
   - Verify clarifications are consistent with rest of spec
   - Check for any new ambiguities that clarifications introduced

8. **Report Completion**:
   - Show updated spec.md path
   - Display clarifications documented
   - Show recommended next step: `/blogkit.plan` to create editorial workflow
   - Offer option to run `/blogkit.plan` directly

**NOTE**: Clarifications bridge vague specifications with concrete decisions. If spec is already clear, this command can be skipped.

## General Guidelines

### When to Use Clarify

**Use `/blogkit.clarify` when spec.md contains**:
- [NEEDS CLARIFICATION] markers
- Ambiguous blog type (multiple types equally valid)
- Vague target audience (unclear technical level, geographic scope)
- Unclear success criteria (not measurable or specific)
- Missing publishing cadence details
- Undefined content pillar priorities

**Skip `/blogkit.clarify` when spec.md**:
- Contains no [NEEDS CLARIFICATION] markers
- Has clear, specific answers for all mandatory sections
- Is ready for planning phase
- User explicitly skips with "skip clarification" or "/blogkit.plan" directly

### Clarification Question Examples

#### Blog Type Clarification (if Authority vs. Practitioner ambiguous)

**Context**: Your spec could work as either Authority (deep research, 6-week cycles) or Practitioner (practical how-tos, 2-week cycles)

| Option | Blog Type | Implications |
|--------|-----------|--------------|
| A | Authority | 1 post/quarter, 1,500-3,000 words, backlink/citation focus, 6-week production |
| B | Practitioner | 2-4 posts/month, 800-1,200 words, tutorial completion focus, 2-week production |
| C | Hybrid | Mix of both types with clear separation (e.g., "Foundation" posts quarterly, tutorials monthly) |
| Custom | Provide specific blog type | Describe your preferred approach |

#### Target Audience Clarification (if technical level unclear)

**Context**: Your spec mentions "developers" but technical level isn't specified

| Option | Audience | Implications |
|--------|----------|--------------|
| A | Beginners | Explain fundamentals, include setup guides, minimize assumed knowledge |
| B | Intermediate | Assume familiarity with basics, focus on patterns and best practices |
| C | Advanced | Assume deep expertise, focus on optimization and edge cases |
| Custom | Describe specific audience | Specify background, pain points, experience level |

#### Success Criteria Clarification (if metrics unclear)

**Context**: You want "strong engagement" but haven't defined what that means

| Option | Metric | How We Measure |
|--------|--------|-----------------|
| A | Traffic-focused | "50K monthly visitors by month 6" (track via analytics) |
| B | Engagement-focused | "3+ minutes average time-on-page" (track via analytics) |
| C | Conversion-focused | "10% newsletter signup rate from blog traffic" (track via email platform) |
| Custom | Define custom metric | Specify exact measurement and target |

### Clarification Documentation Format

After clarifications, document them in spec.md Clarifications section:

```markdown
## Clarifications (from `/blogkit.clarify`)

**Q1: Blog Type**
- Question: Authority vs. Practitioner blog?
- Answer: Practitioner blog with 2-4 posts/month, 800-1,200 word tutorials
- Impact: Affects timeline (2-week cycles), content depth, success metrics

**Q2: Target Audience Technical Level**
- Question: Beginner, intermediate, or advanced developers?
- Answer: Intermediate developers with 1-2 years experience
- Impact: Affects explanation depth, assumed knowledge, example complexity

**Q3: Primary Success Metric**
- Question: Traffic, engagement, conversions, or citations?
- Answer: Engagement (3+ minutes average time-on-page) + conversions (10% newsletter signups)
- Impact: Affects distribution strategy, SEO focus, content topics
```
