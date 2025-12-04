> **Author:** frank@agentii.ai  
> **Version:** v0.0.3  
> **Last Updated (NYC):** 2025-12-03 04:34

# Instructions: How to Build Your Own Spec-Kit Variant (for Any Job)

This guide explains how to create a **Spec Kit–style variant** for any kind of work:

- Project management
- Product design
- Marketing & growth
- Business or technical writing

You’ll use the same **spec-driven workflow** that Spec Kit uses for software:

1. Define a **constitution** for your domain
2. Capture **principles & reference patterns** (step 0–1)
3. **Specify** what you want to accomplish (step 2)
4. **Plan** how work will be done (step 3)
5. Break work into **tasks** and checkpoints (step 4)
6. Keep adding **references & examples** (step 5)

The references in `refs/` (steps 0–5) are your *knowledge base*. They are not the work itself—they are what your agent (and you) read **before** doing work.

---

## 0. Core Concepts of a Spec-Kit Variant

Before the steps, internalize three ideas from the base constitution in `memory/constitution.md`:

- **Specification-first**: always write down *what* you are doing and *why* before *how*.
- **Evidence-driven**: connect specs, plans, and tasks to real evidence (users, data, stakeholders).
- **Phased workflow**: use the same stages in any domain: constitution → specify → clarify → plan → tasks → implement → refine.

We’ll now walk through how to adapt this pattern to *any* job.

---

## Step 0–5: Use `refs/` as Your Reference Layer

Steps 0–5 in this kit are **reference documents**, not templates you fill in directly. A new Spec-Kit variant should create **its own** versions of these, guided by the examples here.

### Step 0 – Overview: What Is This Kit For?

`refs/0_overview.md` shows how to write an *overview* for a focused topic.

For your variant, Step 0 should:

- Explain **what kind of work** this kit is for (e.g., “product design for SaaS dashboards,” “B2B content marketing,” “project management for research teams”).
- Summarize **why** this work benefits from spec-driven workflows (less chaos, clearer decisions, reusable prompts).
- Provide a **prompt template** (like the one at the top of `0_overview.md`) you can use in your agent to gather the latest best practices.

**Example – Product Design Kit Overview**

Your Step 0 might say:

> This kit helps designers and PMs run structured, repeatable design cycles for SaaS products (dashboard UX, onboarding flows, pricing pages). It emphasizes clear user journeys, reusable design patterns, and cross-functional collaboration.

And include a prompt like:

```markdown
```prompt_template
extensively search about [design topic]. looking for best practices from top successful [well-known products] and design systems.

write an overview.md about the background and principles of [design topic], planning and tasking for successful execution. based on the most recent [time] best practices.
```
```

### Step 1 – Principles: Your Domain “Constitution”

`refs/1_principles_for_constitution.md` demonstrates how to turn raw overview material into **principles and patterns**.

For your variant, Step 1 should:

- Turn raw references into **domain rules and patterns** the agent should follow.
- Answer: *“What does good look like in this kind of work?”*

**Example – Project Management Kit Principles**

Principles might include:

- Always define **scope, owner, and deadline** for each initiative.
- Use **incremental delivery**: break work into phases with independent value.
- Tie every major task to a **clear outcome and metric** (e.g., lead time, throughput, quality).
- Maintain a visible **risk & dependency list**.

You would add a Perplexity prompt (as in Step 1) that asks for the best modern project management patterns: Kanban, Scrum, critical path, dependency management, stakeholder communication, etc.

---

## Step 2 – Define: Specification for Your Work (`spec.md`)

`refs/2_ define_for_specify.md` corresponds to the **specification** phase. It is intentionally non-technical—it focuses on **who**, **what**, and **why**.

For your variant, a `spec.md` should answer:

- **Who** is this for? (personas, teams, stakeholders)
- **What** problem or outcome are we targeting?
- **What** does success look like in human terms (not implementation details)?
- **What constraints** or risks do we need to respect?

Think of Step 2 as: *“Write the brief.”*

### Good Step 2 Examples by Domain

#### Example – Project Management Initiative

- **Working name:** Q3 Customer Onboarding Revamp
- **Domain:** Project management for cross-functional product work
- **Primary personas:**
  - New customer success managers (CSMs)
  - New customers going through onboarding
- **Goals:**
  - Reduce time-to-first-value from 21 days to 7 days.
  - Increase onboarding completion rate from 60% to 85%.
- **Constraints:**
  - Must work with existing CRM and support tooling.
  - Cannot add more than two new mandatory steps for the customer.

#### Example – Product Design Project

