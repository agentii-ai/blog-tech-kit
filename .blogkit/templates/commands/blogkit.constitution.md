---
description: Create or update blog governance principles in the project constitution.
handoffs:
  - label: Define Specification
    agent: blogkit.specify
    prompt: Create blog content strategy aligned with constitution principles
    send: true
---

## Outline

Create or update blog-specific governance principles:

1. **Load or Create constitution.md**:
   - Check if `.blogkit/memory/constitution.md` exists
   - If exists, read and present current principles
   - If new, create with template structure

2. **Present 8 Core Blog Principles**:
   - **Content-First**: Technology choices made AFTER content strategy defined
   - **No Self-Validation**: Technical reviews done by non-authors (avoid groupthink)
   - **Simplicity & Focus**: No custom CMS before 10 published posts (avoid over-engineering)
   - **AI-Native Distribution**: JSON-LD schema, H2/H3 hierarchy, FAQ sections for LLM discoverability
   - **Community Over Broadcast**: Amplify community voices, feature contributors
   - **Transparency Over Perfection**: Share edge cases and failure modes honestly
   - **Long-term Over Quick Wins**: Design for 2-3 year compounding, not viral moments
   - **Measurable Outcomes**: Every success criterion has tracking implementation

3. **Get User Input** (if creating new):
   - Ask which principles are most important for their blog
   - Ask for principle customizations/additions specific to their domain
   - Offer preset profiles (Authority Blog, Practitioner Blog, Community Blog, Thought Leadership)

4. **Document Principles** in constitution.md sections:
   - **Blog Governance Framework**: Core principles and definitions
   - **Content Strategy Principles**: How content is selected and created
   - **Quality Gates**: Validation checkpoints (Content-First, Simplicity & Focus, Constitution Check)
   - **Editorial Roles & Responsibilities**: Writer, SME, Copyeditor, Marketing
   - **Success Metrics**: How blog success is measured
   - **Constraints & Guidelines**: What will/won't be published
   - **Review & Acceptance Checklist**: 10-item gate for content acceptance

5. **Link to Templates**:
   - Reference principles in spec-template, plan-template, tasks-template
   - Show how principles gate decisions in each phase

6. **Report Completion**:
   - Show constitution file path and size
   - List all principles documented
   - Show recommended next step: `/blogkit.specify` to create first blog content spec

**NOTE**: Constitution principles guide all downstream decisions. Establish early.
