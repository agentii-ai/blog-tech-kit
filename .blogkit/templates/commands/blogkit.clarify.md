# /blogkit.clarify Command

**Purpose**: Identify underspecified areas in blog content spec through structured Q&A.

**Usage**: Run `/blogkit.clarify` in Claude Code after creating spec to resolve ambiguities.

**Status**: PLACEHOLDER - Full implementation in Phase 9 (T074-T076)

This slash command will:
1. Analyze current spec.md for underspecified requirements
2. Ask maximum 3 clarification questions prioritized by impact (scope > quality > distribution)
3. Document clarifications in spec.md "Clarifications" section
4. Focus on blog-specific ambiguities (target audience, content pillars, success metrics)

**Reference**: See `refs/2_define_for_specify.md` for common blog specification ambiguities.
