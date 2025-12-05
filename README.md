<div align="center">
    <img src="./media/logo.png" alt="Blog-Tech-Kit Logo" width="200" height="200"/>
    <h1>📝 Blog-Tech-Kit</h1>
    <h3><em>Build authority blogs faster with AI agents.</em></h3>
</div>

<p align="center">
    <strong>A spec-driven toolkit for systematic blog content strategy and execution, built on the foundations of spec-kit.</strong>
</p>

<p align="center">
    <a href="https://github.com/agentii-ai/blog-tech-kit/actions"><img src="https://img.shields.io/badge/status-alpha-orange" alt="Status"/></a>
    <a href="https://github.com/agentii-ai/blog-tech-kit/stargazers"><img src="https://img.shields.io/github/stars/agentii-ai/blog-tech-kit?style=social" alt="GitHub stars"/></a>
    <a href="https://github.com/agentii-ai/blog-tech-kit/blob/main/LICENSE"><img src="https://img.shields.io/github/license/agentii-ai/blog-tech-kit" alt="License"/></a>
    <a href="https://kits.agentii.ai"><img src="https://img.shields.io/badge/kits-agentii.ai-blue" alt="Kit Variants"/></a>
</p>

---

## 📝 What is Blog-Tech-Kit?

**Blog-Tech-Kit** is a specialized variant of [**Spec-Kit**](https://github.com/github/spec-kit), adapted for blog content strategy and execution for AI SaaS products.

While Spec-Kit enables spec-driven software development with AI agents, **Blog-Tech-Kit applies the same methodology to the domain of technical blogging, content marketing, and authority building**—helping founders and content teams build authority blogs through structured, AI-assisted workflows instead of ad-hoc content creation.

### Key Differences from Spec-Kit

| Aspect | Spec-Kit | Blog-Tech-Kit |
|--------|----------|---------------|
| **Focus** | Software feature development | Blog content strategy & execution |
| **Primary Workflow** | Specification → Plan → Code → Test | Specification → Plan → Tasks → Publish |
| **Success Metrics** | Code quality, test coverage, performance | Traffic, engagement, authority, conversions |
| **Deliverables** | Production software & APIs | Published posts, content pillars, distribution |
| **CLI Command** | `specify` | `blog` |
| **Agent Commands** | `/speckit.*` | `/blogkit.*` |

---

## 🚀 Get Started

### 1. Install Blog-Tech-Kit

Choose your preferred installation method:

#### Option 1: One-Time Usage (Recommended)

Run directly without installing—always uses the latest version:

```bash
uvx --from git+https://github.com/agentii-ai/blog-tech-kit.git blog init my-blog
uvx --from git+https://github.com/agentii-ai/blog-tech-kit.git blog check
```

> **Note**: This project is improving rapidly. We recommend `uvx` to always get the latest features and fixes.

![One-time installation with uvx](./media/test1.png)

*Running `blog init` shows an interactive wizard to select your AI assistant*

#### Option 2: Persistent Installation

Install once and use everywhere (may require periodic updates):

```bash
uv tool install blog-cli --from git+https://github.com/agentii-ai/blog-tech-kit.git
```

Then use the tool directly:

```bash
blog init my-blog
blog check
```

To update to the latest version:

```bash
uv tool install blog-cli --force --from git+https://github.com/agentii-ai/blog-tech-kit.git
```

### 2. Initialize Your First Blog Project

```bash
blog init my-ai-blog
cd my-ai-blog
```

This creates a project with blog-specific templates, constitution, and agent commands.

![Successful blog project initialization](./media/test2.png)

*After setup completes, you'll see all available slash commands and next steps*

### 3. Launch Your AI Agent

Open your AI assistant (Claude Code, Cursor, Windsurf, etc.) in the project directory. You'll see `/blogkit.*` commands available:

```bash
/blogkit.constitution    # Establish blog-specific principles
/blogkit.specify         # Define content strategy (audience, pillars, cadence)
/blogkit.clarify         # Resolve ambiguities in your strategy
/blogkit.plan            # Create editorial workflow & technical plan
/blogkit.tasks           # Generate content production tasks
/blogkit.implement       # Execute content strategy workflow
```

### 4. Run Your First Blog Content Strategy Workflow

```bash
/blogkit.specify Build an authority blog for AI/LLM developers, focusing on practical tutorials, architecture patterns, and production deployment guides
```

This generates a blog specification with:
- Blog type declaration (authority, product, thought leadership)
- Target audience (role, company, tools, environment)
- Content pillars (3-5 core topics)
- Publishing cadence and success criteria
- Distribution requirements and constraints

---

## 🤖 Supported AI Agents

Blog-Tech-Kit works with all agents supported by Spec-Kit:

| Agent | Support | Notes |
|-------|---------|-------|
| [Claude Code](https://www.anthropic.com/claude-code) | ✅ | Native support |
| [Cursor](https://cursor.sh/) | ✅ | Full integration |
| [Windsurf](https://windsurf.com/) | ✅ | Complete support |
| [Gemini CLI](https://github.com/google-gemini/gemini-cli) | ✅ | Verified working |
| [GitHub Copilot](https://github.com/features/copilot) | ✅ | Compatible |
| [Qoder CLI](https://qoder.com/cli) | ✅ | Supported |
| Plus 5+ additional agents | ✅ | See Spec-Kit docs |

---

## 📦 Blog-Tech-Kit Templates

Blog-Tech-Kit provides project templates for 18 AI coding agents, automatically downloaded when you run `blog init`. Each template includes:

- **Blog-Tech-Kit Constitution v1.0.0** with 8 blog-specific principles
- **Workflow templates**: spec.md, plan.md, tasks.md for content documentation
- **9 slash commands**: /blogkit.specify, /blogkit.plan, /blogkit.tasks, /blogkit.implement, /blogkit.clarify, /blogkit.analyze, /blogkit.checklist, /blogkit.taskstoissues, /blogkit.constitution
- **Scripts**: Bash or PowerShell variants for automation
- **Memory system**: constitution.md for project-specific principles

### Supported Template Agents

Templates are available for all 18 agents in both bash and PowerShell variants (36 total):

- Claude Code • Cursor Agent • Windsurf • Google Gemini
- GitHub Copilot • Qoder • Qwen • OpenCode
- Codex • KiloCode • Auggie • CodeBuddy
- AMP • Shai • Amazon Q • Bob • Roo

See [GitHub Releases](https://github.com/agentii-ai/blog-tech-kit/releases) for downloadable template archives with SHA-256 checksums.

---

## 📝 Core Blog Workflow

### Phase 1: Specification (`/blogkit.specify`)

Define **WHAT** you're building and **WHY**:
- Blog type declaration (authority, product, thought leadership)
- Target audience (role/skill, company, tools, environment)
- Content pillars (3-5 core topics)
- Publishing cadence
- Success criteria (traffic, engagement, conversions)
- Distribution requirements

### Phase 2: Clarification (`/blogkit.clarify`)

Resolve ambiguities before committing to execution:
- Validate audience sharpness
- Clarify content pillars and topics
- Define success metrics precisely
- Identify unstated assumptions

### Phase 3: Planning (`/blogkit.plan`)

Define **HOW** you'll execute content strategy:
- Editorial process (4-pass: research, draft, review, publish)
- Tech stack (CMS, framework, hosting)
- Tools & integrations
- AI discoverability (SEO, schema, LLM optimization)
- Distribution strategy
- Analytics & instrumentation

### Phase 4: Task Breakdown (`/blogkit.tasks`)

Generate actionable content production tasks:
- Sprint 0: Platform setup
- Sprint 1: Foundation post 1
- Sprint 2: Foundation post 2
- Validation checkpoints (analytics review, SEO check, engagement review)

### Phase 5: Execution (`/blogkit.implement`)

Execute content production systematically with AI assistance:
- Execute tasks in dependency order
- Check quality gates (SEO metadata, code examples, analytics)
- Validate checkpoints
- Track progress and provide updates

---

## 🌟 Blog-Tech-Kit Constitution

Blog-Tech-Kit is built on 8 core principles that guide all content work:

### I. Content-First Approach
Define content strategy (audience, pillars, voice) **before** choosing technology.

### II. AI-Native Distribution
Optimize for both human readers AND LLM/AI discovery (structured data, clear hierarchies).

### III. Simplicity & Focus
No custom CMS before 10 posts. Use proven tools, avoid over-engineering.

### IV. Iterative Validation
Follow publish-measure-learn cycles with independent, testable content increments.

### V. Evidence-Driven Optimization
Support all content decisions with analytics data—not opinions or assumptions.

### VI. Quality Gates
Enforce editorial standards (SEO metadata, code testing, technical review) at each phase.

### VII. Kit Namespace Isolation
Enable multiple kit variants (`blog-tech-kit`, `spec-kit`, `pmf-kit`) to coexist without conflicts.

### VIII. Template Extensibility
Serve as a reference implementation for creating domain-specific kit variants.

See [`.blogkit/memory/constitution.md`](./.blogkit/memory/constitution.md) for full details.

---

## 📚 Reference Documentation

Blog-Tech-Kit includes comprehensive reference materials to guide your content strategy:

- **`refs/0_overview.md`** - Overview of successful AI/LLM SaaS blogs
- **`refs/1_principles_for_constitution.md`** - Blog-specific principles and patterns
- **`refs/2_define_for_specify.md`** - How to structure sharp blog specifications
- **`refs/3_project_mangement_for_plan.md`** - Editorial workflow and blog operations
- **`refs/4_pm_tasking_for_tasks.md`** - Content production task patterns
- **`refs/6_claude_code.md`** - Claude Code integration guide

---

## 🔧 Multi-Kit Installation

Blog-Tech-Kit is designed to coexist with Spec-Kit and other kit variants:

```bash
# Install Spec-Kit for software development
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git

# Install Blog-Tech-Kit for content strategy
uv tool install blog-cli --from git+https://github.com/agentii-ai/blog-tech-kit.git

# Both tools work independently
specify check    # Shows Spec-Kit configuration
blog check       # Shows Blog-Tech-Kit configuration

# Create projects with different kits
specify init my-feature           # Software feature project
blog init my-blog                 # Blog content project
```

In your AI agent, both command namespaces are available:
- `/speckit.*` commands for software development workflows
- `/blogkit.*` commands for blog content workflows

---

## 🎛️ CLI Reference

### `blog init` - Initialize Blog Project

```bash
blog init <PROJECT_NAME>
blog init my-blog --ai claude
blog init . --here --force        # Initialize in current directory
blog init my-blog --ai cursor --script ps   # PowerShell scripts
```

**Options:**
- `--ai` - Specify AI assistant (claude, cursor, windsurf, gemini, etc.)
- `--script` - Script variant (sh for bash/zsh, ps for PowerShell)
- `--here` - Initialize in current directory
- `--force` - Skip confirmation when directory has files
- `--no-git` - Skip git initialization
- `--ignore-agent-tools` - Skip tool availability checks

### `blog check` - Verify Installation

```bash
blog check
```

Verifies Blog-Tech-Kit installation and checks for required tools (git, claude, cursor, windsurf, etc.).

---

## 🚀 Examples by Blog Type

### Authority Blog (Anthropic, LangChain, Hugging Face style)

```
blog init ai-authority-blog
/blogkit.specify "Build an authority blog for ML engineers, covering LLM fine-tuning, RAG architectures, and production deployment"
```

Expected artifacts:
- Audience: ML engineers at 50-500 person tech companies
- Pillars: LLM Fine-tuning, RAG Patterns, Production ML
- Hero post: "Complete Guide to Fine-tuning LLMs for Production"
- Success metric: Organic traffic, time-on-page, newsletter signups

### Product Blog (Cursor, Vercel style)

```
blog init product-blog
/blogkit.specify "Create a product blog showcasing AI coding assistant features and user success stories"
```

Expected artifacts:
- Audience: Developers evaluating AI coding tools
- Pillars: Feature Deep Dives, User Stories, Best Practices
- Hero post: "How Company X Reduced Code Review Time by 60%"
- Success metric: Trial signups, feature adoption, NPS

### Thought Leadership Blog (a]16z, Sequoia style)

```
blog init thought-leadership
/blogkit.specify "Build a thought leadership blog on AI market trends and startup patterns"
```

---

## 📖 Learn More

- **[Blog-Tech-Kit Specification](./specs/000-blog-tech-kit-foundation/spec.md)** - Full feature specification
- **[Blog-Tech-Kit Implementation Plan](./specs/000-blog-tech-kit-foundation/plan.md)** - Technical implementation details
- **[Spec-Kit Repository](https://github.com/github/spec-kit)** - Upstream project for software development
- **[Spec-Driven Development Methodology](https://github.com/github/spec-kit/blob/main/spec-driven.md)** - Core methodology

---

## 🏗️ Project Structure

```
blog-tech-kit/
├── .claude/commands/          # Claude Code slash commands
│   ├── blogkit.constitution.md
│   ├── blogkit.specify.md
│   ├── blogkit.plan.md
│   ├── blogkit.tasks.md
│   ├── blogkit.implement.md
│   ├── blogkit.clarify.md
│   ├── blogkit.analyze.md
│   └── blogkit.checklist.md
├── .blogkit/
│   ├── memory/
│   │   └── constitution.md    # Blog-Tech-Kit principles (v1.0.0)
│   ├── templates/
│   │   ├── spec-template.md   # Blog specification template
│   │   ├── plan-template.md   # Editorial planning template
│   │   ├── tasks-template.md  # Content task breakdown template
│   │   ├── blog-post-template.md  # Blog post structure template
│   │   └── commands/          # Agent command templates
│   └── scripts/
│       ├── bash/              # Bash automation scripts
│       └── powershell/        # PowerShell automation scripts
├── refs/                      # Reference documentation
│   ├── 0_overview.md
│   ├── 1_principles_for_constitution.md
│   ├── 2_define_for_specify.md
│   ├── 3_project_mangement_for_plan.md
│   ├── 4_pm_tasking_for_tasks.md
│   └── 5_more/                # Additional guides
└── specs/
    └── 000-blog-tech-kit-foundation/   # Feature specification & implementation docs
```

---

## 🔧 Prerequisites

- **Linux/macOS/Windows**
- [Supported](#-supported-ai-agents) AI coding agent
- [uv](https://docs.astral.sh/uv/) for package management
- [Python 3.11+](https://www.python.org/downloads/)
- [Git](https://git-scm.com/downloads)

### Verify Your Setup

Run `blog check` to verify all prerequisites and see which AI agents are available:

```bash
blog check
```

---

## 🌐 Creating Your Own Kit Variant

Blog-Tech-Kit demonstrates how to adapt spec-driven methodology to any domain. Want to create a variant for product design, marketing, or business writing?

See [`refs/instructions.md`](./refs/instructions.md) for a comprehensive guide on:
- How to fork and adapt spec-kit for your domain
- How to define domain-specific principles
- How to create templates and reference materials
- How to enable multi-kit coexistence

**Example variants:**
- **`pmf-kit`** - Product-market-fit discovery workflows
- **`pd-kit`** - Product design and UX workflows
- **`marketing-kit`** - Go-to-market and growth campaigns
- **`ops-kit`** - Operations and project management

All variants are published at [**kits.agentii.ai**](https://kits.agentii.ai).

---

## 🙏 Acknowledgements

Blog-Tech-Kit is built on the excellent work of the [**Spec-Kit**](https://github.com/github/spec-kit) project from GitHub. We preserve 100% of Spec-Kit's architecture and infrastructure while adapting templates and methodology for blog content strategy.

**Spec-Kit Credits:**
- [Den Delimarsky](https://github.com/localden)
- [John Lam](https://github.com/jflam)

---

## 💬 Support

For issues, questions, or feedback:

- **GitHub Issues**: [Report on Blog-Tech-Kit](https://github.com/agentii-ai/blog-tech-kit/issues)
- **Spec-Kit Issues**: [Report on Spec-Kit](https://github.com/github/spec-kit/issues)
- **Kit Variants**: [Visit kits.agentii.ai](https://kits.agentii.ai)

---

## 📄 License

This project is licensed under the terms of the MIT open source license. See [LICENSE](./LICENSE) for details.

**Note**: Blog-Tech-Kit extends Spec-Kit's MIT license. For Spec-Kit license details, see [Spec-Kit LICENSE](https://github.com/github/spec-kit/blob/main/LICENSE).

---

## 🌟 Why Blog-Tech-Kit?

### For Founders & Content Teams:
- **Systematic**: Replace ad-hoc content creation with structured, specification-driven workflows
- **AI-Assisted**: Leverage AI agents for specification, planning, and content production
- **Validated**: Reference templates based on proven blog patterns from Anthropic, LangChain, Hugging Face, and other successful AI companies
- **Evidence-Driven**: Focus on analytics data and measurable outcomes, not opinions

### For the Open Source Community:
- **Reproducible**: Spec-driven workflows are more transparent and collaborative than ad-hoc processes
- **Extensible**: Blog-Tech-Kit serves as a reference for creating domain-specific kit variants
- **Community-Friendly**: All templates and reference materials are open source and MIT-licensed
- **Professional**: Built on proven Spec-Kit infrastructure, adapted by experienced content strategists

---

**Ready to build your authority blog with confidence?**

```bash
blog init my-blog
```

Let's build blogs that establish authority, with evidence guiding every content decision.

---
