---
description: Convert content production tasks into GitHub issues with dependencies.
handoffs:
  - label: View Issues
    agent: blogkit.implement
    prompt: Execute tasks via GitHub issues
    send: true
---

## Outline

Convert tasks.md into actionable GitHub issues maintaining structure and dependencies:

1. **Load tasks.md**: Parse sprints, phases, dependencies, and task details

2. **Create GitHub Issues for Each Task**:
   - Issue title: `[SPRINT] [PHASE] Task description`
   - Issue body: Full task description with acceptance criteria
   - Labels: Sprint-based (sprint-0, sprint-1, etc.) + Phase-based (research, draft, review, copyedit, publish, measure)
   - Milestone: Set per content sprint (Sprint 0, Sprint 1, etc.)

3. **Link Dependencies**:
   - Identify sequential tasks and create "blocks" relationships
   - Add comments linking related tasks
   - Document parallel execution opportunities with labels

4. **Assign Roles**:
   - Add assignee based on task type:
     - Research/Outline tasks → Writer
     - Draft tasks → Writer
     - Technical Review → SME
     - Copyedit/SEO → Copyeditor
     - Publish/Distribute → Marketing
     - Measurement → Analytics/Owner

5. **Add Acceptance Criteria**:
   - Each issue includes checkbox list for task completion
   - Clear "Definition of Done" for each task type

6. **Create Epic Issues**:
   - One epic per sprint (Sprint 0 Epic, Sprint 1 Epic, etc.)
   - Link all sprint tasks as child issues
   - Track sprint progress at epic level

7. **Generate Summary**:
   - Show issue count by sprint and phase
   - Display GitHub project/milestone links
   - Provide workflow for team to track progress

**NOTE**: GitHub issues enable team collaboration and progress tracking.
