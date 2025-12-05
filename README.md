# Blog-Tech-Kit: AI-Native Blog Specification & Execution Framework

A specialized variant of spec-kit optimized for building high-growth blogs for AI/LLM SaaS products.

**Blog-Tech-Kit** provides:
- 🚀 **Content-First specification** - Define strategy before technology
- 📋 **Editorial workflow orchestration** - 4-pass quality control built-in
- 🎯 **Sprint-based task generation** - 6-phase content production for each post
- 📊 **AI-native optimization** - JSON-LD schema, H2/H3 hierarchy, FAQ sections
- 📈 **Performance tracking** - Built-in measurement gates and iteration
- 🔄 **Multi-kit coexistence** - Runs alongside spec-kit without conflicts

---

## Quick Start

### Installation

```bash
# Install blog-tech-kit from local development
uv tool install blog-cli --from /path/to/blog-tech-kit

# Or from PyPI (when released)
uv tool install blog-cli
```

### Create Your First Blog Project

```bash
# Initialize a new blog project
blog init my-ai-blog

# Or initialize in current directory
blog init --here --force

# Choose your AI agent (Claude Code, Cursor, Windsurf)
blog init my-blog --ai claude
```

### 5-Step Blog Workflow

**Step 1: Review Blog Governance Principles**
```bash
# Establish constitutional principles for your blog
/blogkit.constitution
```

**Step 2: Define Content Strategy (Content-First)**
```bash
# Create spec without any technology mentions
/blogkit.specify "Authority blog for AI/LLM engineers on building production agents"
```

**Step 3: Create Editorial Plan & Tech Stack**
```bash
# Define HOW to execute (4-pass workflow, tech stack, distribution)
/blogkit.plan
```

**Step 4: Generate Sprint-Based Tasks**
```bash
# Break plan into actionable sprints and phases
/blogkit.tasks
```

**Step 5: Execute with Quality Gates**
```bash
# Execute tasks with automated quality checkpoints
/blogkit.implement
```

---

## What Blog-Tech-Kit Provides

### 9 Slash Commands

All commands available in Claude Code, Cursor, Windsurf:

| Command | Purpose |
|---------|---------|
| `/blogkit.constitution` | Define blog governance principles (8 Core Blog Principles) |
| `/blogkit.specify` | Create blog content strategy specification (no tech details) |
| `/blogkit.plan` | Design editorial workflow and technology stack |
| `/blogkit.tasks` | Generate sprint-based content production tasks |
| `/blogkit.implement` | Execute tasks with quality gates and progress tracking |
| `/blogkit.clarify` | Resolve underspecified requirements through Q&A |
| `/blogkit.checklist` | Generate blog-type-specific quality checklists |
| `/blogkit.analyze` | Validate consistency between spec → plan → tasks |
| `/blogkit.taskstoissues` | Convert tasks to GitHub issues for team tracking |

### 4 Specialized Templates

Located in `.blogkit/templates/`:

1. **spec-template.md** - Blog content strategy (no CMS/framework mentions)
2. **plan-template.md** - Editorial workflow + 4-pass quality control
3. **tasks-template.md** - Sprint-based task organization (175+ tasks for 5-post wave)
4. **blog-post-template.md** - Individual post structure with AI discoverability

### 10 Reference Guides

Located in `refs/`:

- `0_overview.md` - Successful AI/LLM blog examples (Anthropic, LangChain, Hugging Face)
- `1_principles_for_constitution.md` - 8 Core Blog Principles with examples
- `2_define_for_specify.md` - Blog writing best practices
- `3_project_mangement_for_plan.md` - Editorial operations guide
- `4_pm_tasking_for_tasks.md` - Task methodology for blogs
- `6_claude_code.md` - Claude Code integration guide
- `5_more/*` - Additional deep-dive resources (operations, strategy, tasking)

---

## Core Concepts

### 1. Content-First Principle

**Definition**: Technology choices are made AFTER content strategy is defined.

- **Spec Phase**: Focus on audience, content pillars, success metrics (ZERO tech details)
- **Plan Phase**: Choose CMS, framework, hosting based on content needs
- **Implementation**: Build platform to serve content strategy, not vice versa

