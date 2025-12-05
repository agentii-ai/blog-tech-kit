---
description: Analyze cross-artifact consistency between spec, plan, and tasks.
handoffs:
  - label: Update Specification
    agent: blogkit.specify
    prompt: Revise spec based on consistency analysis findings
    send: true
  - label: Refine Plan
    agent: blogkit.plan
    prompt: Refine editorial plan based on consistency analysis findings
    send: true
---

## Outline

Perform comprehensive cross-artifact consistency analysis:

1. **Load all artifacts**: spec.md, plan.md, tasks.md (and research.md if exists)

2. **Content-First Validation**:
   - Verify spec.md contains ZERO technology implementation details
   - Verify plan.md contains all tech stack decisions
   - Flag any technology mentions in spec.md

3. **Requirement Traceability**:
   - Map each requirement (CR-001 to CR-020) from spec.md to plan.md sections
   - Map each plan section to tasks.md sprint/phase
   - Identify requirements with no corresponding tasks (coverage gaps)

4. **Success Criteria Alignment**:
   - Verify all success criteria (SC-001 to SC-016) from spec.md are addressed in plan.md
   - Check that tasks.md includes measurement tasks for each SC
   - Identify success criteria without tracking implementation

5. **Blog Type Consistency**:
   - Verify blog type is consistent across all three documents
   - Check editorial workflow matches blog type (Authority 6-week vs. Practitioner 2-week)
   - Verify content pillars mentioned in plan match spec

6. **Timeline & Sprint Consistency**:
   - Verify Sprint 0 duration matches plan.md platform setup timeline
   - Check sprint count (should be 5 content sprints per plan)
   - Validate sprint dependencies align between plan and tasks

7. **Team & Role Consistency**:
   - Verify roles defined in plan.md (Writer, SME, Copyeditor, Marketing) are referenced in tasks
   - Check task assignments match role responsibilities

8. **Constitution Principle Enforcement**:
   - Verify all 8 Blog Principles are addressed in plan.md Constitution Check section
   - Check that tasks.md includes quality gate checkpoints
   - Ensure no Self-Validation principle enforced (SME review in tasks)

9. **Dependency Analysis**:
   - Map task dependencies in tasks.md
   - Verify Sprint 0 is prerequisite for all content sprints
   - Check that measurement tasks reference analytics from plan

10. **Generate Analysis Report**:
    - Create markdown report at `FEATURE_DIR/analysis-report.md`
    - List all consistency checks passed/failed
    - For failures, show specific lines/sections that conflict
    - Provide remediation recommendations
    - Calculate "Consistency Score" (% of checks passed)

11. **Report Results**:
    - Display consistency score
    - List any gaps found (requirements not addressed in tasks)
    - List any inconsistencies (conflicting information)
    - Show overall assessment (PASS/FAIL/REVIEW_RECOMMENDED)
    - If issues found, ask user: "Review and fix issues, then re-run analyze?"

**NOTE**: Cross-artifact analysis catches planning gaps before execution starts.