- **Working name:** Analytics Dashboard v2
- **Domain:** Product design
- **Primary personas:**
  - Product managers tracking KPIs
  - Team leads monitoring daily ops
- **Goals:**
  - Enable users to see core KPIs at a glance in under 5 seconds.
  - Reduce usage of exported spreadsheets by 50%.

#### Example – Marketing Campaign

- **Working name:** “From Chaos to Clarity” Content Series
- **Domain:** B2B content marketing
- **Primary personas:**
  - Heads of Ops at mid-market SaaS
- **Goals:**
  - Generate 50 qualified leads in 8 weeks.
  - Drive 10 meetings booked with sales.

#### Example – Writing Project

- **Working name:** “Designing Reliable AI Systems” Whitepaper
- **Domain:** Thought leadership / technical writing
- **Primary personas:**
  - Staff engineers and CTOs at enterprise companies
- **Goals:**
  - Publish a 15–20 page whitepaper that can be used in sales conversations.
  - Generate 200 downloads in the first month.

Step 2 is always: **clear definition of who, what, and why—not how.**

---

## Step 3 – Plan: High-Level Plan (`plan.md`)

`refs/3_project_mangement_for_plan.md` shows how to turn a spec into a **plan** without dropping into low-level tasks.

A plan is about:

- **Objectives & time horizon** (for this effort)
- **Strategy & wedge** (what you will do first and why)
- **Launch & activation approach** (for anything that “goes live”)
- **Experiment or iteration roadmap** (how you’ll learn and adapt)
- **Measurement at a planning level** (what you check weekly/monthly)

### Example – Plan for a Product Design Project

- **Objective (6 weeks):** Ship a new dashboard layout that solves top 3 pain points discovered in spec.
- **Strategy:**
  - Start with **one critical use case** (daily health check) before tackling complex drill-downs.
  - Validate design first with internal users, then with 5–10 pilot customers.
- **Phases:**
  1. Week 1–2: Research synthesis & concept sketches
  2. Week 3–4: High-fidelity prototypes & usability tests
  3. Week 5–6: Implementation handoff, documentation, and rollout plan
- **Measurement:**
  - Prototype tests: time to find key metrics, error rates in interpretation.
  - Post-rollout: NPS for dashboard, self-reported usefulness.

### Example – Plan for a Marketing Campaign

- **Objective (8 weeks):** Generate 50 high-intent leads from a content series.
- **Strategy:**
  - Use a 3-part article series + LinkedIn posts + 1 webinar.
  - Focus on 1 persona and 1 problem narrative.
- **Phases:**
  1. Week 1–2: Outline topics and interview 3 customers.
  2. Week 3–5: Draft and publish articles; promote on social channels.
  3. Week 6–8: Host webinar; follow up with tailored outreach.
- **Measurement:**
  - Article views, signups for webinar, leads sourced.

Your `plan.md` is what the agent and the team use to understand **the big picture** of execution.

---

## Step 4 – Tasks: Executable Task Breakdown (`tasks.md`)

`refs/4_pm_tasking_for_tasks.md` mirrors `templates/tasks-template.md`, but focused on **execution for a domain** instead of code.

Tasks bridge the gap between plan and calendar:

- They are **assigned** (who does what).
- They are **sequenced** (dependencies, phases).
- They have **checkpoints** and **tests** (like PDCA loops).

### Tasking Patterns You Should Reuse

From `templates/tasks-template.md` and `4_pm_tasking_for_tasks.md`, adapt these ideas:

- Use **phases** with clear exit criteria (e.g., Discovery, Design, Launch).
- Mark parallelizable tasks with `[P]` to indicate they can run concurrently.
- Use labels like `[Story]` or `[Theme]` to tie tasks back to sections of the spec.
- Insert **STOP and VALIDATE** checkpoints before you move on.

### Example – Task Breakdown for Project Management Initiative

**Phase 1 – Discovery**

- [T1.1] Compile list of 20 recent onboarding projects and stakeholders  
  - Owner: PM  
  - Deliverable: stakeholder map
- [T1.2] Run 10 interviews with CSMs about onboarding pain points  
  - Owner: PM  
  - Deliverable: interview notes + synthesis
- [T1.3] Map current onboarding workflow and identify top 3 bottlenecks  
  - Owner: PM  
  - Deliverable: current-state diagram

**Checkpoint:** Review findings with product + CS leadership.

**Phase 2 – Design & Planning**

- [T2.1] Draft new onboarding journey with 3 key milestones  
  - Owner: PM  
  - Deliverable: future-state map