### 2. 4-Pass Editorial Workflow

Each post goes through systematic quality control:

1. **Structural Edit** - Does outline match content? Is flow logical?
2. **Clarity Edit** - Are concepts explained? Is jargon appropriate?
3. **Technical Review** - Are code examples tested? Are facts current? (by SME, not author)
4. **SEO & AI Optimization** - Are keywords placed? Are headings hierarchical? Is FAQ present?

### 3. Sprint-Based Organization

Blog production organized by 5-post wave:

- **Sprint 0**: Platform setup (18 tasks)
- **Sprints 1-5**: Five content posts (38 tasks each)
- **6 Phases per Post**: Research, Draft, Technical Review, Copyedit, Publish, Measure

### 4. 8 Core Blog Principles

All decisions validated against:

1. **Content-First** - Tech chosen after strategy
2. **No Self-Validation** - SME review by different person than author
3. **Simplicity & Focus** - No custom CMS before 10 posts
4. **AI-Native Distribution** - JSON-LD, H2/H3 hierarchy, FAQ sections
5. **Community Over Broadcast** - Amplify community voices
6. **Transparency Over Perfection** - Share failure modes honestly
7. **Long-term Over Quick Wins** - Design for 2-3 year compounding
8. **Measurable Outcomes** - Every success criterion tracked

---

## Blog Types

### Authority Blog
**Goal**: Establish company as canonical reference
**Cadence**: 1-2 posts/month
**Length**: 2,000-4,000 words
**ROI Timeline**: 6-12 months
**Examples**: Anthropic, OpenAI, LangChain

### Practitioner Blog
**Goal**: Help developers solve real problems
**Cadence**: 2-4 posts/month
**Length**: 800-1,500 words
**ROI Timeline**: 1-3 months
**Examples**: LangChain, LlamaIndex, Together AI

### Community Blog
**Goal**: Amplify user stories and contributor spotlights
**Cadence**: 1-2 posts/month
**Length**: 1,200-1,800 words
**ROI Timeline**: Ongoing engagement
**Examples**: Hugging Face, Open Source projects

### Thought Leadership
**Goal**: Executive perspective and industry analysis
**Cadence**: 1-2 posts/month
**Length**: 1,500-2,500 words
**ROI Timeline**: 4-6 months + brand building
**Examples**: Industry leaders, research groups

---

## Multi-Kit Coexistence

Blog-tech-kit runs alongside spec-kit without conflicts:

### Namespace Separation

| Component | Blog-Tech-Kit | Spec-Kit |
|-----------|---------------|----------|
| **CLI Command** | `blog` | `specify` |
| **Project Directory** | `.blogkit/` | `.specify/` |
| **Constitution** | `.blogkit/memory/constitution.md` | `.specify/memory/constitution.md` |
| **Slash Commands** | `/blogkit.*` | `/speckit.*` |
| **Templates** | `.blogkit/templates/` | `.specify/templates/` |

### Key Features

✅ Both kits installed simultaneously
✅ Separate CLI commands (`blog` vs `specify`)
✅ Separate project directories (`.blogkit/` vs `.specify/`)
✅ Distinct slash commands (`/blogkit.*` vs `/speckit.*`)
✅ Clean kit switching with `blog init --here --force`

---

## Project Structure

```
my-ai-blog/
├── .blogkit/
│   ├── memory/
│   │   └── constitution.md          # Blog governance principles
│   ├── scripts/
│   │   └── bash/                    # Blog-specific utilities
│   ├── templates/
│   │   ├── spec-template.md
│   │   ├── plan-template.md
│   │   ├── tasks-template.md
│   │   ├── blog-post-template.md
│   │   └── commands/                # Slash command templates
│   └── execution-state.md           # Progress tracking during /blogkit.implement
├── .claude/
│   └── commands/                    # Slash commands (blogkit.*.md files)
├── refs/                            # Reference documentation
├── specs/
│   └── 001-authority-blog/
│       ├── spec.md                  # Content strategy (ZERO tech details)
│       ├── plan.md                  # Editorial workflow + tech stack
│       ├── tasks.md                 # Sprint-based task breakdown
│       ├── research.md              # Phase 0 research (if needed)
│       ├── editorial-guide.md       # Style guide, tone, voice
│       ├── content-calendar.md      # Content planned for next 6 months
│       └── analysis-report.md       # Cross-artifact consistency report
├── blog/                            # Your actual blog repository
│   ├── posts/
│   ├── pages/
│   └── [your blog platform]
└── README.md                        # Project documentation
```

