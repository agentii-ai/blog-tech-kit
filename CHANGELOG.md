# Changelog: Blog-Tech-Kit

All notable changes from spec-kit to blog-tech-kit are documented here.

## [0.0.1] - 2025-12-05

### MVP Release: Blog-Specific Workflow Foundation

#### Added

**New CLI Command**
- `blog` command (separate from spec-kit's `specify`)
- Namespace isolation via `blog-cli` package name

**New Slash Commands (9 Total)**
- `/blogkit.specify` - Content strategy specification (Content-First enforcement)
- `/blogkit.plan` - Editorial workflow + 4-pass quality control
- `/blogkit.tasks` - Sprint-based task generation (175+ tasks for 5-post wave)
- `/blogkit.implement` - Execution with quality gates and progress tracking
- `/blogkit.clarify` - Specification clarification via structured Q&A
- `/blogkit.checklist` - Blog-type-specific quality checklists
- `/blogkit.analyze` - Cross-artifact consistency validation
- `/blogkit.taskstoissues` - Convert tasks to GitHub issues
- `/blogkit.constitution` - Blog governance principles documentation

**New Templates (4 Total)**
- `spec-template.md` - Blog content strategy (ZERO technology mentions)
- `plan-template.md` - Editorial workflow with 4-pass quality control
- `tasks-template.md` - Sprint-based task organization
- `blog-post-template.md` - Individual post structure with AI discoverability (NEW)

**New Directory Structure**
- `.blogkit/` - All blog-tech-kit files (separate from spec-kit's `.specify/`)
- `.blogkit/memory/constitution.md` - Blog governance principles
- `.blogkit/scripts/bash/` - Blog utilities
- `.blogkit/templates/` - Blog-specific templates
- `.blogkit/templates/commands/` - Slash command definitions

**New Reference Documentation**
- `refs/1_principles_for_constitution.md` - 8 Core Blog Principles
- `refs/5_more/blog_principles.md` - Principles framework (798 lines)
- `refs/5_more/blog_operations_guide.md` - Operational guide (934 lines)
- `refs/5_more/blog_strategy_analysis.md` - Case studies and growth data (988 lines)

**New Documentation Files**
- `README.md` - Quick start guide, workflow examples, troubleshooting
- `CHANGELOG.md` - This file
- `CONTRIBUTING.md` - Guidelines for creating kit variants
- `specs/000-blog-tech-kit-foundation/validation-report.md` - Multi-kit validation checklist

#### Changed from Spec-Kit

**Core Principle: Content-First**
- Specification phase focuses ONLY on audience, content pillars, success metrics
- NO technology implementation details allowed in spec.md
- Technology stack defined only in plan.md after content strategy locked in

**Editorial Workflow**
- Added 4-pass quality control: Structural → Clarity → Technical → SEO/AI
- No Self-Validation principle: SME review must be by different person than author
- Sprint-based organization: Sprint 0 (platform) + 5 content sprints
- 6 phases per post: Research, Draft, Technical Review, Copyedit, Publish, Measure

**Templates Adapted for Blogs**
- Removed software development sections
- Added blog-specific sections

**Namespace Strategy**
- `.blogkit/` directory for ALL blog-tech-kit files
- `/blogkit.*` slash commands (instead of `/speckit.*`)
- `blog-cli` package name (instead of `specify-cli`)
- Enables multi-kit coexistence without conflicts

---

**Blog-Tech-Kit v0.0.1**
Status: MVP Ready for Testing
Last Updated: 2025-12-05