- [T2.2] Validate journey with 3 CSMs and 3 customers  
  - Owner: PM  
  - Deliverable: feedback doc

**Phase 3 – Rollout**

- [T3.1] Create playbook doc for CSMs  
  - Owner: PM/Writer  
  - Deliverable: onboarding runbook
- [T3.2] Run 2 pilot projects using new journey  
  - Owner: CSM lead  
  - Deliverable: pilot results + metrics

### Example – Task Breakdown for Writing Project

**Phase 1 – Research & Outline**

- [W1.1] Collect 10 reference docs and 3 competitor whitepapers  
  - Owner: Writer  
  - Deliverable: annotated references
- [W1.2] Interview 2 internal experts and 2 customers  
  - Owner: Writer  
  - Deliverable: Q&A notes
- [W1.3] Create detailed outline with sections, key points, and figures  
  - Owner: Writer  
  - Deliverable: outline.md

**Phase 2 – Draft & Review**

- [W2.1] Write first full draft (v0.1)  
  - Owner: Writer
- [W2.2] Internal review with SME and marketing lead  
  - Owner: Writer  
  - Deliverable: comments + change requests

**Phase 3 – Polish & Publish**

- [W3.1] Final editing, layout, and graphics  
  - Owner: Writer/Designer
- [W3.2] Publish PDF and landing page  
  - Owner: Marketing  
  - Deliverable: public link

Tasks should be concrete enough that an agent can propose further breakdowns or execute subtasks (e.g., drafting emails, summarizing interviews, outlining documents).

---

## Step 5 – More References (`refs/5_more/`)

`refs/5_more/5_more_references.md` is intentionally light. It is a **parking lot for more examples, links, and templates**.

For your variant, Step 5 should:

- Collect **domain-specific examples**:
  - Example project plans
  - Example specs
  - Example task lists
  - External articles, videos, talks
- Provide **prompt templates** for asking agents to research new methods or patterns.

Over time, Step 5 becomes your “pattern library” for that domain.

---

## Putting It All Together: How to Build a New Spec-Kit Variant

To create a new variant (e.g., `design-kit`, `marketing-kit`, `writing-kit`):

1. **Clone the structure**, not the content
   - Keep the idea of `memory/constitution.md`, `refs/0–5`, and the `spec/plan/tasks` templates.
   - Adjust all references and commands to your new kit name (e.g., `/designkit.specify`).

2. **Write a domain-specific constitution**
   - Start from `memory/constitution.md` as a pattern.  
   - Replace blog-specific language with your domain’s quality standards and principles.  
   - Define what “good” specs, plans, and tasks look like in your field.

3. **Create Step 0–1 references for your domain**
   - Step 0: overview of the domain, recent best practices, and why spec-driven workflows help.  
   - Step 1: distilled principles and patterns.

4. **Adapt Step 2–4 templates**
   - Step 2 (`spec.md`): define personas, problems, goals, constraints for your typical projects.  
   - Step 3 (`plan.md`): define how you plan and measure efforts (phases, strategy, metrics).  
   - Step 4 (`tasks.md`): define how you break work down and assign ownership.

5. **Wire it into your agent commands**
   - Map commands like `/blogkit.specify` → `/[yourkit].specify`.  
   - Make sure each command reads the right references from `refs/` and `memory/`.

6. **Iterate using real projects**
   - Apply your kit to 1–3 real projects in your domain.  
   - Capture where the templates and references helped or failed.  
   - Update `constitution.md`, Step 0–5, and templates based on those learnings.

---

## Example: “Marketing-Kit” in Practice

Imagine you want a variant for B2B marketing campaigns:

- **Constitution:** Defines what “high-quality campaigns” mean (clear ICP, compelling offer, measurable outcomes, ethical practices).
- **Step 0:** Overview of modern B2B marketing patterns (content, paid, social, partnerships).
- **Step 1:** Principles like “One core narrative per campaign,” “Every asset has a single CTA,” “Measure by pipeline, not vanity metrics.”
- **Step 2 (`spec.md`):**
  - Persona, segment, offer, message, channels, success definition.
- **Step 3 (`plan.md`):**
  - Timeline, phases (research → creative → launch → optimize), channel strategy.
- **Step 4 (`tasks.md`):**
  - Concrete tasks: customer interviews, message testing, asset production, channel setup, reporting.
- **Step 5 (`refs/`):**
  - Examples of great campaigns, landing pages, email sequences, and measurement frameworks.

With this pattern, any domain—project management, design, marketing, writing—can have a **Spec Kit–style workflow** that is agent-friendly, repeatable, and grounded in real-world practices.