---

## Workflow Examples

### Example 1: Authority Blog for AI/LLM Engineers

```bash
# Step 1: Initialize project
blog init ai-systems-blog

# Step 2: Define governance
/blogkit.constitution

# Step 3: Write strategy (no technology!)
/blogkit.specify "Build authority blog on production AI agents"

# Step 4: Plan editorial workflow
/blogkit.plan

# Step 5: Generate tasks
/blogkit.tasks

# Step 6: Execute with quality gates
/blogkit.implement
```

### Example 2: Practitioner Blog with Tutorials

```bash
# Similar flow, but focus on:
# - Shorter posts (800-1,200 words)
# - Code-heavy examples
# - Quick ROI (1-3 months)
# - 2-4 posts/month cadence
```

---

## Troubleshooting

### "blog command not found"
```bash
# Reinstall the tool
uv tool install blog-cli --from /path/to/blog-tech-kit --force
```

### Slash commands not appearing in Claude Code
```bash
# Ensure .claude/commands/ directory exists
mkdir -p .claude/commands/

# Ensure blogkit.*.md files are in the directory
ls .blogkit/templates/commands/
```

### Constitution file not found
```bash
# Ensure .blogkit/memory/ directory exists
mkdir -p .blogkit/memory/

# Run /blogkit.constitution to create it
```

### Spec contains technology details (violates Content-First)
```bash
# This will fail /blogkit.specify validation
# Solution: Remove CMS, framework, hosting mentions
# Focus on audience, problems, content pillars instead
```

### Namespace conflicts with spec-kit
```bash
# Verify directory structure:
ls -la | grep "\\.blogkit"   # Should exist for blog-tech-kit
ls -la | grep "\\.specify"   # Should exist for spec-kit

# If conflicts occur, run:
blog init --here --force     # To switch to blog-tech-kit
```

---

## Quick Reference: Blog Success Targets

### Authority Blog Performance
- **Week 1**: 500-1K pageviews
- **Month 1**: 2-5K pageviews
- **Month 3**: 5-20K pageviews
- **Goal**: 5-10 backlinks per post

### Practitioner Blog Performance
- **Week 1**: 200-500 pageviews
- **Month 1**: 1-3K pageviews
- **Month 3**: 3-10K pageviews
- **Goal**: 3-5 backlinks, high tutorial completion

### Community Blog Performance
- **Week 1**: 100-300 pageviews
- **Month 1**: 500-2K pageviews
- **Focus**: Engagement over raw traffic

### Thought Leadership
- **Week 1**: 300-1K pageviews
- **Month 1**: 2-5K pageviews
- **Focus**: Media citations, speaking invitations

---

## For Future Kit Creators

See `CONTRIBUTING.md` for guidelines on creating new kit variants (PM-Kit, Design-Kit, etc.).

The namespace strategy established in blog-tech-kit enables:
- ✅ Multiple kit installation
- ✅ Distinct CLI commands per kit
- ✅ Dedicated project directories per kit
- ✅ Isolated slash commands per kit
- ✅ Easy kit switching

---

## Support & Documentation

- **Installation**: See "Quick Start" section above
- **Constitutional Principles**: See `refs/1_principles_for_constitution.md`
- **Blog Writing Best Practices**: See `refs/2_define_for_specify.md`
- **Editorial Operations**: See `refs/3_project_mangement_for_plan.md`
- **Task Methodology**: See `refs/4_pm_tasking_for_tasks.md`
- **Claude Code Integration**: See `refs/6_claude_code.md`

---

## License

MIT License - See LICENSE file

## Contributing

See CONTRIBUTING.md for guidelines on contributing to blog-tech-kit

---

**Version**: v0.0.1
**Last Updated**: 2025-12-05
**Status**: MVP Ready for Testing
