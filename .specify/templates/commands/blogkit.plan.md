# /blogkit.plan Command

**Purpose**: Create editorial workflow and technical plan for blog operations.

**Usage**: Run `/blogkit.plan` in Claude Code after spec to define HOW to execute content strategy.

**Status**: PLACEHOLDER - Full implementation in Phase 6 (T046-T053)

This slash command will:
1. Run `.specify/scripts/bash/setup-plan.sh` to create plan.md in feature directory
2. Reference `refs/3_project_mangement_for_plan.md` for blog operations guidance
3. Enforce Simplicity & Focus principle (no custom CMS before 10 posts)
4. Generate plan sections: Editorial Process (4-pass), Tech Stack, Tools & Integrations, AI Discoverability, Distribution Strategy, Analytics
5. Generate `research.md` if NEEDS CLARIFICATION markers exist
6. Generate `quickstart.md` with getting-started guide for first post

**Reference**: See `refs/3_project_mangement_for_plan.md` for guidance on blog operations.
