# /blogkit.analyze Command

**Purpose**: Perform cross-artifact consistency analysis across spec, plan, and tasks.

**Usage**: Run `/blogkit.analyze` in Claude Code after task generation to validate consistency.

**Status**: PLACEHOLDER - Full implementation in Phase 9 (T079-T080)

This slash command will:
1. Check consistency between spec.md, plan.md, tasks.md
2. Identify gaps (requirements in spec not addressed in plan or tasks)
3. Identify inconsistencies (conflicting success metrics, missing dependencies)
4. Generate analysis report with recommendations

**Reference**: See `refs/` documentation for consistency validation criteria.
